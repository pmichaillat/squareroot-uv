%% getUnemploymentPostwar
% 
% Return quarterly unemployment rate in the United States, 1951--2019
%
%% Syntax
%
%   u = getUnemploymentPostwar()
%
%% Output arguments
%
% * u - 276-by-1 column vector
%
%% Description
%
% This function reads the US unemployment rate, 1951--2019, and returns the quarterly average of this monthly series. 
%
%% Data source
%
% The unemployment rate is produced by the Bureau of Labor Statistics (2022) and stored in data.xlsx.
%

function u = getUnemploymentPostwar()

% Read monthly unemployment rate
uMonthly = readmatrix('data.xlsx', 'Sheet', 'Monthly data', 'Range',' C255:C1082')./100;

% Take quarterly average of monthly series
u = monthlyToQuarterly(uMonthly);