%% figure6B.m
% 
% Produce figure 6B
%
%% Description
%
% This script produces figure 6B and associated numerical results. The figure displays the quarterly labor-market tightness in the United States, 1930Q1–1950Q4.
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure6B.pdf – PDF file with figure 6B
% * figure6B.csv – CSV file with data underlying figure 6B
% * figure6B.md – Markdown file with numerical results from figure 6B
%

%% Specify figure name and output files

% Define figure number
number = '6B';

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

%% Compute labor-market tightness

tightness = v ./ u;

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xDepression{:})

% Format y-axis
ax.YLim = [0, 7];
ax.YTick =  [0:1:7];
ax.YLabel.String =  'Labor-market tightness';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Paint tightness gap with distinct colors for positive and negative gaps
h = area(timeline, [ones(size(tightness)), min(tightness - 1,0), max(tightness - 1,0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea);

% Plot labor-market tightness
plot(timeline, tightness, orangeLine{:})

% Plot full-employment line
plot(timeline, ones(size(timeline)), pinkThinLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Tightness'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, tightness];
writematrix(round(data,2), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
tightnessMean = mean(tightness);
[tightnessMax, iMax] = max(tightness);
[tightnessMin, iMin] = min(tightness);

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average labor-market tightness: %4.2f \n', tightnessMean)
fprintf('* Maximum labor-market tightness: %4.2f in %4.2f \n', tightnessMax, timeline(iMax))
fprintf('* Minimum labor-market tightness: %4.2f in %4.2f \n', tightnessMin, timeline(iMin))
fprintf('\n')
diary off