%% figure13B.m
% 
% Produce figure 13B
%
%% Description
%
% This script produces figure 13B and associated numerical results. The figure displays the quarterly FERU in the United States, 1930Q1–2024Q2, for a range of calibrations:
%
% * Beveridge elasticity between 0.75 and 1.25
% * Recruiting cost between 0.75 and 1.25
% * Social product of unemployed labor between -0.25 and 0.25 
%
% For each calibration, the FERU is computed using generalized formula (8).
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure13B.pdf – PDF file with figure 13B
% * figure13B.csv – CSV file with data underlying figure 13B
% * figure13B.md – Markdown file with numerical results from figure 13B
%

%% Specify figure name and output files

% Define figure number
number = '13B';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1930 : 0.25 : 2024.25]';

% Get recession dates
[startRecession, endRecession] = getRecession(inputFolder);

% Get unemployment rate
u = getUnemployment(inputFolder);

% Get vacancy rate
v = getVacancy(inputFolder);

%% Calibrate parameters

% Calibrate Beveridge elasticity
epsilon = 1;
epsilonLow = 0.75;
epsilonHigh = 1.25;

% Calibrate recruiting cost
kappa = 1;
kappaLow = 0.75;
kappaHigh = 1.25;

% Calibrate social product of unemployed labor
zeta = 0;
zetaLow = -0.25;
zetaHigh = 0.25;

%% Create function to apply generalized formula (8)

uStar = @(u, v, epsilon, kappa, zeta) (kappa .* epsilon .* v .* (u.^epsilon) ./ (1 - zeta)).^(1 ./ (1 + epsilon));

%% Compute FERU using generalized formula (8) for various calibrations

% Compute baseline FERU
uStarBaseline = uStar(u, v, epsilon, kappa, zeta);

% Compute FERU for low and high Beveridge elasticities
uStarEpsilonLow = uStar(u, v, epsilonLow, kappa, zeta);
uStarEpsilonHigh = uStar(u, v, epsilonHigh, kappa, zeta);

% Compute FERU for low and high recruiting costs
uStarKappaLow = uStar(u, v, epsilon, kappaLow, zeta);
uStarKappaHigh = uStar(u, v, epsilon, kappaHigh, zeta);

