%% getUnemploymentMS21
% 
% Return US efficient unemployment rate by Michaillat & Saez (2021)
%
%% Syntax
%
%   u = getUnemploymentMS21()
%
%% Output arguments
%
% * u - 276-by-1 column vector
%
%% Description
%
% This function reads and returns the efficient unemployment rate for the United States computed by Michaillat & Saez (2021). The series is quarterly and covers 1951--2019. 
%
%% Data source
%
% The efficient unemployment rate is produced by Michaillat & Saez (2021) and stored in data.xlsx.
%

function u = getUnemploymentMS21()

% Read efficient unemployment rate
u = readmatrix('data.xlsx', 'Sheet', 'Quarterly data', 'Range',' C3:C278');