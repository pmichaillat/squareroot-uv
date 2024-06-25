%% getRecession345
% 
% Return recession dates in the United States, 1994–2023
%
%% Syntax
%
%   [startRecession, endRecession] = getRecession345(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * startRecession – 3-by-1 column vector
% * endRecession – 3-by-1 column vector
%
%% Description
%
% This function reads the start and end dates of US recessions, 1994–2023, and expresses them in year.quarter format:
%
% * 1999.0 is 1999Q1.
% * 1999.25 is 1999Q2.
% * 1999.5 is 1999Q3.
% * 1999.75 is 1999Q4.
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

function [startRecession, endRecession] = getRecession345(pathInput)

% Read month numbers for start and end of recessions
startTable = readtable([pathInput,'20210719_cycle_dates_pasted.csv'], 'Range', 'A34:A36');
endTable = readtable([pathInput,'20210719_cycle_dates_pasted.csv'], 'Range', 'B34:B36');

% Transform table into datetime array 
startArray = table2array(startTable);
endArray = table2array(endTable);

% Translate dates into numbers, rounded to the current quarter
startRecession = year(startArray) + floor((month(startArray) - 1)./3) ./ 4; 
endRecession = year(endArray) + floor((month(endArray) - 1)./3) ./ 4;