%% getUnemploymentPostwar
% 
% Return quarterly unemployment rate in the United States, 1951Q1–2019Q4
%
%% Syntax
%
%   u = getUnemploymentPostwar(inputFolder)
%
%% Arguments
%
% * inputFolder – Path to folder with raw data
% * u – 276-by-1 column vector
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 1951Q1–2019Q4, and returns the quarterly average of the series. 
%
%% Data source
%
% * US Bureau of Labor Statistics (2024k)
%

function u = getUnemploymentPostwar(inputFolder)

% Read monthly unemployment rate
uMonthly = readmatrix(fullfile(inputFolder,'UNRATE.csv'), 'Range', 'B38:B865')./100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);