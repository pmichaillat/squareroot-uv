%% getRecessionPostwar
% 
% Return recession dates in the United States, 1951–2019
%
%% Syntax
%
%   [startRecession, endRecession] = getRecessionPostwar(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * startRecession – 10-by-1 column vector
% * endRecession – 10-by-1 column vector
%
%% Description
%
% This function reads the start and end dates of US recessions, 1951–2019, and expresses them in year.quarter format:
%
% * 1951.0 is 1951Q1.
% * 1951.25 is 1951Q2.
% * 1951.5 is 1951Q3.
% * 1951.75 is 1951Q4.
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

function [startRecession, endRecession] = getRecessionPostwar(pathInput)

% Read month numbers for start and end of recessions
startTable = readtable([pathInput,'20210719_cycle_dates_pasted.csv'], 'Range', 'A26:A35');
endTable = readtable([pathInput,'20210719_cycle_dates_pasted.csv'], 'Range', 'B26:B35');

% Transform table into datetime array 
startArray = table2array(startTable);
endArray = table2array(endTable);

% Translate dates into numbers, rounded to the current quarter
startRecession = year(startArray) + floor((month(startArray) - 1)./3) ./ 4; 
endRecession = year(endArray) + floor((month(endArray) - 1)./3) ./ 4;