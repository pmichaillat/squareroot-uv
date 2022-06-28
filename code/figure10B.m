%% figure10B.m
% 
% Produce figure 10B
%
%% Description
%
% This script produces figure 10B. The figure displays the quarterly labor-market tightness in the United States, 1930--1950.
%
%% Output
%
% * The figure is saved as figure10B.pdf.
% * The underlying data are saved in figure10B.xlsx.
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

%% --- Compute labor-market tightness ---

theta = v ./ u;

%% --- Format figure & plot ---

formatStandardPlot

%% --- Produce figure ---

figure(1)
clf
hold on

% Paint recession areas
for iRecession = 1 : nRecession
	area([startRecession(iRecession), endRecession(iRecession)], [7,7], areaSetting{:});
end

% Plot labor-market tightness
plot(timeline, theta, purpleSetting{:})

% Highlight efficient level of tightness
yline(1, thinPinkSetting{:})

% Populate axes
set(gca, xSettingDepression{:})
set(gca, 'yLim', [0,7], 'yTick', [0:1:7])
ylabel('Labor-market tightness')

% Print figure
print('-dpdf', 'figure10B.pdf')

%% --- Save results ---

file = 'figure10B.xlsx';
sheet = 'Figure 10B';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Labor-market tightness'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, theta];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')