%% figure8A.m
% 
% Produce figure 8A
%
%% Description
%
% This script produces figure 8A and associated numerical results. The figure displays the gap between the quarterly unemployment and vacancy rates in the United States, 2020Q1–2024Q2.
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure8A.pdf – PDF file with figure 8A
% * figure8A.csv – CSV file with data underlying figure 8A
% * figure8A.md – Markdown file with numerical results from figure 8A
%

%% Specify figure name and output files

% Define figure number
number = '8A';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Produce quarterly timeline
timeline = [2020 : 0.25 : 2024.25]';

% Get recessions dates
[startRecession, endRecession] = getRecessionPandemic(inputFolder);

% Get unemployment rate
u = getUnemploymentPandemic(inputFolder);

% Get vacancy rate
v = getVacancyPandemic(inputFolder);

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xPandemic{:})

% Format y-axis
ax.YLim = [0, 0.14];
ax.YTick =  [0:0.02:0.14];
ax.YTickLabel = [' 0%'; ' 2%'; ' 4%'; ' 6%'; ' 8%'; '10%'; '12%'; '14%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Paint gap between unemployment and vacancy rates with distinct colors for positive and negative gaps
h = area(timeline, [v, max(u - v,0), min(u - v,0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea);

% Plot unemployment and vacancy rates
plot(timeline, u, purpleLine{:})
plot(timeline, v, orangeDashLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year',  'Unemployment rate', 'Vacancy rate'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, v];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
uMean = mean(u);
[uMax, iMaxU] = max(u);
[uMin, iMinU] = min(u);
vMean = mean(v);
[vMax, iMaxV] = max(v);
[vMin, iMinV] = min(v);

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average unemployment rate: %4.3f \n', uMean)
fprintf('* Maximum unemployment rate: %4.3f in %4.2f \n', uMax, timeline(iMaxU))
fprintf('* Minimum unemployment rate: %4.3f in %4.2f \n', uMin, timeline(iMinU))
fprintf('* Unemployment rate in 2024Q2: %4.3f \n', u(end))
fprintf('* Average vacancy rate: %4.3f \n', vMean)
fprintf('* Maximum vacancy rate: %4.3f in %4.2f \n', vMax, timeline(iMaxV))
fprintf('* Minimum vacancy rate: %4.3f in %4.2f \n', vMin, timeline(iMinV))
fprintf('* Vacancy rate in 2024Q2: %4.3f \n', v(end))
fprintf('\n')
diary off