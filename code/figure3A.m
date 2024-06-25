%% figure3A.m
% 
% Produce figure 3A
%
%% Description
%
% This script produces figure 3A and associated numerical results. The figure displays the quarterly unemployment rate, vacancy rate, and FERU in the United States, 1951–2019.
%
%% Output
%
% * The figure is saved as figure3A.pdf.
% * The figure data are saved in figure3A.csv.
% * The numerical results are saved in figure3A.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure3A.pdf'];
fileData = [pathOutput, 'figure3A.csv'];
fileResults = [pathOutput, 'figure3A.md'];

%% Get data

% Get timeline
timeline = makeTimeline(1951, 2019);

% Get recessions dates
[startRecession, endRecession] = getRecessionPostwar(pathInput);

% Get unemployment rate
u = getUnemploymentPostwar(pathInput);

% Get vacancy rate
v = getVacancyPostwar(pathInput);

%% Compute FERU

uStar = sqrt(u .* v);

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