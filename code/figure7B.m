%% figure7B.m
% 
% Produce figure 7B
%
%% Description
%
% This script produces figure 7B. The figure displays the monthly unemployment gap in the United States, 2020M1--2022M3.
%
%% Output
%
% * The figure is saved as figure7B.pdf.
% * The underlying data are saved in figure7B.xlsx.
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

% Paint unemployment gap
a = area(timeline, [uStar, max(u - uStar,0), min(u - uStar,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = purple;
a(3).FaceColor = pink;

% Plot actual unemployment rate & efficient unemployment rate
plot(timeline, u, purpleSetting{:})
plot(timeline, uStar, pinkSetting{:})

% Populate axes
set(gca, xSettingPandemic{:})
set(gca, 'yLim', [0,0.15], 'yTick', [0:0.03:0.15], 'yTickLabel', [' 0%';' 3%';' 6%';' 9%';'12%';'15%'])
ylabel('Share of labor force')

% Print figure
print('-dpdf', 'figure7B.pdf')

%% --- Save results ---

file = 'figure7B.xlsx';
sheet = 'Figure 7B';
years = floor(timeline);
months = 1+(timeline-years).*12;

% Write header
header = {'Year', 'Month', 'Unemployment rate', 'Efficient unemployment rate'};
writecell(header, file, 'Sheet', sheet, 'WriteMode', 'replacefile')

% Write results
result = [years, months, u, uStar];
writematrix(result, file, 'Sheet', sheet, 'WriteMode', 'append')