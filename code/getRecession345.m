%% getRecession345
% 
% Return recession dates in the United States, 1994Q1–2024Q2
%
%% Syntax
%
%   [startRecession, endRecession] = getRecession345(inputFolder)
%
%% Arguments
%
% * inputFolder – String 
% * startRecession – 3-by-1 column vector
% * endRecession – 3-by-1 column vector
%
%% Description
%
% This function reads the peak dates and trough dates of US business cycles, 1994Q1–2024Q2. It then tranlates them into the start dates and end dates of US recessions: the first month of the recession is the month following the peak, and the last month of the recession is the month of the trough.
%
% The function then expresses the dates in year.quarter format:
%
% * 1999.0 is 1999Q1.
% * 1999.25 is 1999Q2.
% * 1999.5 is 1999Q3.
% * 1999.75 is 1999Q4.
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

function [startRecession, endRecession] = getRecession345(inputFolder)

% Read dates for cycle peaks and troughs
peakTable = readtable(fullfile(inputFolder,'20210719_cycle_dates_pasted.csv'), 'Range', 'A34:A36');
troughTable = readtable(fullfile(inputFolder,'20210719_cycle_dates_pasted.csv'), 'Range', 'B34:B36');

% Transform tables into datetime arrays
peakArray = table2array(peakTable);
troughArray = table2array(troughTable);

% Translate cycle peaks and troughs into recession starts and ends
startArray = peakArray + calmonths(1);
endArray = troughArray;

% Translate dates into numbers, rounded to the current quarter
startRecession = year(startArray) + floor((month(startArray) - 1)./3) ./ 4; 
endRecession = year(endArray) + floor((month(endArray) - 1)./3) ./ 4;