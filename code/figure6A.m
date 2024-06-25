%% figure6A.m
% 
% Produce figure 6A
%
%% Description
%
% This script produces figure 6A. The figure displays the quarterly unemployment rate, vacancy rate, and FERU in the United States, 1930–1950.
%
%% Output
%
% * The figure is saved as figure6A.pdf.
% * The figure data are saved in figure6A.csv.
%

%% Specify output files

fileFigure = [pathOutput, 'figure6A.pdf'];
fileData = [pathOutput, 'figure6A.csv'];

%% Get data

% Get timeline
timeline = makeTimeline(1930, 1950);

% Get recessions dates
[startRecession, endRecession] = getRecessionDepression(pathInput);

% Get unemployment rate
u = getUnemploymentDepression(pathInput);

% Get vacancy rate
v = getVacancyDepression(pathInput);

%% Compute FERU

uStar = sqrt(u .* v);

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
set(ax, xDepression{:})

% Format y-axis
ax.YLim = [0, 0.3];
ax.YTick =  [0:0.06:0.3];
ax.YTickLabel = [' 0%'; ' 6%'; '12%'; '18%'; '24%'; '30%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, areaRecession{:});

% Plot unemployment rate, vacancy rate, and FERU
plot(timeline, u, linePurpleThin{:})
plot(timeline, v, lineOrangeThin{:})
plot(timeline, uStar, linePink{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year',  'Unemployment rate', 'Vacancy rate', 'FERU'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, v, uStar];
writematrix(data, fileData, 'WriteMode', 'append')