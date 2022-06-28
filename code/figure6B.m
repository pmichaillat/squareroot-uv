%% figure6B.m
% 
% Produce figure 6B
%
%% Description
%
% This script produces figure 6B. The figure displays the monthly labor-market tightness in the United States, 2020M1--2022M3.
%
%% Output
%
% * The figure is saved as figure6B.pdf.
% * The underlying data are saved in figure6B.xlsx.
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

%% --- Compute labor-market tightness ---

tightness = v ./ u;

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

% Plot labor-market tightness
plot(timeline, tightness, purpleSetting{:})

% Highlight efficient level of tightness
yline(1, thinPinkSetting{:})

% Populate axes
set(gca, xSettingPandemic{:})
set(gca, 'yLim', [0,2], 'yTick', [0:0.25:2])
ylabel('Labor-market tightness')

% Print figure
print('-dpdf', 'figure6B.pdf')

%% --- Save results ---

file = 'figure6B.xlsx';
sheet = 'Figure 6B';
years = floor(timeline);
months = 1+(timeline-years).*12;

% Write header
header = {'Year', 'Month', 'Labor-market tightness'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, months, tightness];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')