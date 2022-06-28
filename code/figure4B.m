%% figure4B.m
% 
% Produce figure 4B
%
%% Description
%
% This script produces figure 4B. The figure displays the quarterly unemployment gap in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure4B.pdf.
% * The underlying data are saved in figure4B.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimelinePostwar();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionPostwar();

% Get unemployment rate
u = getUnemploymentPostwar();

% Get vacancy rate
v = getVacancyPostwar();

%% --- Compute efficient unemployment rate ---

uStar = sqrt(u.*v);

%% --- Format figure & plot ---

formatStandardPlot

%% --- Produce figure ---

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [2,2], areaSetting{:});
end

% Paint unemployment gap
a = area(timeline, [uStar, max(u - uStar,0), min(u - uStar,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = purple;
a(3).FaceColor = pink;

% Plot actual unemployment rate & efficient unemployment rate
plot(timeline, u, purpleSetting{:})
plot(timeline, uStar, pinkSetting{:})

% Populate axes
set(gca, xSettingPostwar{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure4B.pdf')

%% --- Save results ---

file = 'figure4B.xlsx';
sheet = 'Figure 4B';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Efficient unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, uStar];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')