%% figure12B.m
% 
% Produce figure 12B
%
%% Description
%
% This script produces figure 12B. The figure displays the quarterly labor-market tightness in the United States, 1930Q1--2022Q1.
%
%% Output
%
% * The figure is saved as figure12B.pdf.
% * The underlying data are saved in figure12B.xlsx.
%

close all
clear
clc

%% --- Get data ---

% Get timeline
timeline = getTimeline();

% Get recessions dates
[startRecession, endRecession, nRecession] = getRecession();

% Get unemployment rate
u = getUnemployment();

% Get vacancy rate
v = getVacancy();

%% --- Compute labor-market tightness ---

theta = v ./ u;

%% --- Format figure & plot ---

formatLongPlot

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
set(gca, xSetting{:})
set(gca, 'yLim', [0,7], 'yTick', [0:1:7])
ylabel('Labor-market tightness')

% Print figure
print('-dpdf', 'figure12B.pdf')

%% --- Save results ---

file = 'figure12B.xlsx';
sheet = 'Figure 12B';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Labor-market tightness'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, theta];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')