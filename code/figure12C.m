%% figure12C.m
% 
% Produce figure 12C
%
%% Description
%
% This script produces figure 12C. The figure displays the quarterly efficient uunemployment rate in the United States, 1930Q1--2022Q1.
%
%% Output
%
% * The figure is saved as figure12C.pdf.
% * The underlying data are saved in figure12C.xlsx.
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

%% --- Compute efficient unemployment rate ---

uStar = sqrt(u.*v);

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

% Plot efficient unemployment rate
plot(timeline, uStar, pinkSetting{:})

% Populate axes
set(gca, xSetting{:})
set(gca, 'yLim', [0,0.07], 'yTick', [0:0.01:0.07], 'yTickLabel', ['0%';'1%';'2%';'3%';'4%';'5%';'6%';'7%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure12C.pdf')

%% --- Save results ---

file = 'figure12C.xlsx';
sheet = 'Figure 12C';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Efficient unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, uStar];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')