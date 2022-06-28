%% getUnemploymentPandemic
% 
% Return monthly unemployment rate in the United States, 2020M1--2022M3
%
%% Syntax
%
%   u = getUnemploymentPandemic()
%
%% Output arguments
%
% * u - 27-by-1 column vector
%
%% Description
%
% This function reads and returns the monthly unemployment rate in the United States, 2020M1--2022M3.
%
%% Data source
%
% The unemployment rate is produced by the Bureau of Labor Statistics (2022) and stored in data.xlsx.
%

function u = getUnemploymentPandemic()

% Read unemployment rate
u = readmatrix('data.xlsx', 'Sheet', 'Monthly data', 'Range', 'C1083:C1109')./100;