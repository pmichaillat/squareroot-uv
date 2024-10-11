%% getBreak
% 
% Return break dates for US Beveridge curve, 1951Q1–2019Q4
%
%% Syntax
%
%   breakDate = getBreak(inputFolder)
%
%% Arguments
%
% * inputFolder – String 
% * breakDate – 5-by-1 column vector
%
%% Description
%
% This function reads and returns the dates of the structural breaks in the US Beveridge curve between 1951Q1 and 2019Q4.
%
% The argument inputFolder gives the path to the folder with the raw data.
%
%% Data source
%
% * Michaillat and Saez (2021a)
%

function breakDate = getBreak(inputFolder)

% Read Beveridge elasticity
breakDate = readmatrix(fullfile(inputFolder,'figure5.csv'), 'Range', 'A3:A7');