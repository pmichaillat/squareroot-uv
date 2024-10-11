%% getVacancyPostwar
% 
% Return quarterly vacancy rate in the United States, 1951Q1–2019Q4
%
%% Syntax
%
%   v = getVacancyPostwar(inputFolder)
%
%% Arguments
%
% * inputFolder – String 
% * v – 276-by-1 column vector
%
%% Description
%
% This function constructs the quarterly vacancy rate for the United States, 1951Q1–2019Q4:
%
% * The function reads the monthly vacancy rate, 1951Q1–2000Q4.
% * The function reads the monthly vacancy and labor-force levels, 2001Q1–2019Q4, and divides vacancy level by labor-force level to obtain the monthly vacancy rate, 2001Q1–2019Q4. 
% * The function splices the two monthly vacancy-rate series to produce the monthly vacancy rate for 1951Q1–2019Q4.
% * The function returns the quarterly average of the monthly vacancy rate. 
%
% The argument inputFolder gives the path to the folder with the raw data.
%
%% Data sources
%
% * Monthly vacancy rate, 1951Q1–2000Q4 – Barnichon (2010)
% * Monthly vacancy level, 2001Q1–2019Q4 – US Bureau of Labor Statistics (2024f)
% * Monthly labor-force level, 2001Q1–2019Q4 – US Bureau of Labor Statistics (2024a)
%

function v = getVacancyPostwar(inputFolder)

% Read monthly vacancy rate for 1951Q1–2000Q4
vRate1951 = readmatrix(fullfile(inputFolder,'CompositeHWI.xlsx - Sheet1.csv'), 'Range', 'C9:C608')./100;

% Read monthly vacancy level for 2001Q1–2019Q4
vLevel2001 = readmatrix(fullfile(inputFolder,'JTSJOL.csv'), 'Range', 'B2:B229');

% Read monthly labor-force level for 2001Q1–2019Q4
laborforce = readmatrix(fullfile(inputFolder,'CLF16OV.csv'), 'Range', 'B638:B865');

% Compute monthly vacancy rate for 2001Q1–2019Q4
vRate2001 = vLevel2001 ./ laborforce;

% Splice monthly vacancy rates for 1951Q1–2019Q4
vMonthly = [vRate1951; vRate2001];

% Take quarterly average of monthly series
v = monthly2quarterly(vMonthly);