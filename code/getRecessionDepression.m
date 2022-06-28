%% getRecessionDepression
% 
% Return dates of recessions in the United States between 1930 and 1950
%
%% Syntax
%
%   [startRecession, endRecession, nRecession] = getRecessionDepression()
%
%% Output arguments
%
% * nRecession - scalar
% * startRecession - nRecession-by-1 column vector
% * endRecession - nRecession-by-1 column vector
%
%% Description
%
% This function reads the start and end dates of US recessions, 1930--1950, and expresses them in year.quarter format:
% * 1930.0 is 1930Q1.
% * 1930.25 is 1930Q2.
% * 1930.5 is 1930Q3.
% * 1930.75 is 1930Q4.
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

function [startRecession, endRecession, nRecession] = getRecessionDepression()

% Read month numbers for start and end of recessions
startRecession = readmatrix('data.xlsx','Sheet','Recession dates','Range','C23:C26');
endRecession = readmatrix('data.xlsx','Sheet','Recession dates','Range','D23:D26');
nRecession  =  length(startRecession);

% Translate month numbers (start in January 1800) to years, rounded to the current quarter
startRecession = 1800 + floor((startRecession - 1)./3) ./ 4; 
endRecession = 1800 + floor((endRecession - 1)./3) ./ 4;

% Start in the middle of a recession in 1930 
startRecession(1) = max(1930, startRecession(1));