%% getRecessionDepression
% 
% Return recession dates in the United States, 1930Q1–1950Q4
%
%% Syntax
%
%   [startRecession, endRecession] = getRecessionDepression(inputFolder)
%
%% Arguments
%
% * inputFolder – String 
% * startRecession – 4-by-1 column vector
% * endRecession – 4-by-1 column vector
%
%% Description
%
% This function reads the peak dates and trough dates of US business cycles, 1930Q1–1950Q4. It then tranlates them into the start dates and end dates of US recessions: the first month of the recession is the month following the peak, and the last month of the recession is the month of the trough.
%
% The function then expresses the dates in year.quarter format:
%
% * 1930.0 is 1930Q1.
% * 1930.25 is 1930Q2.
% * 1930.5 is 1930Q3.
% * 1930.75 is 1930Q4.
% 
% The function finally returns all the dates:
%
% * The start dates are stored in startRecession.
% * The end dates are stored in endRecession.
%
% The argument inputFolder gives the path to the folder with the raw data.
%
%% Data source
%
% * National Bureau of Economic Research (2023)
%

function [startRecession, endRecession] = getRecessionDepression(inputFolder)

% Read dates for cycle peaks and troughs
peakTable = readtable(fullfile(inputFolder,'20210719_cycle_dates_pasted.csv'), 'Range', 'A22:A25');
troughTable = readtable(fullfile(inputFolder,'20210719_cycle_dates_pasted.csv'), 'Range', 'B22:B25');

% Transform tables into datetime arrays
peakArray = table2array(peakTable);
troughArray = table2array(troughTable);

% Translate cycle peaks and troughs into recession starts and ends
startArray = peakArray + calmonths(1);
endArray = troughArray;

% Translate dates into numbers, rounded to the current quarter
startRecession = year(startArray) + floor((month(startArray) - 1)./3) ./ 4; 
endRecession = year(endArray) + floor((month(endArray) - 1)./3) ./ 4;

% Start in the middle of a recession in 1930 
startRecession(1) = max(1930, startRecession(1));