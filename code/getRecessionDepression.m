%% getRecessionDepression
% 
% Return recession dates in the United States, 1930–1950
%
%% Syntax
%
%   [startRecession, endRecession] = getRecessionDepression(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * startRecession – 4-by-1 column vector
% * endRecession – 4-by-1 column vector
%
%% Description
%
% This function reads the start and end dates of US recessions, 1930–1950, and expresses them in year.quarter format:
%
% * 1930.0 is 1930Q1.
% * 1930.25 is 1930Q2.
% * 1930.5 is 1930Q3.
% * 1930.75 is 1930Q4.
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

function [startRecession, endRecession] = getRecessionDepression(pathInput)

% Read month numbers for start and end of recessions
startTable = readtable([pathInput,'20210719_cycle_dates_pasted.csv'], 'Range', 'A22:A25');
endTable = readtable([pathInput,'20210719_cycle_dates_pasted.csv'], 'Range', 'B22:B25');

% Transform table into datetime array 
startArray = table2array(startTable);
endArray = table2array(endTable);

% Translate dates into numbers, rounded to the current quarter
startRecession = year(startArray) + floor((month(startArray) - 1)./3) ./ 4; 
endRecession = year(endArray) + floor((month(endArray) - 1)./3) ./ 4;

% Start in the middle of a recession in 1930 
startRecession(1) = max(1930, startRecession(1));