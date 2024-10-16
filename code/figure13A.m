%% figure13A.m
% 
% Produce figure 13A
%
%% Description
%
% This script produces figure 13A and associated numerical results. The figure displays two variants of the quarterly FERU in the United States, 1951Q1–2019Q4. The variants are computed as follows:
%
% * With simple formula (2)
% * With generalized formula (8) calibrated as in Michaillat and Saez (2021a)
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure13A.pdf – PDF file with figure 13A
% * figure13A.csv – CSV file with data underlying figure 13A
% * figure13A.md – Markdown file with numerical results from figure 13A
%

%% Specify figure name and output files

% Define figure number
number = '13A';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1951 : 0.25 : 2019.75]';

% Get recession dates
[startRecession, endRecession] = getRecessionPostwar(inputFolder);

% Get unemployment rate
u = getUnemploymentPostwar(inputFolder);

% Get vacancy rate
v = getVacancyPostwar(inputFolder);

%% Compute FERU with simple formula (2)

uStar = sqrt(u .* v);

%% Calibrate model parameters as in Michaillat and Saez (2021a)

% Calibrate Beveridge elasticity
epsilon = getElasticity(inputFolder);

% Calibrate recruiting cost
kappa = 0.92;

% Calibrate social product of unemployed labor
zeta = 0.26;

%% Compute FERU with generalized formula (8)

uStarGeneralized = (kappa .* epsilon .* v .* (u.^epsilon) ./ (1 - zeta)).^(1 ./ (1 + epsilon));

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xPostwar{:})

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick =  [0:0.02:0.08];
ax.YTickLabel = ['0%'; '2%'; '4%'; '6%'; '8%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot FERUs
h1 = plot(timeline, uStarGeneralized);
plot(timeline, uStar, pinkLine{:})

% Format FERUs
h1.Color = pinkLight;
h1.LineWidth = thick;
h1.LineStyle = '-.';

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year',  'FERU', 'Generalized FERU'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, uStar, uStarGeneralized];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
distanceMean = mean(uStarGeneralized - uStar);
[distanceMax, iMax] = max(uStarGeneralized - uStar);
[distanceMin, iMin] = min(uStarGeneralized - uStar);

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average distance between FERUs: %4.3f \n', distanceMean)
fprintf('* Maximum distance between FERUs: %4.3f in %4.2f \n', distanceMax, timeline(iMax))
fprintf('* Minimum distance between FERUs: %4.3f in %4.2f \n', distanceMin, timeline(iMin))
fprintf('\n')
diary off