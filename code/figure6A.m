%% figure6A.m
% 
% Produce figure 6A
%
%% Description
%
% This script produces figure 6A. The figure displays the gap between the monthly unemployment & vacancy rates in the United States, 2020M1--2022M3.
%
%% Output
%
% * The figure is saved as figure6A.pdf.
% * The underlying data are saved in figure6A.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimelinePandemic();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionPandemic();

% Get unemployment rate
u = getUnemploymentPandemic();

% Get vacancy rate
v = getVacancyPandemic();

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
set(gca, xSettingPandemic{:})
set(gca, 'yLim', [0,0.15], 'yTick', [0:0.03:0.15], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%';'15%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure6A.pdf')

%% --- Save results ---

file = 'figure6A.xlsx';
sheet = 'Figure 6A';
years = floor(timeline);
months = 1+(timeline-years).*12;

% Write header
header = {'Year', 'Month', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, months, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')