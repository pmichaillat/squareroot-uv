%% figure6B.m
% 
% Produce figure 6B
%
%% Description
%
% This script produces figure 6B and associated numerical results. The figure displays the quarterly unemployment gap in the United States, 1930–1950.
%
%% Output
%
% * The figure is saved as figure6B.pdf.
% * The figure data are saved in figure6B.csv.
% * The numerical results are saved in figure6B.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure6B.pdf'];
fileData = [pathOutput, 'figure6B.csv'];
fileResults = [pathOutput, 'figure6B.md'];

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

%% Compute unemployment gap

gap = u - uStar;

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

% Paint unemployment gap
a = area(timeline, [uStar, max(u - uStar,0), min(u - uStar,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = purple;
a(3).FaceColor = orange;

% Plot unemployment rate and FERU
plot(timeline, u, linePurpleThin{:})
plot(timeline, uStar, linePink{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year',  'Unemployment rate', 'FERU', 'Unemployment gap'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, uStar, gap];
writematrix(data, fileData, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
uMean = mean(u);
uMax = max(u);
uMin = min(u);
uStarMean = mean(uStar);
uStarMax = max(uStar);
uStarMin = min(uStar);
gapMean = mean(gap);
gapMax = max(gap);
gapMin = min(gap);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Average unemployment rate: %4.3f \n', uMean)
fprintf('* Maximum unemployment rate: %4.3f \n', uMax)
fprintf('* Minimum unemployment rate: %4.3f \n', uMin)
fprintf('* Average FERU: %4.3f \n', uStarMean)
fprintf('* Maximum FERU: %4.3f \n', uStarMax)
fprintf('* Minimum FERU: %4.3f \n', uStarMin)
fprintf('* Average unemployment gap: %4.3f \n', gapMean)
fprintf('* Maximum unemployment gap: %4.3f \n', gapMax)
fprintf('* Minimum unemployment gap: %4.3f \n', gapMin)
fprintf('\n')
diary off