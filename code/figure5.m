%% figure5.m
% 
% Produce figure 5
%
%% Description
%
% This script produces figure 5. The figure compares the efficient unemployment rate from Michaillat & Saez (2021) with the efficient unemployment rate from this paper. Both efficient unemployment rates are quarterly series and apply to the United States, 1951--2019.
%
%% Output
%
% * The figure is saved as figure5.pdf.
% * The underlying data are saved in figure5.xlsx.
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

% Get efficient unemployment rate from Michaillat & Saez (2021)
uMS21 = getUnemploymentMS21();

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

% Plot efficient unemployment rates
plot(timeline, uMS21, dashPurpleSetting{:})
plot(timeline, uStar, pinkSetting{:})


% Populate axes
set(gca, xSettingPostwar{:})
set(gca, 'yLim', [0,0.06], 'yTick', [0:0.02:0.06], 'yTickLabel', ['0%';'2%';'4%';'6%'])
ylabel('Efficient unemployment rate')

% Print figure
print('-dpdf', 'figure5.pdf')

%% --- Save results ---

file = 'figure5.xlsx';
sheet = 'Figure 5';
years = floor(timeline);
quarters = 1+(timeline-years).*4;

% Write header
header = {'Year', 'Quarter', 'Efficient unemployment rate from this paper', 'Efficient unemployment rate from Michaillat & Saez (2021)'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, quarters, uStar, uMS21];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')