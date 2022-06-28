%% figure10A.m
% 
% Produce figure 10A
%
%% Description
%
% This script produces figure 10A. The figure displays the gap between the quarterly unemployment and vacancy rates in the United States, 1930--1950.
%
%% Output
%
% * The figure is saved as figure10A.pdf.
% * The underlying data are saved in figure10A.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimelineDepression();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecessionDepression();

% Get unemployment rate
u = getUnemploymentDepression();

% Get vacancy rate
v = getVacancyDepression();

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
set(gca, xSettingDepression{:})
set(gca, 'yLim', [0,0.3], 'yTick', [0:0.05:0.3], 'yTickLabel', [' 0%';' 5%';'10%';'15%';'20%';'25%';'30%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure10A.pdf')

%% --- Save results ---

file = 'figure10A.xlsx';
sheet = 'Figure 10A';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')