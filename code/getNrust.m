%% getNrust
% 
% Return short-term NRU in the United States, 1949Q1–2020Q4
%
%% Syntax
%
%   nrust = getNrust(inputFolder)
%
%% Arguments
%
% * inputFolder – Path to folder with raw data
% * nrust - 288-by-1 column vector
%
%% Description
%
% This function reads and returns the short-term NRU (natural/noncyclical rate of unemployment) in the United States, 1949Q1–2020Q4.
%
%% Data source
%
% * US Congressional Budget Office (2021)
%

function nrust = getNrust(inputFolder)

% Read short-term NRU
nrust = readmatrix(fullfile(inputFolder,'NROUST.csv'), 'Range', 'B2:B289')./100;