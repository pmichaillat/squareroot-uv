%% figure4B.m
% 
% Produce figure 4B
%
%% Description
%
% This script produces figure 4B and associated numerical results. The figure displays on a log scale the quarterly unemployment and vacancy rates in the United States, 1930–1950.
%
%% Output
%
% * The figure is saved as figure4B.pdf.
% * The figure data are saved in figure4B.csv.
% * The numerical results are saved in figure4B.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure4B.pdf'];
fileData = [pathOutput, 'figure4B.csv'];
fileResults = [pathOutput, 'figure4B.md'];

%% Get data

% Get timeline
timeline = makeTimeline(1930, 1950);

% Get recessions dates
[startRecession, endRecession] = getRecessionDepression(pathInput);

% Get unemployment rate
u = getUnemploymentDepression(pathInput);

% Get vacancy rate
v = getVacancyDepression(pathInput);

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)

% Plot unemployment and vacancy rates
semilogy(timeline, u, linePurple{:})
hold on
semilogy(timeline, v, lineOrange{:})

% Format x-axis
ax = gca;
set(ax, xDepression{:})

% Format y-axis
ax.YLim = [0.007, 0.30];
ax.YTick =  [0.007,0.015,0.03,0.06,0.12,0.30];
ax.YTickLabel = ['0.7%'; '1.5%'; '  3%'; '  6%'; ' 12%'; ' 30%'];
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

%% Produce numerical results

% Compute elasticity of Beveridge curve
y = log(v);
X = [ones(size(u)), log(u)];
b = regress(y,X);
elasticity = b(2);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Elasticity of the 1930-1950 Beveridge curve: %1.2f \n', elasticity)
fprintf('\n')
diary off