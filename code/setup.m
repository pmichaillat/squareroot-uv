%% setup.m
% 
% Setup script
%
%% Description
%
% This script sets up the computations: 
%
% * Close all figure windows
% * Clears workspace and command window
% * Set paths to input and output folders
%


%% Clear MATLAB

% Close figure windows
close all

% Clear workspace
clear

% Clear command window
clc

%% Set paths to input and output folders

% Path to folder with raw data
pathInput = '../raw/';

% Path to folder with figures and numerical results
pathOutput = '../figures/';

%% Set figure counter

iFigure = 0;