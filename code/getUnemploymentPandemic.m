%% getUnemploymentPandemic
% 
% Return quarterly unemployment rate in the United States, 2020Q1–2024Q2
%
%% Syntax
%
%   u = getUnemploymentPandemic(inputFolder)
%
%% Arguments
%
% * inputFolder – Path to folder with raw data
% * u – 18-by-1 column vector
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 2020Q1–2024Q2, and returns the quarterly average of the series. 
%
%% Data source
%
% * US Bureau of Labor Statistics (2024k)
%

function u = getUnemploymentPandemic(inputFolder)

% Read monthly unemployment rate
uMonthly = readmatrix(fullfile(inputFolder,'UNRATE.csv'), 'Range', 'B866:B919')./100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);