%% getVacancyPostwar
% 
% Return quarterly vacancy rate in the United States, 1951--2019
%
%% Syntax
%
%   v = getVacancyPostwar()
%
%% Output arguments
%
% * v - 276-by-1 column vector
%
%% Description
%
% This function constructs the US vacancy rate, 1951--2019, by following the steps described in Michaillat & Saez (2021, p. 2):
% # The function reads the US vacancy rate, 1951--2000.
% # The function reads the US vacancy and labor-force levels, 2001--2019, and divides vacancy level by labor-force level to obtain the US vacancy rate, 2001--2019. 
% # The function splices the two vacancy-rate series to produce the monthly vacancy rate in the United States, 1951--2019.
% # The function returns the quarterly average of the monthly vacancy series. 
%
%% Data sources
%
% * US vacancy rate, 1951--2000 - Barnichon (2010)
% * US vacancy level, 2001--2019 - Bureau of Labor Statistics (2022)
% * US labor-force level, 2001--2019 - Bureau of Labor Statistics (2022)
%
% The data are stored in data.xlsx.
%

function v = getVacancyPostwar()

% Read monthly vacancy rate for 1951--2000
vRate1951 = readmatrix('data.xlsx', 'Sheet', 'Monthly data', 'Range', 'F255:F854')./100;

% Read monthly vacancy level for 2001--2019
vLevel2001 = readmatrix('data.xlsx', 'Sheet', 'Monthly data', 'Range', 'E855:E1082');

% Read monthly labor-force level for 2001--2019
laborforce = readmatrix('data.xlsx', 'Sheet', 'Monthly data', 'Range', 'D855:D1082');

% Compute vacancy rate for 2001--2019
vRate2001 = vLevel2001 ./ laborforce;

% Splice monthly vacancy rates for 1951--2019
vMonthly = [vRate1951; vRate2001];

% Take quarterly average of monthly series
v = monthlyToQuarterly(vMonthly);