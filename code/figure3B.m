%% figure3B.m
% 
% Produce figure 3B
%
%% Description
%
% This script produces figure 3B. The figure displays the quarterly labor-market tightness in the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure3B.pdf.
% * The underlying data are saved in figure3B.xlsx.
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
	area([startRecession(iRecession), endRecession(iRecession)], [2,2], areaSetting{:});
end

% Plot labor-market tightness
plot(timeline, theta, purpleSetting{:})

% Highlight efficient level of tightness
yline(1, thinPinkSetting{:})

% Populate axes
set(gca, xSettingPostwar{:})
set(gca, 'yLim', [0,1.5], 'yTick', [0:0.25:1.5])
ylabel('Labor-market tightness')

% Print figure
print('-dpdf', 'figure3B.pdf')

%% --- Save results ---

file = 'figure3B.xlsx';
sheet = 'Figure 3B';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Labor-market tightness'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, theta];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')