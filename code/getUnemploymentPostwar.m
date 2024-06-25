%% getUnemploymentPostwar
% 
% Return quarterly unemployment rate in the United States, 1951–2019
%
%% Syntax
%
%   u = getUnemploymentPostwar(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * u – 276-by-1 column vector
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 1951–2019, and returns the quarterly average of the series. 
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The monthly unemployment rate is produced by the US Bureau of Labor Statistics (2024i).
%

function u = getUnemploymentPostwar(pathInput)

% Read monthly unemployment rate
uMonthly = readmatrix([pathInput,'UNRATE.csv'], 'Range', 'B38:B865')./100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);