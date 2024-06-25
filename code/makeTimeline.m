%% makeTimeline
% 
% Create quarterly timeline
%
%% Syntax
%
%   timeline = makeTimeline(year1, year2)
%
%% Arguments
%
% * year1 – integer
% * year2 – integer, greater than year 1
% * timeline – (year2-year1+1)*4-by-1 column vector
%
%% Description
%
% This function returns a quarterly timeline for the period year1–year2, expressed in year.quarter format:
%
% * 1930.0 is 1930Q1
% * 1930.25 is 1930Q2
% * 1930.5 is 1930Q3
% * 1930.75 is 1930Q4
%

function timeline = makeTimeline(year1, year2)

% Produce timeline
timeline = [year1:0.25:(year2+0.75)]';