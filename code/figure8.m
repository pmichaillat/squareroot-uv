%% figure8.m
% 
% Produce figure 8
%
%% Description
%
% This script produces figure 8. The figure displays the Beveridge curve in the United States, 2001M1--2022M3.
%
%% Output
%
% * The figure is saved as figure8.pdf.
% * The underlying data are saved in figure8.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get unemployment rate
u = getUnemploymentJolts();

% Get vacancy rate
v = getVacancyJolts();

%% --- Format figure & plot ---

formatScatterPlot

%% --- Produce figure ---

figure(1)
clf
hold on

% Populate axes
set(gca, 'xLim', [0,0.16], 'xTick', [0:0.04:0.16], 'xTickLabel', [' 0%';' 4%';' 8%';'12%';'16%'])
set(gca, 'yLim', [0,0.08], 'yTick', [0:0.02:0.08], 'yTickLabel', ['0%';'2%';'4%';'6%';'8%'])
xlabel('Unemployment rate')
ylabel('Vacancy rate')

% Plot efficiency line
uRange = [0:0.001:0.20];
vLine = uRange;
plot(uRange, vLine, pinkSetting{:})

% Plot Beveridge curve
plot(u, v, blackSetting{:})

% Highlight inefficiently tight months
tightMonth = [u<v];
plot(u(tightMonth), v(tightMonth), orangeSetting{:})

% Highlight inefficiently slack months
slackMonth = [u>v];
plot(u(slackMonth), v(slackMonth), purpleSetting{:})

% Highlight special inefficiently tight months: Feb. 2020, May 2021, Mar. 2022
nMonth = length(u);
specialTight = [nMonth - 25, nMonth - 10, nMonth];
plot(u(specialTight), v(specialTight), lightOrangeSetting{:})

% Highlight special inefficiently slack months: Oct. 2009, Apr. 2020
specialSlack = [10+8*12, nMonth - 23];
plot(u(specialSlack), v(specialSlack), lightPurpleSetting{:})

% Print figure
set(gca,'Position',get(gca,'Position') + [0.01,0.01,0,0]); 
print('-dpdf', 'figure8.pdf')

%% --- Save results ---

file = 'figure8.xlsx';
sheet = 'Figure 8';
timeline = getTimelineJolts();
years = floor(timeline);
months = 1+(timeline-years).*12;

% Write header
header = {'Year', 'Month', 'Unemployment rate', 'Vacancy rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, months, u, v];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')