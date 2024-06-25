%% figure7B.m
% 
% Produce figure 7B
%
%% Description
%
% This script produces figure 7B and associated numerical results. The figure displays the quarterly labor-market tightness in the United States, 2020–2023.
%
%% Output
%
% * The figure is saved as figure7B.pdf.
% * The figure data are saved in figure7B.csv.
% * The numerical results are saved in figure7B.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure7B.pdf'];
fileData = [pathOutput, 'figure7B.csv'];
fileResults = [pathOutput, 'figure7B.md'];

%% Get data

% Get timeline
timeline = makeTimeline(2020, 2023);

% Get recessions dates
[startRecession, endRecession] = getRecessionPandemic(pathInput);

% Get unemployment rate
u = getUnemploymentPandemic(pathInput);

% Get vacancy rate
v = getVacancyPandemic(pathInput);

%% Compute labor-market tightness

tightness = v ./ u;

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
set(ax, xPandemic{:})

% Format y-axis
ax.YLim = [0, 2];
ax.YTick =  [0:0.5:2];
ax.YLabel.String =  'Tightness';

% Paint recession areas
xregion(startRecession, endRecession, areaRecession{:});

% Paint gap between tightness and full-employment line
a = area(timeline(2:end), [ones(size(tightness(2:end))), max(tightness(2:end) - 1,0), min(tightness(2:end) - 1,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = orange;
a(3).FaceColor = purple;

% Plot labor-market tightness
plot(timeline, tightness, linePurple{:})

% Plot full-employment line
yline(1, linePinkThin{:}, 'Alpha', 1)

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year', 'Tightness'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, tightness];
writematrix(data, fileData, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
tightnessMean = mean(tightness);
tightnessMax = max(tightness);
tightnessMin = min(tightness);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Average labor-market tightness: %4.2f \n', tightnessMean)
fprintf('* Maximum labor-market tightness: %4.2f \n', tightnessMax)
fprintf('* Minimum labor-market tightness: %4.2f \n', tightnessMin)
fprintf('\n')
diary off