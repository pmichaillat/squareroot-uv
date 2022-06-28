%% getUnemploymentDepression
% 
% Return quarterly unemployment rate in the United States, 1930--1950
%
%% Syntax
%
%   u = getUnemploymentDepression()
%
%% Output arguments
%
% * u - 84-by-1 column vector
%
%% Description
%
% This function reads the US unemployment rate, 1930--1950, and returns the quarterly average of this monthly series. 
%
%% Data source
%
% The unemployment rate is produced by Petrosky-Nadeau & Zhang (2020) and stored in data.xlsx.
%

function u = getUnemploymentDepression()

% Read monthly unemployment rate
uMonthly = readmatrix('data.xlsx', 'Sheet', 'Monthly data', 'Range',' G3:G254')./100;

% Take quarterly average of monthly series
u = monthlyToQuarterly(uMonthly);