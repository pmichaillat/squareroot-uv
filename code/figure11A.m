%% figure11A.m
% 
% Produce figure 11A
%
%% Description
%
% This script produces figure 11A and associated numerical results. The figure displays the quarterly FERU in the United States, 1930–2023.
%
%% Output
%
% * The figure is saved as figure11A.pdf.
% * The figure data are saved in figure11A.csv.
% * The numerical results are saved in figure11A.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure11A.pdf'];
fileData = [pathOutput, 'figure11A.csv'];
fileResults = [pathOutput, 'figure11A.md'];

%% Get data

% Get timeline
timeline = makeTimeline(1930, 2023);

% Get recessions dates
[startRecession, endRecession] = getRecession(pathInput);

% Get unemployment rate
u = getUnemployment(pathInput);

% Get vacancy rate
v = getVacancy(pathInput);

%% Compute FERU

uStar = sqrt(u .* v);

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
set(ax, xTotal{:})

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick =  [0:0.02:0.08];
ax.YTickLabel = ['0%'; '2%'; '4%'; '6%'; '8%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, areaRecession{:});

% Plot FERU
plot(timeline, uStar, linePink{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year',  'FERU'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, uStar];
writematrix(data, fileData, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
uStarMean = mean(uStar);
uStarMax = max(uStar);
uStarMin = min(uStar);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Average FERU: %4.3f \n', uStarMean)
fprintf('* Maximum FERU: %4.3f \n', uStarMax)
fprintf('* Minimum FERU: %4.3f \n', uStarMin)
fprintf('\n')
diary off