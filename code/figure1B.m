%% figure1B.m
% 
% Produce figure 1B
%
%% Description
%
% This script produces figure 1B. The figure displays on a log scale the quarterly unemployment and vacancy rates in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure1B.pdf.
% * The underlying data are saved in figure1B.xlsx.
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

% Plot unemployment & vacancy rates
semilogy(timeline, u, purpleSetting{:})
hold on
semilogy(timeline, v, orangeSetting{:})

% Populate axes
set(gca, xSettingPostwar{:})
set(gca, 'yLim', [0.01,0.12], 'yTick', [0.01,0.03:0.03:0.12], 'yTickLabel', [' 1%';' 3%';' 6%';' 9%';'12%'])
ylabel('Share of labor force')
box off

% Print figure
print('-dpdf', 'figure1B.pdf')

%% --- Save results ---

file = 'figure1B.xlsx';
sheet = 'Figure 1B';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')