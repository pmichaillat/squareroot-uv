%% getElasticity
% 
% Return Beveridge elasticity in the United States, 1951Q1–2019Q4
%
%% Syntax
%
%   epsilon = getElasticity(inputFolder)
%
%% Arguments
%
% * inputFolder – Path to folder with raw data
% * epsilon – 276-by-1 column vector
%
%% Description
%
% This function reads and returns the elasticity of the Beveridge curve in the United States, 1951Q1–2019Q4.
%
%% Data source
%
% * Michaillat and Saez (2021a)
%

function epsilon = getElasticity(inputFolder)

% Read Beveridge elasticity
epsilon = readmatrix(fullfile(inputFolder,'figure6.csv'), 'Range', 'C3:C278');