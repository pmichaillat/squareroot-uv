%% figure5B.m
% 
% Produce figure 5B
%
%% Description
%
% This script produces figure 5B and associated numerical results. The figure displays the quarterly labor-market tightness in the United States, 1930–1950.
%
%% Output
%
% * The figure is saved as figure5B.pdf.
% * The figure data are saved in figure5B.csv.
% * The numerical results are saved in figure5B.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure5B.pdf'];
fileData = [pathOutput, 'figure5B.csv'];
fileResults = [pathOutput, 'figure5B.md'];

%% Get data

% Get timeline
timeline = makeTimeline(1930, 1950);

% Get recessions dates
[startRecession, endRecession] = getRecessionDepression(pathInput);

% Get unemployment rate
u = getUnemploymentDepression(pathInput);

% Get vacancy rate
v = getVacancyDepression(pathInput);

%% Compute labor-market tightness

tightness = v ./ u;

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
set(ax, xDepression{:})

% Format y-axis
ax.YLim = [0, 7];
ax.YTick =  [0:1:7];
ax.YLabel.String =  'Tightness';

% Paint recession areas
xregion(startRecession, endRecession, areaRecession{:});

% Paint gap between tightness and full-employment line
a = area(timeline, [ones(size(tightness)), max(tightness - 1,0), min(tightness - 1,0)], 'LineStyle', 'none');
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