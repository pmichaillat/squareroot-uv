%% getVacancyDepression
% 
% Return quarterly vacancy rate in the United States, 1930--1950
%
%% Syntax
%
%   v = getVacancyDepression()
%
%% Output arguments
%
% * v - 84-by-1 column vector
%
%% Description
%
% This function reads the US vacancy rate, 1930--1950, and returns the quarterly average of this monthly series. 
%
%% Data source
%
% The vacancy rate is produced by Petrosky-Nadeau & Zhang (2020) and stored in data.xlsx.
%

function v = getVacancyDepression()

% Input monthly vacancy rate
vMonthly = readmatrix('data.xlsx', 'Sheet', 'Monthly data', 'Range',' H3:H254')./100;

% Take quarterly average of monthly series
v = monthlyToQuarterly(vMonthly);