%% figure1A.m
% 
% Produce figure 1A
%
%% Description
%
% This script produces figure 1A and associated numerical results. The figure displays the quarterly unemployment and vacancy rates in the United States, 1951–2019.
%
%% Output
%
% * The figure is saved as figure1A.pdf.
% * The figure data are saved in figure1A.csv.
% * The numerical results are saved in figure1A.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure1A.pdf'];
fileData = [pathOutput, 'figure1A.csv'];
fileResults = [pathOutput, 'figure1A.md'];

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

% Plot unemployment and vacancy rates
plot(timeline, u, linePurple{:})
plot(timeline, v, lineOrange{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year', 'Unemployment rate', 'Vacancy rate'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write data
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