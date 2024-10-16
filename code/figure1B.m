%% figure1B.m
% 
% Produce figure 1B
%
%% Description
%
% This script produces figure 1B. The figure displays on a log scale the quarterly unemployment and vacancy rates in the United States, 1951Q1–2019Q4.
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure1B.pdf – PDF file with figure 1B
% * figure1B.csv – CSV file with data underlying figure 1B
%

%% Specify figure name and output files

% Define figure number
number = '1B';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1951 : 0.25 : 2019.75]';

% Get recession dates
[startRecession, endRecession] = getRecessionPostwar(inputFolder);

% Get unemployment rate
u = getUnemploymentPostwar(inputFolder);

% Get vacancy rate
v = getVacancyPostwar(inputFolder);

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xPostwar{:})

% Format y-axis
ax.YLim = log([0.01,0.12]);
ax.YTick =  log([0.01,0.02:0.02:0.12]);
ax.YTickLabel = [' 1%'; ' 2%'; ' 4%'; ' 6%'; ' 8%'; '10%'; '12%'];
ax.YLabel.String =  'Share of labor force (log scale)';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot log unemployment and vacancy rates
plot(timeline, log(u), purpleLine{:})
plot(timeline, log(v), orangeDotDashLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year',  'Log unemployment rate', 'Log vacancy rate'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, log(u), log(v)];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')