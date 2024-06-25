%% getElasticity
% 
% Return Beveridge elasticity in the United States, 1951–2019
%
%% Syntax
%
%   epsilon = getElasticity(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * epsilon – 276-by-1 column vector
%
%% Description
%
% This function reads and returns the elasticity of the Beveridge curve in the United States, 1951–2019.
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The Beveridge elasticity is produced by Michaillat, Saez (2021a).
%

function epsilon = getElasticity(pathInput)

% Read Beveridge elasticity
epsilon = readmatrix([pathInput,'figure6.csv'], 'Range', 'C3:C278');