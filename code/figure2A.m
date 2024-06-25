%% figure2A.m
% 
% Produce figure 2A
%
%% Description
%
% This script produces figure 2A. The figure displays the gap between the quarterly unemployment and vacancy rates in the United States, 1951–2019.
%
%% Output
%
% * The figure is saved as figure2A.pdf.
% * The figure data are saved in figure2A.csv.
%

%% Specify output files

fileFigure = [pathOutput, 'figure2A.pdf'];
fileData = [pathOutput, 'figure2A.csv'];

%% Get data

% Get timeline
timeline = makeTimeline(1951, 2019);

% Get recessions dates
[startRecession, endRecession] = getRecessionPostwar(pathInput);

% Get unemployment rate
u = getUnemploymentPostwar(pathInput);

% Get vacancy rate
v = getVacancyPostwar(pathInput);

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
set(ax, xPostwar{:})

% Format y-axis
ax.YLim = [0, 0.12];
ax.YTick =  [0:0.03:0.12];
ax.YTickLabel = [' 0%'; ' 3%'; ' 6%'; ' 9%'; '12%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, areaRecession{:});

% Paint gap between unemployment and vacancy rates
a = area(timeline, [v, max(u - v,0), min(u - v,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = purple;
a(3).FaceColor = orange;

% Plot unemployment and vacancy rates
plot(timeline, u, linePurple{:})
plot(timeline, v, lineOrange{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year', 'Unemployment rate', 'Vacancy rate'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, v];
writematrix(data, fileData, 'WriteMode', 'append')