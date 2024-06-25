%% getRecession
% 
% Return recession dates in the United States, 1930–2023
%
%% Syntax
%
%   [startRecession, endRecession] = getRecession(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * startRecession – 15-by-1 column vector
% * endRecession – 15-by-1 column vector
%
%% Description
%
% This function returns the start and end dates of US recessions, 1930–2023.
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
% The argument pathInput gives the path to the folder with the raw data.
%

function [startRecession, endRecession] = getRecession(pathInput)

%% Get recession dates for three subperiods

% 1930–1950
[startDepression, endDepression]  = getRecessionDepression(pathInput);

% 1951–2019
[startPostwar, endPostwar]  = getRecessionPostwar(pathInput);

% 2020–2023
[startPandemic, endPandemic]  = getRecessionPandemic(pathInput);

%% Splice three series into a long series

startRecession = [startDepression; startPostwar; startPandemic];
endRecession = [endDepression; endPostwar; endPandemic];