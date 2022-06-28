%% figure12A.m
% 
% Produce figure 12A
%
%% Description
%
% This script produces figure 12A. The figure displays the gap between the quarterly unemployment and vacancy rates in the United States, 1930Q1--2022Q1.
%
%% Output
%
% * The figure is saved as figure12A.pdf.
% * The underlying data are saved in figure12A.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecession();

% Get unemployment rate
u = getUnemployment();

% Get vacancy rate
v = getVacancy();

%% --- Format figure & plot ---

formatLongPlot

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
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.26], 'yTick', [0:0.05:0.25], 'yTickLabel', [' 0%';' 5%';'10%';'15%';'20%';'25%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure12A.pdf')

%% --- Save results ---

file = 'figure12A.xlsx';
sheet = 'Figure 12A';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')