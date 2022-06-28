%% getTimeline
% 
% Return quarterly timeline for 1930Q1--2022Q1
%
%% Syntax
%
%   timeline = getTimeline()
%
%% Output argument
%
% * timeline - 369-by-1 column vector
%
%% Description
%
% This function returns the quarterly timeline for 1930Q1--2022Q1, expressed in year.quarter format:
% * 1930.00 is 1930Q1
% * 1930.25 is 1930Q2
% * 1930.5 is 1930Q3
% * 1930.75 is 1930Q4
%

function timeline = getTimeline()

% Produce timeline
timeline = [1930:0.25:2022]';