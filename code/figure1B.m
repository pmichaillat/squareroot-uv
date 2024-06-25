%% figure1B.m
% 
% Produce figure 1B
%
%% Description
%
% This script produces figure 1B. The figure displays on a log scale the quarterly unemployment and vacancy rates in the United States, 1951–2019.
%
%% Output
%
% * The figure is saved as figure1B.pdf.
% * The figure data are saved in figure1B.csv.
%

%% Specify output files

fileFigure = [pathOutput, 'figure1B.pdf'];
fileData = [pathOutput, 'figure1B.csv'];

%% Get data

% Get timeline
timeline = makeTimeline(1951, 2019);

% Get unemployment rate
u = getUnemploymentPostwar(pathInput);

% Get vacancy rate
v = getVacancyPostwar(pathInput);

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)

% Plot unemployment and vacancy rates
semilogy(timeline, u, linePurple{:})
hold on
semilogy(timeline, v, lineOrange{:})

% Format x-axis
ax = gca;
set(ax, xPostwar{:})

% Format y-axis
ax.YLim = [0.015,0.12];
ax.YTick =  [0.015,0.03,0.06,0.12];
ax.YTickLabel = ['1.5%';'  3%';'  6%';' 12%'];
ax.YLabel.String =  'Share of labor force';
ax.YMinorTick = 'Off';
box off

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year',  'Log unemployment rate', 'Log vacancy rate'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, log(u), log(v)];
writematrix(data, fileData, 'WriteMode', 'append')