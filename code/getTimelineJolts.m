%% getTimelineJolts
% 
% Return monthly timeline for 2001M1--2022M3
%
%% Syntax
%
%   timeline = getTimelineJolts()
%
%% Output argument
%
% * timeline - 255-by-1 column vector
%
%% Description
%
% This function returns the monthly timeline for 2001M1--2022M3, expressed in year.month format:
% * 2020.00 is 2020M1
% * 2020.08 is 2020M2
% * 2020.17 is 2020M3
% * 2020.25 is 2020M4
%

function timeline = getTimelineJolts()

% Produce timeline
timeline = [2001:(1/12):2022+1/6]';