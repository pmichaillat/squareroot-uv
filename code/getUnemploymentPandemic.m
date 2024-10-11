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
% * inputFolder – String 
% * u – 18-by-1 column vector
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 2020Q1–2024Q2, and returns the quarterly average of the series. 
%
% The argument inputFolder gives the path to the folder with the raw data.
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