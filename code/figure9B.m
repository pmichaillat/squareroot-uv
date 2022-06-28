%% figure9B.m
% 
% Produce figure 9B
%
%% Description
%
% This script produces figure 9B. The figure displays on a log scale the quarterly unemployment and vacancy rates in the United States, 1930--1950.
%
%% Output
%
% * The figure is saved as figure9B.pdf.
% * The underlying data are saved in figure9B.xlsx.
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

% Plot unemployment & vacancy rates
semilogy(timeline, u, purpleSetting{:})
hold on
semilogy(timeline, v, orangeSetting{:})

% Populate axes
set(gca, xSettingDepression{:})
set(gca, 'yLim', [0.005,0.30], 'yTick', [0.005,0.01,0.05,0.1:0.1:0.30], 'yTickLabel', ['0.5%';'  1%';'  5%';' 10%';' 20%';' 30%'])
ylabel('Share of labor force')
box off

% Print figure
print('-dpdf', 'figure9B.pdf')

%% --- Save results ---

file = 'figure9B.xlsx';
sheet = 'Figure 9B';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')