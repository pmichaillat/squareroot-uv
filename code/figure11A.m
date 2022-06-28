%% figure11A.m
% 
% Produce figure 11A
%
%% Description
%
% This script produces figure 11A. The figure displays the quarterly unemployment rate, vacancy rate, & efficient unemployment rate in the United States, 1930--1950.
%
%% Output
%
% * The figure is saved as figure11A.pdf.
% * The underlying data are saved in figure11A.xlsx.
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

% Plot unemployment rate, vacancy rate, & efficient unemployment rate
plot(timeline, u, purpleSetting{:})
plot(timeline, v, orangeSetting{:})
plot(timeline, uStar, pinkSetting{:})

% Populate axes
set(gca, xSettingDepression{:})
set(gca, 'yLim', [0,0.3], 'yTick', [0:0.05:0.3], 'yTickLabel', [' 0%';' 5%';'10%';'15%';'20%';'25%';'30%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure11A.pdf')

%% --- Save results ---

file = 'figure11A.xlsx';
sheet = 'Figure 11A';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate', 'Efficient unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v, uStar];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')