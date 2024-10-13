%% getVacancyJolts
% 
% Return quarterly vacancy rate in the United States, 2001Q1–2024Q2
%
%% Syntax
%
%   v = getVacancyJolts(inputFolder)
%
%% Arguments
%
% * inputFolder – Path to folder with raw data
% * v – 94-by-1 column vector
%
%% Description
%
% This function constructs and returns the quarterly vacancy rate in the United States, 2001Q1–2024Q2:
%
% * Reads the monthly vacancy level.
% * Reads the monthly labor-force level.
% * Calculates the monthly vacancy rate by dividing vacancy level by labor-force level.
% * Returns the quarterly average of the monthly vacancy rate. 
%
%% Data source
%
% * Monthly vacancy level – US Bureau of Labor Statistics (2024f)
% * Monthly labor-force level – US Bureau of Labor Statistics (2024a)
%

function v = getVacancyJolts(inputFolder)

% Read monthly vacancy level
vLevel = readmatrix(fullfile(inputFolder,'JTSJOL.csv'), 'Range', 'B2:B283');

% Read monthly labor-force level
laborforce = readmatrix(fullfile(inputFolder,'CLF16OV.csv'), 'Range', 'B638:B919');

% Compute monthly vacancy rate
vMonthly = vLevel ./ laborforce;

% Take quarterly average of monthly series
v = monthly2quarterly(vMonthly);