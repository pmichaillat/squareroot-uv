%% figure12B.m
% 
% Produce figure 12B
%
%% Description
%
% This script produces figure 12B and associated numerical results. The figure displays 3 variants of the quarterly unemployment gap in the United States, 1994–2023:
%
% # Unemployment gap based on concept U3 of unemployment (baseline)
% # Unemployment gap based on concept U4 of unemployment
% # Unemployment gap based on concept U5 of unemployment
%
%% Output
%
% * The figure is saved as figure12B.pdf.
% * The figure data are saved in figure12B.csv.
% * The numerical results are saved in figure12B.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure12B.pdf'];
fileData = [pathOutput, 'figure12B.csv'];
fileResults = [pathOutput, 'figure12B.md'];

%% Get data

% Get timeline
timeline = makeTimeline(1994, 2023);

% Get recessions dates
[startRecession, endRecession] = getRecession345(pathInput);

% Get unemployment and vacancy rates
[u3, u4, u5, v3, v4, v5] = getData345(pathInput);

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

iFigure = iFigure + 1;
figure(iFigure)
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
xregion(startRecession, endRecession, areaRecession{:});

% Plot unemployment gaps
plot(timeline, gap5, linePurpleLight{:})
plot(timeline, gap4, linePurpleMedium{:})
plot(timeline, gap3, linePurpleDark{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year',  'U3 gap', 'U4 gap', 'U5 gap'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, gap3, gap4, gap5];
writematrix(data, fileData, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
gap3Mean = mean(gap3);
gap4Mean = mean(gap4);
gap5Mean = mean(gap5);
distance4Mean = mean(gap4 - gap3);
distance4Max = max(gap4 - gap3);
distance4Min = min(gap4 - gap3);
distance5Mean = mean(gap5 - gap3);
distance5Max = max(gap5 - gap3);
distance5Min = min(gap5 - gap3);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Average U3 gap: %4.3f \n', gap3Mean)
fprintf('* Average U4 gap: %4.3f \n', gap4Mean)
fprintf('* Average U5 gap: %4.3f \n', gap4Mean)
fprintf('* U3 gap in 2023Q4: %4.3f \n', gap3(end))
fprintf('* U4 gap in 2023Q4: %4.3f \n', gap4(end))
fprintf('* U5 gap in 2023Q4: %4.3f \n', gap5(end))
fprintf('* Average distance between U3 gap & U4 gap: %4.3f \n', distance4Mean)
fprintf('* Maximum distance between U3 gap & U4 gap: %4.3f \n', distance4Max)
fprintf('* Minimum distance between U3 gap & U4 gap: %4.3f \n', distance4Min)
fprintf('* Average distance between U3 gap & U5 gap: %4.3f \n', distance5Mean)
fprintf('* Maximum distance between U3 gap & U5 gap: %4.3f \n', distance5Max)
fprintf('* Minimum distance between U3 gap & U5 gap: %4.3f \n', distance5Min)
fprintf('\n')
diary off