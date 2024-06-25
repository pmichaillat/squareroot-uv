%% getRecessionPandemic
% 
% Return recession dates in the United States, 2020–2023
%
%% Syntax
%
%   [startRecession, endRecession] = getRecessionPandemic(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * startRecession – 1-by-1 column vector
% * endRecession – 1-by-1 column vector
%
%% Description
%
% This function reads the start and end dates of US recessions, 2020–2023, and expresses them in year.quarter format:
%
% * 2020.0 is 2020Q1
% * 2020.25 is 2020Q2
% * 2020.5 is 2020Q3
% * 2020.75 is 2020Q4
%
% The function then returns all the dates:
%
% * The start dates are stored in startRecession.
% * The end dates are stored in endRecession.
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% The recessions dates are produced by the National Bureau of Economic Research (2023).
%

function [startRecession, endRecession] = getRecessionPandemic(pathInput)

% Read month numbers for start and end of recessions
startTable = readtable([pathInput,'20210719_cycle_dates_pasted.csv'], 'Range', 'A36:A36');
endTable = readtable([pathInput,'20210719_cycle_dates_pasted.csv'], 'Range', 'B36:B36');

% Transform table into datetime array 
startArray = table2array(startTable);
endArray = table2array(endTable);

% Translate dates into numbers, rounded to the current quarter
startRecession = year(startArray) + floor((month(startArray) - 1)./3) ./ 4; 
endRecession = year(endArray) + floor((month(endArray) - 1)./3) ./ 4;