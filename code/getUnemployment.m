%% getUnemployment
% 
% Return quarterly unemployment rate in the United States, 1930Q1--2022Q1
%
%% Syntax
%
%   u = getUnemployment()
%
%% Output arguments
%
% * u - 369-by-1 column vector
%
%% Description
%
% This function returns the quarterly unemployment rate in the United States, 1930Q1--2022Q1. 
%

function u = getUnemployment()

%% --- Input quarterly unemployment rate for three subperiods ---

% 1930Q1--1950Q4
uDepression = getUnemploymentDepression();

% 1951Q1--2019Q4
uPostwar = getUnemploymentPostwar();

% 2020Q1--2022Q1
uPandemic = monthlyToQuarterly(getUnemploymentPandemic());

%% --- Splice three series into a long series ---

u = [uDepression; uPostwar; uPandemic];