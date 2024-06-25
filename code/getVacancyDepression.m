%% getVacancyDepression
% 
% Return quarterly vacancy rate in the United States, 1930–1950
%
%% Syntax
%
%   v = getVacancyDepression(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * v – 84-by-1 column vector
%
%% Description
%
% This function reads the monthly vacancy rate in the United States, 1930–1950, and returns the quarterly average of the series. 
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The monthly vacancy rate is produced by Petrosky-Nadeau, Zhang (2021).
%

function v = getVacancyDepression(pathInput)

% Read monthly vacancy rate
vMonthly = readmatrix([pathInput,'HistoricalSeries_JME_2020January.csv'], 'Range', 'D486:D737')./100;

% Take quarterly average of monthly series
v = monthly2quarterly(vMonthly);