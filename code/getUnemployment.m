%% getUnemployment
% 
% Return quarterly unemployment rate in the United States, 1930–2023
%
%% Syntax
%
%   u = getUnemployment(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * u – 376-by-1 column vector
%
%% Description
%
% This function returns the quarterly unemployment rate in the United States, 1930–2023. 
%
% The argument pathInput gives the path to the folder with the raw data.
%

function u = getUnemployment(pathInput)

%% Get quarterly unemployment rate for three subperiods

% 1930–1950
uDepression = getUnemploymentDepression(pathInput);

% 1951–2019
uPostwar = getUnemploymentPostwar(pathInput);

% 2020–2023
uPandemic = getUnemploymentPandemic(pathInput);

%% Splice three series into a long series

u = [uDepression; uPostwar; uPandemic];