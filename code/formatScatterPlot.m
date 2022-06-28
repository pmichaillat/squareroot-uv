%% formatStandardPlot.m
% 
% Format scatter plots
%
%% Description
%
% This script formats scatter plots by modifying the default properties of figures and axes. 
%
% The script also provides formatting settings for scattter plots. Each setting is contained in a cell array:
% * pinkSetting - formatting for thin pink line
% * blackSetting - formatting for black dots linked with dashed line
% * orangeSetting - formatting for orange dots
% * purpleSetting - formatting for purple dots
% * lightOrangeSetting - formatting for light orange dots
% * lightPurpleSetting - formatting for light purple dots
%
% Finally, the script provides a color palette composed of purple, pink, black, gray, orange, green, light orange, and light purple. Each color is specified in hexadecimal format (hex triplet) and encoded as a string.
%
%% Examples
%
%   plot(u, v, blackSetting{:})
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
set(groot,'defaultAxesXGrid','on')
set(groot, 'defaultAxesTickDirMode', 'manual')
set(groot,'defaultAxesTickLength',[0 0])
set(groot, 'defaultAxesTickDir', 'out')

%% --- Color palette ---

purple = '#7570b3';
pink = '#e7298a';
black = '#666666';
gray = '#c0c0c0';
orange = '#d95f02';
green = '#1b9e77';
lightOrange = '#fc8d62';
lightPurple = '#8da0cb';

%% --- Formatting settings for scatter plots ---

pinkSetting = 	{'Color', 'LineWidth';
				pink, 2};

blackSetting = {'Color', 'LineWidth', 'MarkerSize', 'MarkerFaceColor', 'LineStyle', 'Marker';
				'black', 1, 9, 'black', '--', 'o'};

orangeSetting = {'Color', 'LineWidth', 'MarkerSize', 'MarkerFaceColor', 'LineStyle', 'Marker';
				orange, 1, 9, orange, 'none', 'o'};

purpleSetting = {'Color', 'LineWidth', 'MarkerSize', 'MarkerFaceColor', 'LineStyle', 'Marker';
				purple, 1, 9, purple, 'none', 'o'};

lightOrangeSetting = {'Color', 'LineWidth', 'MarkerSize', 'MarkerFaceColor', 'LineStyle', 'Marker';
				lightOrange, 1, 9, lightOrange, 'none', 'o'};
		
lightPurpleSetting = {'Color', 'LineWidth', 'MarkerSize', 'MarkerFaceColor', 'LineStyle', 'Marker';
					lightPurple, 1, 9, lightPurple, 'none', 'o'};