%% figure14B.m
% 
% Produce figure 14B
%
%% Description
%
% This script produces figure 14B and associated numerical results. The figure displays 3 variants of the quarterly unemployment gap in the United States, 1994Q1–2024Q2:
%
% * Unemployment gap based on concept U3 of unemployment
% * Unemployment gap based on concept U4 of unemployment
% * Unemployment gap based on concept U5 of unemployment
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure14B.pdf – PDF file with figure 14B
% * figure14B.csv – CSV file with data underlying figure 14B
% * figure14B.md – Markdown file with numerical results from figure 14B
%

%% Specify figure name and output files

% Define figure number
number = '14B';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Produce quarterly timeline
timeline = [1994 : 0.25 : 2024.25]';

% Get recessions dates
[startRecession, endRecession] = getRecession345(inputFolder);

% Get unemployment and vacancy rates
[u3, u4, u5, v3, v4, v5] = getData345(inputFolder);

%% Compute FERU and unemployment gap based on concept U3 of unemployment

% Compute FERU
uStar3 = sqrt(u3 .* v3);

% Compute unemployment gap
gap3 = u3 - uStar3;

%% Compute FERU and unemployment gap based on concept U4 of unemployment

% Compute FERU
uStar4 = sqrt(u4 .* v4);

% Compute unemployment gap
gap4 = u4 - uStar4;

%% Compute FERU and unemployment gap based on concept U5 of unemployment

% Compute FERU
uStar5 = sqrt(u5 .* v5);

% Compute unemployment gap
gap5 = u5 - uStar5;

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, x345{:})

% Format y-axis
ax.YLim = [-0.02, 0.08];
ax.YTick =  [-0.02:0.02:0.08];
ax.YTickLabel = ['-2pp'; ' 0pp'; ' 2pp'; ' 4pp'; ' 6pp'; ' 8pp'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot unemployment gaps
h1 = plot(timeline, gap5);
h2 = plot(timeline, gap4);
plot(timeline, gap3, purpleLine{:})

% Format unemployment gaps
h1.Color = '#bcbddc';
h1.LineWidth = 2.4;
h2.Color = '#9e9ac8';
h2.LineWidth = 2.4;

% Plot full-employment line
plot(timeline, zeros(size(timeline)), pinkThinLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year',  'U3 gap', 'U4 gap', 'U5 gap'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, gap3, gap4, gap5];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
gap3Mean = mean(gap3);
gap4Mean = mean(gap4);
gap5Mean = mean(gap5);
distance4Mean = mean(gap4 - gap3);
[distance4Max, iMax4] = max(gap4 - gap3);
[distance4Min, iMin4] = min(gap4 - gap3);
distance5Mean = mean(gap5 - gap3);
[distance5Max, iMax5] = max(gap5 - gap3);
[distance5Min, iMin5] = min(gap5 - gap3);

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average U3 gap: %4.3f \n', gap3Mean)
fprintf('* Average U4 gap: %4.3f \n', gap4Mean)
fprintf('* Average U5 gap: %4.3f \n', gap5Mean)
fprintf('* U3 gap in 2024Q2: %4.3f \n', gap3(end))
fprintf('* U4 gap in 2024Q2: %4.3f \n', gap4(end))
fprintf('* U5 gap in 2024Q2: %4.3f \n', gap5(end))
fprintf('* Average distance between U3 gap & U4 gap: %4.3f \n', distance4Mean)
fprintf('* Maximum distance between U3 gap & U4 gap: %4.3f in %4.2f \n', distance4Max, timeline(iMax4))
fprintf('* Minimum distance between U3 gap & U4 gap: %4.3f in %4.2f \n', distance4Min, timeline(iMin4))
fprintf('* Average distance between U3 gap & U5 gap: %4.3f \n', distance5Mean)
fprintf('* Maximum distance between U3 gap & U5 gap: %4.3f in %4.2f \n', distance5Max, timeline(iMax5))
fprintf('* Minimum distance between U3 gap & U5 gap: %4.3f in %4.2f \n', distance5Min, timeline(iMin5))
fprintf('\n')
diary off