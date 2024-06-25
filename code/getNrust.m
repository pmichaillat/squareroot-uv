%% getNrust
% 
% Return the short-term NRU in the United States, 1949–2021
%
%% Syntax
%
%   nrust = getNrust(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * nrust - 288-by-1 column vector
%
%% Description
%
% This function reads and returns the short-term NRU (natural/noncyclical rate of unemployment) in the United States, 1949–2021.
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The short-term NRU is produced by the US Congressional Budget Office (2021).
%

function nrust = getNrust(pathInput)

% Read short-term NRU
nrust = readmatrix([pathInput,'NROUST.csv'], 'Range', 'B2:B289')./100;