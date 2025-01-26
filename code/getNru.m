%% getNru
% 
% Return NRU in the United States, 1949Q1–2024Q2
%
%% Syntax
%
%   nru = getNru(inputFolder)
%
%% Arguments
%
% * inputFolder – Character array with path to raw-data folder
% * nru - 302-by-1 numeric column vector with NRU
%
%% Description
%
% This function reads and returns the NRU (natural/noncyclical rate of unemployment) in the United States, 1949Q1–2024Q2.
%
%% Data source
%
% * Congressional Budget Office (2024)
%

function nru = getNru(inputFolder)

% Read NRU
nru = readmatrix(fullfile(inputFolder, 'NROU.csv'), 'Range', 'B2:B303') ./ 100;
