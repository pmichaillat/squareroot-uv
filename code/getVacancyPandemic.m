%% getVacancyPandemic
% 
% Return quarterly vacancy rate in the United States, 2020–2023
%
%% Syntax
%
%   v = getVacancyPandemic(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * v – 16-by-1 column vector
%
%% Description
%
% This function constructs and returns the quarterly vacancy rate in the United States, 2020–2023:
%
% # The function reads the monthly vacancy level.
% # The function reads the monthly labor-force level.
% # The function divides vacancy level by labor-force level to obtain the monthly vacancy rate.
% # The function returns the quarterly average of the monthly vacancy rate. 
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data sources
%
% * Monthly vacancy level – US Bureau of Labor Statistics (2024d)
% * Monthly labor-force level – US Bureau of Labor Statistics (2024a)
%
% The data are stored in data.csv.
%

function v = getVacancyPandemic(pathInput)

% Read monthly vacancy level
vLevel = readmatrix([pathInput,'JTSJOL.csv'], 'Range', 'B230:B277');

% Read monthly labor-force level
laborforce = readmatrix([pathInput,'CLF16OV.csv'], 'Range', 'B866:B913');

% Compute monthly vacancy rate
v = vLevel ./ laborforce;

% Take quarterly average of monthly series
v = monthly2quarterly(v);