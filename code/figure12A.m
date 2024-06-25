%% figure12A.m
% 
% Produce figure 12A
%
%% Description
%
% This script produces figure 12A and associated numerical results. The figure displays 3 variants of the quarterly FERU in the United States, 1994–2023:
%
% # FERU based on concept U3 of unemployment (baseline)
% # FERU based on concept U4 of unemployment
% # FERU based on concept U5 of unemployment
%
%% Output
%
% * The figure is saved as figure12A.pdf.
% * The figure data are saved in figure12A.csv.
% * The numerical results are saved in figure12A.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure12A.pdf'];
fileData = [pathOutput, 'figure12A.csv'];
fileResults = [pathOutput, 'figure12A.md'];

%% Get data

% Get timeline
timeline = makeTimeline(1994, 2023);

% Get recessions dates
[startRecession, endRecession] = getRecession345(pathInput);

% Get unemployment and vacancy rates
[u3, u4, u5, v3, v4, v5] = getData345(pathInput);

%% Compute FERU based on concept U3 of unemployment

uStar3 = sqrt(u3.*v3);

%% Compute FERU based on concept U4 of unemployment

uStar4 = sqrt(u4.*v4);

%% Compute FERU based on concept U5 of unemployment

uStar5 = sqrt(u5.*v5);

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
set(ax, x345{:})

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick =  [0:0.02:0.08];
ax.YTickLabel = ['0%'; '2%'; '4%'; '6%'; '8%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, areaRecession{:});

% Plot FERUs
plot(timeline, uStar5, linePinkLight{:})
plot(timeline, uStar4, linePinkMedium{:})
plot(timeline, uStar3, linePinkDark{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year', 'FERU3', 'FERU4', 'FERU5'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, uStar3, uStar4, uStar5];
writematrix(data, fileData, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
v3Mean = mean(v3);
v4Mean = mean(v4);
v5Mean = mean(v5);
u3Mean = mean(u3);
u4Mean = mean(u4);
u5Mean = mean(u5);
uStar3Mean = mean(uStar3);
uStar4Mean = mean(uStar4);
uStar5Mean = mean(uStar5);
distance4Mean = mean(uStar4 - uStar3);
distance4Max = max(uStar4 - uStar3);
distance4Min = min(uStar4 - uStar3);
distance5Mean = mean(uStar5 - uStar3);
distance5Max = max(uStar5 - uStar3);
distance5Min = min(uStar5 - uStar3);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Average V3 rate: %4.3f \n', v3Mean)
fprintf('* Average V4 rate: %4.3f \n', v4Mean)
fprintf('* Average V5 rate: %4.3f \n', v5Mean)
fprintf('* Average U3 rate: %4.3f \n', u3Mean)
fprintf('* Average U4 rate: %4.3f \n', u4Mean)
fprintf('* Average U5 rate: %4.3f \n', u5Mean)
fprintf('* Average FERU3: %4.3f \n', uStar3Mean)
fprintf('* Average FERU4: %4.3f \n', uStar4Mean)
fprintf('* Average FERU5: %4.3f \n', uStar5Mean)
fprintf('* Average distance between FERU3 & FERU4: %4.3f \n', distance4Mean)
fprintf('* Maximum distance between FERU3 & FERU4: %4.3f \n', distance4Max)
fprintf('* Minimum distance between FERU3 & FERU4: %4.3f \n', distance4Min)
fprintf('* Average distance between FERU3 & FERU5: %4.3f \n', distance5Mean)
fprintf('* Maximum distance between FERU3 & FERU5: %4.3f \n', distance5Max)
fprintf('* Minimum distance between FERU3 & FERU5: %4.3f \n', distance5Min)
fprintf('\n')
diary off