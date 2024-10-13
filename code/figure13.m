%% figure13.m
% 
% Produce figure 13
%
%% Description
%
% This script produces figure 13 and associated numerical results. The figure displays 2 variants of the quarterly FERU in the United States, 1951Q1–2019Q4:
%
% * FERU obtained with simple formula (2)
% * FERU obtained with generalized formula (8)
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure13.pdf – PDF file with figure 13
% * figure13.csv – CSV file with data underlying figure 13
% * figure13.md – Markdown file with numerical results from figure 13
%

%% Specify figure name and output files

% Define figure number
number = '13';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Produce quarterly timeline
timeline = [1951 : 0.25 : 2019.75]';

% Get recessions dates
[startRecession, endRecession] = getRecessionPostwar(inputFolder);

% Get unemployment rate
u = getUnemploymentPostwar(inputFolder);

% Get vacancy rate
v = getVacancyPostwar(inputFolder);

%% Compute FERU with simple formula (2)

uStar = sqrt(u .* v);

%% Calibrate parameters for generalized formula (8)

% Beveridge elasticity
epsilon = getElasticity(inputFolder);

% Recruiting cost
kappa = 0.92;

% Social product of unemployed labor
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
h1.Color = '#c994c7';
h1.LineWidth = 2.4;
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
absDistanceMean = mean(abs(uStarGeneralized - uStar));
[distanceMax, iMax] = max(uStarGeneralized - uStar);
[distanceMin, iMin] = min(uStarGeneralized - uStar);

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average distance between FERUs: %4.3f \n', distanceMean)
fprintf('* Average absolute distance between FERUs: %4.3f \n', absDistanceMean)
fprintf('* Maximum distance between FERUs: %4.3f in %4.2f \n', distanceMax, timeline(iMax))
fprintf('* Minimum distance between FERUs: %4.3f in %4.2f \n', distanceMin, timeline(iMin))
fprintf('\n')
diary off