%% getRecessionPandemic
% 
% Return dates of recessions in the United States between 2020M1 and 2022M3
%
%% Syntax
%
%   [startRecession, endRecession, nRecession] = getRecessionPandemic()
%
%% Output arguments
%
% * nRecession - scalar
% * startRecession - nRecession-by-1 column vector
% * endRecession - nRecession-by-1 column vector
%
%% Description
%
% This function reads the start and end dates of US recessions, 2020M1--2022M3, and expresses them in year.month format:
% * 2020.00 is 2020M1
% * 2020.08 is 2020M2
% * 2020.17 is 2020M3
% * 2020.25 is 2020M4
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

function [startRecession, endRecession, nRecession] = getRecessionPandemic()

% Read month numbers for start and end of recessions
startRecession = readmatrix('data.xlsx','Sheet','Recession dates','Range','C37:C37');
endRecession = readmatrix('data.xlsx','Sheet','Recession dates','Range','D37:D37');
nRecession  =  length(startRecession);

% Translate month numbers (start in January 1800) to year numbers
startRecession = 1800 + (startRecession - 1) ./ 12; 
endRecession = 1800 + (endRecession - 1) ./ 12;