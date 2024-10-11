%% getUnemploymentJolts
% 
% Return quarterly unemployment rate in the United States, 2001Q1–2024Q2
%
%% Syntax
%
%   u = getUnemploymentJolts(inputFolder)
%
%% Arguments
%
% * inputFolder – String 
% * u – 94-by-1 column vector
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 2001Q1–2024Q2, and returns the quarterly average of the series. 
%
% The argument inputFolder gives the path to the folder with the raw data.
%
%% Data source
%
% * US Bureau of Labor Statistics (2024k)
%

function u = getUnemploymentJolts(inputFolder)

% Read monthly unemployment rate
uMonthly = readmatrix(fullfile(inputFolder,'UNRATE.csv'), 'Range', 'B638:B919')./100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);