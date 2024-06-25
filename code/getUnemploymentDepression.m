%% getUnemploymentDepression
% 
% Return quarterly unemployment rate in the United States, 1930–1950
%
%% Syntax
%
%   u = getUnemploymentDepression(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * u – 84-by-1 column vector
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 1930–1950, and returns the quarterly average of the series. 
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The monthly unemployment rate is produced by Petrosky-Nadeau, Zhang (2021).
%

function u = getUnemploymentDepression(pathInput)

% Read monthly unemployment rate
uMonthly = readmatrix([pathInput,'HistoricalSeries_JME_2020January.csv'], 'Range', 'B486:B737')./100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);