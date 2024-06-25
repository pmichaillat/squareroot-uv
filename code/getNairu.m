%% getNairu
% 
% Return the NAIRU in the United States, 1960–2017
%
%% Syntax
%
%   nairu = getNairu(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * nairu - 232-by-1 column vector
%
%% Description
%
% This function reads and returns the NAIRU (non-accelerating-inflation rate of unemployment) in the United States, 1960–2017.
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The NAIRU is produced by Crump, Eusepi, Giannoni, Sahin (2019).
%

function nairu = getNairu(pathInput)

% Read NAIRU
nairu = readmatrix([pathInput,'Fig8_B.csv'], 'Range', 'G2:G233')./100;