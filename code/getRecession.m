%% getRecession
% 
% Return recession dates in the United States, 1930Q1–2024Q2
%
%% Syntax
%
%   [startRecession, endRecession] = getRecession(inputFolder)
%
%% Arguments
%
% * inputFolder – Path to folder with raw data
% * startRecession – 15-by-1 column vector
% * endRecession – 15-by-1 column vector
%
%% Description
%
% This function returns the start dates and end dates of US recessions between 1930Q1 and 2024Q2.
%
% * The start dates are stored in startRecession.
% * The end dates are stored in endRecession.
%
% The dates are expressed in year.quarter format:
%
% * 1951.0 is 1951Q1.
% * 1951.25 is 1951Q2.
% * 1951.5 is 1951Q3.
% * 1951.75 is 1951Q4.
%

function [startRecession, endRecession] = getRecession(inputFolder)

%% Get recession dates for three subperiods

% 1930Q1–1950Q4
[startDepression, endDepression]  = getRecessionDepression(inputFolder);

% 1951Q1–2019Q4
[startPostwar, endPostwar]  = getRecessionPostwar(inputFolder);

% 2020Q1–2024Q2
[startPandemic, endPandemic]  = getRecessionPandemic(inputFolder);

%% Splice three series into one continuous series

startRecession = [startDepression; startPostwar; startPandemic];
endRecession = [endDepression; endPostwar; endPandemic];