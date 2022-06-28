%% formatStandardPlot.m
% 
% Format standard plots
%
%% Description
%
% This script formats standard plots by modifying the default properties of figures and axes. 
%
% The script also provides formatting settings for standard plots. Each setting is contained in a cell array:
% * areaSetting - formatting for recession areas
% * purpleSetting - formatting for regular purple line
% * pinkSetting - formatting for regular pink line
% * orangeSetting - formatting for regular orange line
% * thinPinkSetting - formatting for thin pink line
% * dashPurpleSetting - formatting for dashed purple line
% * xSettingPostwar - formatting of x-axis for quarterly series from 1951Q1 to 2019Q4
% * xSettingPandemic - formatting of x-axis for monthly series from 2020M1 to 2022M3
% * xSettingDepression - formatting of x-axis for quarterly series from 1930Q1 to 1950Q4
%
% Finally, the script provides a color palette composed of purple, pink, black, gray, orange, green. Each color is specified in hexadecimal format (hex triplet) and encoded as a string.
%
%% Examples
%
%   plot(x, y, purpleSetting{:})
%   area(x, y, areaSetting{:})
%   plot(x, y, 'Color', purple)
%

%% --- Set properties for figures ---

set(groot,'defaultFigureUnits', 'inches')
set(groot,'defaultFigurePosition', [1,1,7.7779,5.8334]);
set(groot,'defaultFigurePaperPosition', [0, 0, 7.7779,5.8334]);
set(groot,'defaultFigurePaperSize', [7.7779,5.8334]);

%% --- Set properties for axes ---

set(groot,'defaultAxesFontName','Helvetica')
set(groot,'defaultAxesFontSize',22)
set(groot,'defaultAxesLabelFontSizeMultiplier',1)
set(groot,'defaultAxesTitleFontSizeMultiplier',1)
set(groot,'defaultAxesTitleFontWeight','normal')
set(groot,'defaultAxesXColor','k')
set(groot,'defaultAxesYColor','k')
set(groot,'defaultAxesGridColor','k')
set(groot,'defaultAxesLineWidth',1)
set(groot,'defaultAxesYGrid','on')
set(groot,'defaultAxesXGrid','off')
set(groot, 'defaultAxesTickDirMode', 'manual')
set(groot,'defaultAxesTickLength',[0.01 0.025])
set(groot, 'defaultAxesTickDir', 'out')

%% --- Color palette ---

purple = '#7570b3';
pink = '#e7298a';
black = '#666666';
gray = '#c0c0c0';
orange = '#d95f02';
green = '#1b9e77';

%% --- Formatting settings for areas ---

areaSetting = 	{'FaceColor', 'LineStyle', 'FaceAlpha';
				'black', 'none', 0.15};

%% --- Formatting settings for lines ---

purpleSetting = {'Color', 'LineWidth';
				purple, 3};

pinkSetting = 	{'Color', 'LineWidth';
				pink, 3};

orangeSetting = {'Color', 'LineWidth';
				orange, 3};

thinPinkSetting = 	{'Color', 'LineWidth';
					pink, 3/2};

dashPurpleSetting = {'Color', 'LineWidth', 'LineStyle';
				purple, 3, '-.'};

%% --- Formatting settings for axes ---

xSettingPostwar = {'Xlim', 'XTick';
			[1951, 2019.75], [1951, 1970, 1985, 2000, 2019]};

xSettingPandemic = {'Xlim', 'XTick';
			[2020, 2022+1/6], [2020, 2021, 2022]};

xSettingDepression = {'Xlim', 'XTick';
			[1930, 1950.75], [1930, 1935, 1940, 1945, 1950]};