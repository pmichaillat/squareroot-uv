%% getTimelinePostwar
% 
% Return quarterly timeline for 1951Q1--2019Q4
%
%% Syntax
%
%   timeline = getTimelinePostwar()
%
%% Output argument
%
% * timeline - 276-by-1 column vector
%
%% Description
%
% This function returns the quarterly timeline for 1951Q1--2019Q4, expressed in year.quarter format:
% * 1951.00 is 1951Q1
% * 1951.25 is 1951Q2
% * 1951.5 is 1951Q3
% * 1951.75 is 1951Q4
%

function timeline = getTimelinePostwar()

% Produce timeline
timeline = [1951:0.25:2019.75]';