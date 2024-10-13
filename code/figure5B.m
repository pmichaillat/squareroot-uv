%% figure5B.m
% 
% Produce figure 5B
%
%% Description
%
% This script produces figure 5B and associated numerical results. The figure displays on a log scale the quarterly unemployment and vacancy rates in the United States, 1930Q1–1950Q4.
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure5B.pdf – PDF file with figure 5B
% * figure5B.csv – CSV file with data underlying figure 5B
% * figure5B.md – Markdown file with numerical results from figure 5B
%

%% Specify figure name and output files

% Define figure number
number = '5B';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Produce quarterly timeline
timeline = [1930 : 0.25 : 1950.75]';

% Get recessions dates
[startRecession, endRecession] = getRecessionDepression(inputFolder);

% Get unemployment rate
u = getUnemploymentDepression(inputFolder);

% Get vacancy rate
v = getVacancyDepression(inputFolder);

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xDepression{:})

% Format y-axis

ax.YLim = log([0.005, 0.30]);
ax.YTick =  log([0.005, 0.01, 0.02, 0.04, 0.1, 0.2, 0.3]);
ax.YTickLabel = ['0.5%'; '  1%'; '  2%'; '  4%'; ' 10%'; ' 20%'; ' 30%'];
ax.YLabel.String =  'Share of labor force (log scale)';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot log unemployment and vacancy rates
plot(timeline, log(u), purpleLine{:})
plot(timeline, log(v), orangeDashLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year',  'Log unemployment rate', 'Log vacancy rate'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, log(u), log(v)];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute elasticity of Beveridge curve
y = log(v);
X = [ones(size(u)), log(u)];
b = regress(y,X);
elasticity = b(2);

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Elasticity of the 1930-1950 Beveridge curve: %1.2f \n', elasticity)
fprintf('\n')
diary off