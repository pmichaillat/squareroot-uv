%% figure3A.m
% 
% Produce figure 3A
%
%% Description
%
% This script produces figure 3A. The figure displays the gap between the quarterly unemployment and vacancy rates in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure3A.pdf.
% * The underlying data are saved in figure3A.xlsx.
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

% Paint gap between unemployment & vacancy rates
a = area(timeline, [v, max(u - v,0), min(u - v,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = purple;
a(3).FaceColor = orange;

% Plot unemployment & vacancy rates
plot(timeline, u, purpleSetting{:})
plot(timeline, v, orangeSetting{:})

% Populate axes
set(gca, xSettingPostwar{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure3A.pdf')

%% --- Save results ---

file = 'figure3A.xlsx';
sheet = 'Figure 3A';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')