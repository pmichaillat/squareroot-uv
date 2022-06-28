%% figure9A.m
% 
% Produce figure 9A
%
%% Description
%
% This script produces figure 9A. The figure displays the quarterly unemployment and vacancy rates in the United States, 1930--1950.
%
%% Output
%
% * The figure is saved as figure9A.pdf.
% * The underlying data are saved in figure9A.xlsx.
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

% Plot unemployment & vacancy rates
plot(timeline, u, purpleSetting{:})
plot(timeline, v, orangeSetting{:})

% Populate axes
set(gca, xSettingDepression{:})
set(gca, 'yLim', [0,0.3], 'yTick', [0:0.05:0.3], 'yTickLabel', [' 0%';' 5%';'10%';'15%';'20%';'25%';'30%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure9A.pdf')

%% --- Save results ---

file = 'figure9A.xlsx';
sheet = 'Figure 9A';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')