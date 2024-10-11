%% figure8B.m
% 
% Produce figure 8B
%
%% Description
%
% This script produces figure 8B and associated numerical results. The figure displays the quarterly labor-market tightness in the United States, 2020Q1–2024Q2.
%
%% Requirements
%
% * inputFolder – String giving the location of the input folder. By default inputFolder is defined in main.m.
% * outputFolder – String giving the location of the output folder. By default outputFolder is defined in main.m.
% * formatFigure.m – Script defining plot colors and properties. By default formatFigure.m is run in main.m.
%
%% Output
%
% * figure8B.pdf – PDF file with figure 8B
% * figure8B.csv – CSV file with data underlying figure 8B
% * figure8B.md – Markdown file with numerical results associated with figure 8B.
%

%% Specify figure name and output files

% Define figure number
number = '8B';

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

%% Compute labor-market tightness

tightness = v ./ u;

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xPandemic{:})

% Format y-axis
ax.YLim = [0, 2];
ax.YTick =  [0:0.5:2];
ax.YLabel.String =  'Labor-market tightness';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:});

% Paint gap between tightness and full-employment line
a = area(timeline(2:end), [ones(size(tightness(2:end))), max(tightness(2:end) - 1,0), min(tightness(2:end) - 1,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = orange;
a(3).FaceColor = purple;

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
fprintf('* Labor-market tightness in 2024Q2: %4.2f \n', tightness(end))
fprintf('\n')
diary off