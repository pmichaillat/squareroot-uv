%% getNru
% 
% Return the NRU in the United States, 1949–2023
%
%% Syntax
%
%   nru = getNru(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * nru - 300-by-1 column vector
%
%% Description
%
% This function reads and returns the NRU (natural/noncyclical rate of unemployment) in the United States, 1949–2023.
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The NRU is produced by the US Congressional Budget Office (2024).
%

function nru = getNru(pathInput)

% Read NRU
nru = readmatrix([pathInput,'NROU.csv'], 'Range', 'B2:B301')./100;
