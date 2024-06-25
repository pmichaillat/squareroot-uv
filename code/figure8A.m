%% figure8A.m
% 
% Produce figure 8A
%
%% Description
%
% This script produces figure 8A and associated numerical results. The figure displays the quarterly unemployment rate, vacancy rate, and FERU in the United States, 2020–2023.
%
%% Output
%
% * The figure is saved as figure8A.pdf.
% * The figure data are saved in figure8A.csv.
% * The numerical results are saved in figure8A.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure8A.pdf'];
fileData = [pathOutput, 'figure8A.csv'];
fileResults = [pathOutput, 'figure8A.md'];

%% Get data

% Get timeline
timeline = makeTimeline(2020, 2023);

% Get recessions dates
[startRecession, endRecession] = getRecessionPandemic(pathInput);

% Get unemployment rate
u = getUnemploymentPandemic(pathInput);

% Get vacancy rate
v = getVacancyPandemic(pathInput);

%% Compute FERU

uStar = sqrt(u .* v);

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
set(ax, xPandemic{:})

% Format y-axis
ax.YLim = [0, 0.15];
ax.YTick =  [0:0.03:0.15];
ax.YTickLabel = [' 0%'; ' 3%'; ' 6%'; ' 9%'; '12%'; '15%'];
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

%% Produce numerical results

% Compute results
uMean = mean(u);
uMax = max(u);
uMin = min(u);
vMean = mean(v);
vMax = max(v);
vMin = min(v);
uStarMean = mean(uStar);
uStarMax = max(uStar);
uStarMin = min(uStar);

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
fprintf('* Average FERU: %4.3f \n', uStarMean)
fprintf('* Maximum FERU: %4.3f \n', uStarMax)
fprintf('* Minimum FERU: %4.3f \n', uStarMin)
fprintf('\n')
diary off