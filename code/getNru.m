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
% * inputFolder – Path to folder with raw data
% * nru - 302-by-1 column vector
%
%% Description
%
% This function reads and returns the NRU (natural/noncyclical rate of unemployment) in the United States, 1949Q1–2024Q2.
%
%% Data source
%
% * US Congressional Budget Office (2024)
%

function nru = getNru(inputFolder)

% Read NRU
nru = readmatrix(fullfile(inputFolder,'NROU.csv'), 'Range', 'B2:B303')./100;
