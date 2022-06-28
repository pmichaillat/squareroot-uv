%% getUnemploymentJolts
% 
% Return monthly unemployment rate in the United States, 2001M1--2022M3
%
%% Syntax
%
%   u = getUnemploymentJolts()
%
%% Output arguments
%
% * u - 255-by-1 column vector
%
%% Description
%
% This function reads and returns the monthly unemployment rate in the United States, 2001M1--2022M3. 
%
%% Data source
%
% The unemployment rate is produced by the Bureau of Labor Statistics (2022) and stored in data.xlsx.
%

function u = getUnemploymentJolts()

% Read unemployment rate
u = readmatrix('data.xlsx','Sheet', 'Monthly data', 'Range',' C855:C1109')./100;