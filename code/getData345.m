%% getData345
% 
% Return quarterly U3, U4, U5 unemployment rates in the United States, 1994–2023.
%
%% Syntax
%
%   [u3, u4, u5, v3, v4, v5] = getData345(pathInput)
%
%% Arguments
%
% * pathInput – string 
% * u3 – 120-by-1 column vector
% * v3 – 120-by-1 column vector
% * u4 – 120-by-1 column vector
% * v4 – 120-by-1 column vector
% * u5 – 120-by-1 column vector
% * v5 – 120-by-1 column vector
%
%% Description
%
% This function produces various quarterly unemployment rates in the United States, 1994–2023:
%
% * u3 – unemployment rate based on concept U3 of unemployment
% * u4 – unemployment rate based on concept U4 of unemployment
% * u5 – unemployment rate based on concept U5 of unemployment
%
% Given that the different notions of unemployment lead to different measures of the labor force, the vacancy rate = vacancy level / labor-force level must be adjusted for consistency when different unemployment concepts are used:
%
% * v3 – vacancy rate consistent with the concept U3 of unemployment
% * v4 – vacancy rate consistent with the concept U4 of unemployment
% * v5 – vacancy rate consistent with the concept U5 of unemployment
%
% The vacancy rates are built from the same vacancy level but different labor-force levels:
%
% * v3 = vacancy level / standard labor force
% * v4 = vacancy level / [standard labor force + discouraged workers]
% * v5 = vacancy level / [standard labor force + marginally attached workers]
%
% The argument pathInput gives the path to the folder with the raw data.
%
%% Data source
%
% * Monthly U3 unemployment rate – US Bureau of Labor Statistics (2024i)
% * Monthly U4 unemployment rate – US Bureau of Labor Statistics (2024g)
% * Monthly U5 unemployment rate – US Bureau of Labor Statistics (2024h)
% * Monthly labor-force participants – US Bureau of Labor Statistics (2024a)
% * Monthly discouraged workers – US Bureau of Labor Statistics (2024e)
% * Monthly marginally attached workers – US Bureau of Labor Statistics (2024f)
%

function [u3, u4, u5, v3, v4, v5] = getData345(pathInput)

%% Produce unemployment rates	

% Read monthly U3 unemployment rate
u3Monthly = readmatrix([pathInput,'UNRATE.csv'], 'Range', 'B554:B913')./100;

% Read monthly U4 unemployment rate
u4Monthly = readmatrix([pathInput,'U4RATE.csv'], 'Range', 'B2:B361')./100;

% Read monthly U5 unemployment rate
u5Monthly = readmatrix([pathInput,'U5RATE.csv'], 'Range', 'B2:B361')./100;

% Take quarterly average of monthly series
u3 = monthly2quarterly(u3Monthly);
u4 = monthly2quarterly(u4Monthly);
u5 = monthly2quarterly(u5Monthly);

%% Compute labor-force levels

% Read monthly number of labor-force participants
laborforce3Monthly= readmatrix([pathInput,'CLF16OV.csv'], 'Range', 'B554:B913');

% Read monthly number of discouraged workers
discouragedMonthly=readmatrix([pathInput,'LNU05026645.csv'],'Range', 'B2:B361');

% Read monthly number of marginally attached workers
marginalMonthly = readmatrix([pathInput,'LNU05026642.csv'],'Range', 'B2:B361');

% Take quarterly average of monthly series
laborforce3 = monthly2quarterly(laborforce3Monthly);
discouraged = monthly2quarterly(discouragedMonthly);
marginal = monthly2quarterly(marginalMonthly);

% Compute labor-force level consistent with U4
laborforce4 = laborforce3 + discouraged;

% Compute labor-force level consistent with U5
laborforce5 = laborforce3 + marginal;

%% Produce vacancy rates

% Get quarterly vacancy rate for 1930–2023
vRate1930 = getVacancy(pathInput);

% Extract quarterly vacancy rate for 1994–2023
n = numel(u3);
vRate = vRate1930(end-n+1:end);

% Convert vacancy rate to vacancy level
vLevel = vRate .* laborforce3;

% Compute vacancy rate consistent with U3
v3 = vLevel./laborforce3;

% Compute vacancy rate consistent with U4
v4 = vLevel./laborforce4;

% Compute vacancy rate consistent with U5
v5 = vLevel./laborforce5;