%% figure13.m
% 
% Produce figure 13
%
%% Description
%
% This script produces figure 13 and associated numerical results. The figure displays 2 variants of the quarterly FERU in the United States, 1951–2019:
%
% # FERU obtained with simple formula (2) (baseline)
% # FERU obtained with generalized formula (3)
%
%% Output
%
% * The figure is saved as figure13.pdf.
% * The figure data are saved in figure13.csv.
% * The numerical results are saved in figure13.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure13.pdf'];
fileData = [pathOutput, 'figure13.csv'];
fileResults = [pathOutput, 'figure13.md'];

%% Get data

% Get timeline
timeline = makeTimeline(1951, 2019);

% Get recessions dates
[startRecession, endRecession] = getRecessionPostwar(pathInput);

% Get unemployment rate
u = getUnemploymentPostwar(pathInput);

% Get vacancy rate
v = getVacancyPostwar(pathInput);

%% Compute FERU with simple formula (2)

uStar = sqrt(u .* v);

%% Calibrate parameters for generalized formula

% Beveridge elasticity
epsilon = getElasticity(pathInput);

% Recruiting cost
kappa = 0.92;

% Social product of unemployed labor
zeta = 0.26;

%% Compute FERU with generalized formula (3)

uStarGeneralized = (kappa .* epsilon .* v .* (u.^epsilon) ./ (1 - zeta)).^(1 ./ (1 + epsilon));

%% Produce figure

iFigure = iFigure + 1;
figure(iFigure)
hold on

% Format x-axis
ax = gca;
set(ax, xPostwar{:})

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick =  [0:0.02:0.08];
ax.YTickLabel = ['0%'; '2%'; '4%'; '6%'; '8%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, areaRecession{:});

% Plot FERUs
plot(timeline, uStar, linePink{:})
plot(timeline, uStarGeneralized, linePinkDash{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data

% Write header
header = {'Year',  'FERU', 'Generalized FERU'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Write results
data = [timeline, uStar, uStarGeneralized];
writematrix(data, fileData, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
uStarMean = mean(uStar);
uStarMax = max(uStar);
uStarMin = min(uStar);
uStarGeneralizedMean = mean(uStarGeneralized);
uStarGeneralizedMax = max(uStarGeneralized);
uStarGeneralizedMin = min(uStarGeneralized);
distanceMean = mean(uStarGeneralized - uStar);
absDistanceMean = mean(abs(uStarGeneralized - uStar));
distanceMax = max(uStarGeneralized - uStar);
distanceMin = min(uStarGeneralized - uStar);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Average FERU: %4.3f \n', uStarMean)
fprintf('* Maximum FERU: %4.3f \n', uStarMax)
fprintf('* Minimum FERU: %4.3f \n', uStarMin)
fprintf('* Average generalized FERU: %4.3f \n', uStarGeneralizedMean)
fprintf('* Maximum generalized FERU: %4.3f \n', uStarGeneralizedMax)
fprintf('* Minimum generalized FERU: %4.3f \n', uStarGeneralizedMin)
fprintf('* Average distance between FERUs: %4.3f \n', distanceMean)
fprintf('* Average absolute distance between FERUs: %4.3f \n', absDistanceMean)
fprintf('* Maximum distance between FERUs: %4.3f \n', distanceMax)
fprintf('* Minimum distance between FERUs: %4.3f \n', distanceMin)
fprintf('\n')
diary off