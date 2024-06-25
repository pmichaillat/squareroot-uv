%% getVacancy
% 
% Return quarterly vacancy rate in the United States, 1930–2023
%
%% Syntax
%
%   v = getVacancy(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * v – 376-by-1 column vector
%
%% Description
%
% This function returns the quarterly vacancy rate in the United States, 1930–2023. 
%
% The argument pathInput gives the path to the folder with the raw data.
%

function v = getVacancy(pathInput)

%% Get quarterly vacancy rate for three subperiods

% 1930–1950
vDepression = getVacancyDepression(pathInput);

% 1951–2019
vPostwar = getVacancyPostwar(pathInput);

% 2020–2023
vPandemic = getVacancyPandemic(pathInput);

%% Splice three series into a long series

v = [vDepression; vPostwar; vPandemic];