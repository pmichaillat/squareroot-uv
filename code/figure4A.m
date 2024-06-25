%% figure4A.m
% 
% Produce figure 4A
%
%% Description
%
% This script produces figure 4A and associated numerical results. The figure displays the quarterly unemployment and vacancy rates in the United States, 1930–1950.
%
%% Output
%
% * The figure is saved as figure4A.pdf.
% * The figure data are saved in figure4A.csv.
% * The numerical results are saved in figure4A.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure4A.pdf'];
fileData = [pathOutput, 'figure4A.csv'];
fileResults = [pathOutput, 'figure4A.md'];

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

% Plot unemployment and vacancy rates
plot(timeline, u, linePurple{:})
plot(timeline, v, lineOrange{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year',  'Unemployment rate', 'Vacancy rate'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, v];
writematrix(data, fileData, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
uMean = mean(u);
uMax = max(u);
uMin = min(u);
vMean = mean(v);
vMax = max(v);
vMin = min(v);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Average unemployment rate: %4.3f \n', uMean)
fprintf('* Maximum unemployment rate: %4.3f \n', uMax)
fprintf('* Minimum unemployment rate: %4.3f \n', uMin)
fprintf('* Average vacancy rate: %4.3f \n', vMean)
fprintf('* Maximum vacancy rate: %4.3f \n', vMax)
fprintf('* Minimum vacancy rate: %4.3f \n', vMin)
fprintf('\n')
diary off