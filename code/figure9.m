%% figure9.m
% 
% Produce figure 9
%
%% Description
%
% This script produces figure 9. The figure displays the Beveridge curve in the United States, 2001–2023.
%
%% Output
%
% * The figure is saved as figure9.pdf.
% * The figure data are saved in figure9.csv.
%

%% Specify output files

fileFigure = [pathOutput, 'figure9.pdf'];
fileData = [pathOutput, 'figure9.csv'];

%% Get data

% Get unemployment rate
u = getUnemploymentJolts(pathInput);

% Get vacancy rate
v = getVacancyJolts(pathInput);

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
ax.XGrid = 'on';
ax.TickLength = [0 0];
ax.XLim = [0, 0.16];
ax.XTick = [0:0.04:0.16];
ax.XTickLabel = [' 0%'; ' 4%'; ' 8%'; '12%'; '16%'];
ax.XLabel.String = 'Unemployment rate';

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick =  [0:0.02:0.08];
ax.YTickLabel = ['0%'; '2%'; '4%'; '6%'; '8%'];
ax.YLabel.String =  'Vacancy rate';

% Plot full-employment line
uRange = [0:0.001:0.20];
vLine = uRange;
plot(uRange, vLine, linePinkThin{:})

% Plot Beveridge curve
plot(u, v, dotGray{:})

% Highlight inefficiently tight period
tightPeriod = [u < v];
plot(u(tightPeriod), v(tightPeriod), dotOrange{:})

% Highlight inefficiently slack period
slackPeriod = [u > v];
plot(u(slackPeriod), v(slackPeriod), dotPurple{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year',  'Unemployment rate', 'Vacancy rate'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
timeline = makeTimeline(2001,2023);
data = [timeline, u, v];
writematrix(data, fileData, 'WriteMode', 'append')