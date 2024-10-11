%% getUnemploymentDepression
% 
% Return quarterly unemployment rate in the United States, 1930Q1–1950Q4
%
%% Syntax
%
%   u = getUnemploymentDepression(inputFolder)
%
%% Arguments
%
% * inputFolder – String 
% * u – 84-by-1 column vector
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 1930Q1–1950Q4, and returns the quarterly average of the series. 
%
% The argument inputFolder gives the path to the folder with the raw data.
%
%% Data source
%
% * Petrosky-Nadeau and Zhang (2021)
%

function u = getUnemploymentDepression(inputFolder)

% Read monthly unemployment rate
uMonthly = readmatrix(fullfile(inputFolder,'HistoricalSeries_JME_2020January.csv'), 'Range', 'B486:B737')./100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);