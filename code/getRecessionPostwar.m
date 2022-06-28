%% getRecessionPostwar
% 
% Return dates of recessions in the United States between 1951 and 2019
%
%% Syntax
%
%   [startRecession, endRecession, nRecession] = getRecessionPostwar()
%
%% Output arguments
%
% * nRecession - scalar
% * startRecession - nRecession-by-1 column vector
% * endRecession - nRecession-by-1 column vector
%
%% Description
%
% This function reads the start and end dates of US recessions, 1951--2019, and expresses them in year.quarter format:
% * 1951.0 is 1951Q1.
% * 1951.25 is 1951Q2.
% * 1951.5 is 1951Q3.
% * 1951.75 is 1951Q4.
%
% The function then returns all the dates:
% * The start dates are stored in startRecession.
% * The end dates are stored in endRecession.
% * The number of recessions is stored in nRecession.
%
%% Data source
%
% The recessions dates are produced by the National Bureau of Economic Research and stored in data.xlsx.
%

function [startRecession, endRecession, nRecession] = getRecessionPostwar()

% Read month numbers for start and end of recessions
startRecession = readmatrix('data.xlsx','Sheet','Recession dates','Range','C27:C36');
endRecession = readmatrix('data.xlsx','Sheet','Recession dates','Range','D27:D36');
nRecession  =  length(startRecession);

% Translate month numbers (start in January 1800) to years, rounded to the current quarter
startRecession = 1800 + floor((startRecession - 1)./3) ./ 4; 
endRecession = 1800 + floor((endRecession - 1)./3) ./ 4;