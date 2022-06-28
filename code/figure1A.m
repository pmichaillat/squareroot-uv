%% figure1A.m
% 
% Produce figure 1A
%
%% Description
%
% This script produces figure 1A. The figure displays the quarterly unemployment and vacancy rates in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure1A.pdf.
% * The underlying data are saved in figure1A.xlsx.
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

% Plot unemployment & vacancy rates
plot(timeline, u, purpleSetting{:})
plot(timeline, v, orangeSetting{:})

% Populate axes
set(gca, xSettingPostwar{:})
set(gca, 'yLim', [0,0.12], 'yTick', [0:0.03:0.12], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure1A.pdf')

%% --- Save results ---

file = 'figure1A.xlsx';
sheet = 'Figure 1A';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')