% Compute FERU for low and high social products of unemployed labor
uStarZetaLow = uStar(u, v, epsilon, kappa, zetaLow);
uStarZetaHigh = uStar(u, v, epsilon, kappa, zetaHigh);

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, x{:})

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick =  [0:0.02:0.08];
ax.YTickLabel = ['0%'; '2%'; '4%'; '6%'; '8%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Paint FERU area for range of Beveridge elasticities
h1 = area(timeline, [uStarEpsilonLow, uStarEpsilonHigh - uStarEpsilonLow]);

% Format first FERU area
h1(1).FaceAlpha = 0;
h1(1).LineWidth = medium;
h1(1).LineStyle = '-.';
h1(1).EdgeColor = pinkLight;
h1(2).FaceAlpha = 0.2;
h1(2).FaceColor = pinkLight;
h1(2).LineWidth = medium;
h1(2).LineStyle = '-.';
h1(2).EdgeColor = pinkLight;

% Paint FERU area for range of recruiting costs
h2 = area(timeline, [uStarKappaLow, uStarKappaHigh - uStarKappaLow]);

% Format second FERU area
h2(1).FaceAlpha = 0;
h2(1).LineWidth = medium;
h2(1).LineStyle = '--';
h2(1).EdgeColor = pinkMedium;
h2(2).FaceAlpha = 0.2;
h2(2).FaceColor = pinkMedium;
h2(2).LineWidth = medium;
h2(2).LineStyle = '--';
h2(2).EdgeColor = pinkMedium;

% Paint FERU area for range of social products of unemployed labor
h3 = area(timeline, [uStarZetaLow, uStarZetaHigh - uStarZetaLow]);

% Format third FERU area
h3(1).FaceAlpha = 0;
h3(1).LineWidth = medium;
h3(1).LineStyle = ':';
h3(1).EdgeColor = pink;
h3(2).FaceAlpha = 0.2;
h3(2).FaceColor = pink;
h3(2).LineWidth = medium;
h3(2).LineStyle = ':';
h3(2).EdgeColor = pink;

% Plot baseline FERU
plot(timeline, uStarBaseline, pinkLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Baseline FERU', 'FERU with epsilon = 0.75', 'FERU with epsilon = 1.25', 'FERU with kappa = 0.75', 'FERU with kappa = 1.25', 'FERU with zeta = -0.25', 'FERU with zeta = 0.25'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, uStarBaseline, uStarEpsilonLow, uStarEpsilonHigh, uStarKappaLow, uStarKappaHigh, uStarZetaLow, uStarZetaHigh];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
distanceEpsilonLowMean = mean(abs(uStarEpsilonLow - uStarBaseline));
distanceEpsilonHighMean = mean(abs(uStarEpsilonHigh - uStarBaseline));
distanceKappaLowMean = mean(abs(uStarKappaLow - uStarBaseline));
distanceKappaHighMean = mean(abs(uStarKappaHigh - uStarBaseline));
distanceZetaLowMean = mean(abs(uStarZetaLow - uStarBaseline));
distanceZetaHighMean = mean(abs(uStarZetaHigh - uStarBaseline));
[distanceEpsilonLowMax, iEpsilonLowMax] = max(abs(uStarEpsilonLow - uStarBaseline));
[distanceEpsilonHighMax, iEpsilonHighMax] = max(abs(uStarEpsilonHigh - uStarBaseline));
[distanceKappaLowMax, iKappaLowMax] = max(abs(uStarKappaLow - uStarBaseline));
[distanceKappaHighMax, iKappaHighMax] = max(abs(uStarKappaHigh- uStarBaseline));
[distanceZetaLowMax, iZetaLowMax] = max(abs(uStarZetaLow - uStarBaseline));
[distanceZetaHighMax, iZetaHighMax] = max(abs(uStarZetaHigh - uStarBaseline));

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average distance between baseline FERU and FERU with epsilon = 0.75: %4.3f \n', distanceEpsilonLowMean)
fprintf('* Average distance between baseline FERU and FERU with epsilon = 1.25: %4.3f \n', distanceEpsilonHighMean)
fprintf('* Average distance between baseline FERU and FERU with kappa = 0.75: %4.3f \n', distanceKappaLowMean)
fprintf('* Average distance between baseline FERU and FERU with kappa = 1.25: %4.3f \n', distanceKappaHighMean)
fprintf('* Average distance between baseline FERU and FERU with zeta = -0.25: %4.3f \n', distanceZetaLowMean)
fprintf('* Average distance between baseline FERU and FERU with zeta = 0.25: %4.3f \n', distanceZetaHighMean)
fprintf('* Maximum distance between baseline FERU and FERU with epsilon = 0.75: %4.3f in %4.2f\n', distanceEpsilonLowMax, timeline(iEpsilonLowMax))
fprintf('* Maximum distance between baseline FERU and FERU with epsilon = 1.25: %4.3f in %4.2f\n', distanceEpsilonHighMax, timeline(iEpsilonHighMax))
fprintf('* Maximum distance between baseline FERU and FERU with kappa = 0.75: %4.3f in %4.2f\n', distanceKappaLowMax, timeline(iKappaLowMax))
fprintf('* Maximum distance between baseline FERU and FERU with kappa = 1.25: %4.3f in %4.2f\n', distanceKappaHighMax, timeline(iKappaHighMax))
fprintf('* Maximum distance between baseline FERU and FERU with zeta = -0.25: %4.3f in %4.2f\n', distanceZetaLowMax, timeline(iZetaLowMax))
fprintf('* Maximum distance between baseline FERU and FERU with zeta = 0.25: %4.3f in %4.2f\n', distanceZetaHighMax, timeline(iZetaHighMax))
fprintf('* Distance between baseline FERU and FERU with epsilon = 0.75 in 2024Q2: %4.3f \n', abs(uStarEpsilonLow(end) - uStarBaseline(end)))
fprintf('* Distance between baseline FERU and FERU with epsilon = 1.25 in 2024Q2: %4.3f \n', abs(uStarEpsilonHigh(end) - uStarBaseline(end)))
fprintf('* Distance between baseline FERU and FERU with kappa = 0.75 in 2024Q2: %4.3f \n', abs(uStarKappaLow(end) - uStarBaseline(end)))
fprintf('* Distance between baseline FERU and FERU with kappa = 1.25 in 2024Q2: %4.3f \n', abs(uStarKappaHigh(end) - uStarBaseline(end)))
fprintf('* Distance between baseline FERU and FERU with zeta = -0.25 in 2024Q2: %4.3f \n', abs(uStarZetaLow(end) - uStarBaseline(end)))
fprintf('* Distance between baseline FERU and FERU with zeta = 0.25 in 2024Q2: %4.3f \n', abs(uStarZetaHigh(end) - uStarBaseline(end)))
fprintf('\n')
diary off