%% getVacancy
% 
% Return quarterly vacancy rate in the United States, 1930Q1--2022Q1
%
%% Syntax
%
%   v = getVacancy()
%
%% Output arguments
%
% * v - 369-by-1 column vector
%
%% Description
%
% This function returns the quarterly vacancy rate in the United States, 1930Q1--2022Q1. 
%

function v = getVacancy()

%% --- Input quarterly vacancy rate for three subperiods ---

% 1930Q1--1950Q4
vDepression = getVacancyDepression();

% 1951Q1--2019Q4
vPostwar = getVacancyPostwar();

% 2020Q1--2022Q1
vPandemic = monthlyToQuarterly(getVacancyPandemic());

%% --- Splice three series into a long series ---

v = [vDepression; vPostwar; vPandemic];