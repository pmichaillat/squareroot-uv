%% figure4A.m
% 
% Produce figure 4A
%
%% Description
%
% This script produces figure 4A. The figure displays the quarterly unemployment rate, vacancy rate, & efficient unemployment rate in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure4A.pdf.
% * The underlying data are saved in figure4A.xlsx.
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

% Plot unemployment rate, vacancy rate, & efficient unemployment rate
plot(timeline, u, purpleSetting{:})
plot(timeline, v, orangeSetting{:})
plot(timeline, uStar, pinkSetting{:})

% Populate axes
set(gca, xSettingPostwar{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure4A.pdf')

%% --- Save results ---

file = 'figure4A.xlsx';
sheet = 'Figure 4A';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate', 'Efficient unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v, uStar];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')