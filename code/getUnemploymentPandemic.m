%% getUnemploymentPandemic
% 
% Return quarterly unemployment rate in the United States, 2020–2023
%
%% Syntax
%
%   u = getUnemploymentPandemic(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * u – 16-by-1 column vector
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 2020–2023, and returns the quarterly average of the series. 
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The monthly unemployment rate is produced by the US Bureau of Labor Statistics (2024i).
%

function u = getUnemploymentPandemic(pathInput)

% Read monthly unemployment rate
u = readmatrix([pathInput,'UNRATE.csv'], 'Range', 'B866:B913')./100;

% Take quarterly average of monthly series
u = monthly2quarterly(u);