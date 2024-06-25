%% figure14.m
% 
% Produce figure 14
%
%% Description
%
% This script produces figure 14 and associated numerical results. The figure displays various quarterly unemployment targets in the United States, 1930–2023.
%
% # Full-employment rate of unemployment (FERU)
% # Natural rate of unemployment (NRU)
% # Short-term natural rate of unemployment (NRUST)
% # Non-accelerating-inflation rate of unemployment (NAIRU)
%
%% Output
%
% * The figure is saved as figure14.pdf.
% * The figure data are saved in figure14.csv.
% * The numerical results are saved in figure14.md.
%

%% Specify output files

fileFigure = [pathOutput, 'figure14.pdf'];
fileData = [pathOutput, 'figure14.csv'];
fileResults = [pathOutput, 'figure14.md'];

%% Get data

% Get timelines
timeline = makeTimeline(1930, 2023);
timelineNru = makeTimeline(1949, 2023);
timelineNrust = makeTimeline(1949, 2020);
timelineNairu = makeTimeline(1960, 2017);

% Get recessions dates
[startRecession, endRecession] = getRecession(pathInput);

% Get vacancy rate
v = getVacancy(pathInput);

% Get unemployment rate
u = getUnemployment(pathInput);

% Get NRU
nru = getNru(pathInput);

% Get NRUST
nrust = getNrust(pathInput);

% Get NAIRU
nairu = getNairu(pathInput);

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
ax.YLim = [0, 0.1];
ax.YTick =  [0:0.02:0.1];
ax.YTickLabel = [' 0%'; ' 2%'; ' 4%'; ' 6%'; ' 8%'; '10%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, areaRecession{:});

% Plot unemployment targets
plot(timelineNrust, nrust, linePurpleDot{:})
plot(timelineNru, nru, linePurpleDash{:})
plot(timelineNairu, nairu, lineOrangeDot{:})
plot(timeline, uStar, linePink{:})

% Save figure
print('-dpdf', fileFigure)

%% Save figure data over period when all data are available

% Write header
header = {'Year', 'FERU', 'NRU', 'NRUST', 'NAIRU'};
writecell(header, fileData, 'WriteMode', 'overwrite')

% Compute indices to align all unemployment targets with NAIRU
iStar = find(timelineNairu(1) == timeline);
iNru = find(timelineNairu(1) == timelineNru);
iNrust = find(timelineNairu(1) == timelineNrust);
nNairu = numel(nairu);

% Align unemployment targets with NAIRU
uStarNairu = uStar(iStar:iStar+nNairu-1);
nruNairu = nru(iNru:iNru+nNairu-1);
nrustNairu = nrust(iNrust:iNrust+nNairu-1);

% Write results
data = [timelineNairu, uStarNairu, nruNairu, nrustNairu, nairu];
writematrix(data, fileData, 'WriteMode', 'append')

%% Produce numerical results

% Compute results for FERU
uStarMean = mean(uStar);
uStarMax = max(uStar);
uStarMin = min(uStar);

% Compute results for NAIRU
nairuMean = mean(nairu);
nairuMax = max(nairu);
nairuMin = min(nairu);
distanceNairuMean = mean(nairu - uStarNairu);
absDistanceNairuMean = mean(abs(nairu - uStarNairu));
distanceNairuMax = max(nairu - uStarNairu);
distanceNairuMin = min(nairu - uStarNairu);

% Align FERU with NRU
iStar = find(timelineNru(1) == timeline);
nNru = numel(nru);
uStarNru = uStar(iStar:iStar+nNru-1);

% Compute results for NRU
nruMean = mean(nru);
nruMax = max(nru);
nruMin = min(nru);
distanceNruMean = mean(nru - uStarNru);
absDistanceNruMean = mean(abs(nru - uStarNru));
distanceNruMax = max(nru - uStarNru);
distanceNruMin = min(nru - uStarNru);

% Clear result file
fid = fopen(fileResults, 'w');
fclose(fid);

% Display and save results
diary(fileResults)
fprintf('\n')
fprintf('* Average FERU: %4.3f \n', uStarMean)
fprintf('* Maximum FERU: %4.3f \n', uStarMax)
fprintf('* Minimum FERU: %4.3f \n', uStarMin)
fprintf('* Average NAIRU: %4.3f \n', nairuMean)
fprintf('* Maximum NAIRU: %4.3f \n', nairuMax)
fprintf('* Minimum NAIRU: %4.3f \n', nairuMin)
fprintf('* Average NRU: %4.3f \n', nruMean)
fprintf('* Maximum NRU: %4.3f \n', nruMax)
fprintf('* Minimum NRU: %4.3f \n', nruMin)
fprintf('* Average distance between FERU & NAIRU: %4.3f \n', distanceNairuMean)
fprintf('* Average absolute distance between FERU & NAIRU: %4.3f \n', absDistanceNairuMean)
fprintf('* Maximum distance between FERU & NAIRU: %4.3f \n', distanceNairuMax)
fprintf('* Minimum distance between FERU & NAIRU: %4.3f \n', distanceNairuMin)
fprintf('* Average distance between FERU & NRU: %4.3f \n', distanceNruMean)
fprintf('* Average absolute distance between FERU & NRU: %4.3f \n', absDistanceNruMean)
fprintf('* Maximum distance between FERU & NRU: %4.3f \n', distanceNruMax)
fprintf('* Minimum distance between FERU & NRU: %4.3f \n', distanceNruMin)
fprintf('\n')
diary off