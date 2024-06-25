%% formatFigure.m
% 
% Format default figure
%
%% Description
%
% This script modifies the default properties of figures. 
%
% The script also predefines properties for areas, lines, markers, and the x-axis. These properties are contained in cell arrays.
%
% Finally, the script predefines a color palette composed of purple, pink, orange, green, and grays. Each color is specified in hexadecimal format (hex triplet) and encoded as a string.
%
%% Examples
%
%   area(x, y, areaRecession{:})
%   plot(x, y, linePurple{:})
%   plot(x, y, dotOrange{:})
%   plot(x, y, 'Color', pink)
%

createProperty = @(obj) [fieldnames(obj), struct2cell(obj)]';

%% Set default properties for figures

widthFigure = 10;
heightFigure = 5.625;
set(groot, 'defaultFigureUnits', 'inches')
set(groot, 'defaultFigurePosition', [1,1,widthFigure,heightFigure]);
set(groot, 'defaultFigurePaperPosition', [0, 0, widthFigure,heightFigure]);
set(groot, 'defaultFigurePaperSize', [widthFigure,heightFigure]);
set(groot, 'defaultAxesFontName', 'Helvetica')
set(groot, 'defaultAxesFontSize', 14)
set(groot, 'defaultAxesLabelFontSizeMultiplier', 1)
set(groot, 'defaultAxesTitleFontSizeMultiplier', 1)
set(groot, 'defaultAxesTitleFontWeight', 'normal')
set(groot, 'defaultAxesXColor', 'k')
set(groot, 'defaultAxesYColor', 'k')
set(groot, 'defaultAxesGridColor', 'k')
set(groot, 'defaultAxesLineWidth', 0.75)
set(groot, 'defaultAxesYGrid', 'on')
set(groot, 'defaultAxesXGrid', 'off')
set(groot, 'defaultAxesTickDirMode', 'manual')
set(groot, 'defaultAxesTickDir', 'out')
set(groot,'defaultAxesTickLength', [0.003 0.003])
set(groot, 'defaultAxesMinorGridLineStyle', 'none')

%% Predefine color palette

purple = '#7570b3';
pink = '#e7298a';
night = '#000000';
black = '#666666';
gray = '#c0c0c0';
orange = '#d95f02';
green = '#1b9e77';

palette = ['#fcfbfd';'#efedf5';'#dadaeb';'#bcbddc';'#9e9ac8';'#807dba';'#6a51a3';'#54278f';'#3f007d'];

purple1 = palette(1,:);
purple2 = palette(2,:);
purple3 = palette(3,:);
purple4 = palette(4,:);
purple5 = palette(5,:);
purple6 = palette(6,:);
purple7 = palette(7,:);
purple8 = palette(8,:);

palette = ['#f7f4f9';'#e7e1ef';'#d4b9da';'#c994c7';'#df65b0';'#e7298a';'#ce1256';'#980043';'#67001f'];

pink1 = palette(1,:);
pink2 = palette(2,:);
pink3 = palette(3,:);
pink4 = palette(4,:);
pink5 = palette(5,:);
pink6 = palette(6,:);
pink7 = palette(7,:);
pink8 = palette(8,:);
pink9 = palette(9,:);

%% Predefine area properties

clear obj
obj.FaceColor = 'black';
obj.LineStyle = 'none';
obj.FaceAlpha = 0.1;
areaRecession = createProperty(obj);

%% Predefine line properties

clear obj
obj.Color = purple;
obj.LineWidth = 2.1;
linePurple = createProperty(obj);

clear obj
obj.Color = purple;
obj.LineWidth = 1.4;
linePurpleThin = createProperty(obj);

clear obj
obj.Color = purple4;
obj.LineWidth = 2.1;
linePurpleLight = createProperty(obj);

clear obj
obj.Color = purple6;
obj.LineWidth = 2.1;
linePurpleMedium = createProperty(obj);

clear obj
obj.Color = purple8;
obj.LineWidth = 2.1;
linePurpleDark = createProperty(obj);

clear obj
obj.Color = purple6;
obj.LineWidth = 2.1;
obj.LineStyle = ':';
linePurpleDot = createProperty(obj);

clear obj
obj.Color = purple8;
obj.LineWidth = 2.1;
obj.LineStyle = '--';
linePurpleDash = createProperty(obj);

clear obj
obj.Color = pink;
obj.LineWidth = 2.1;
linePink = createProperty(obj);

clear obj
obj.Color = pink;
obj.LineWidth = 0.7;
linePinkThin = createProperty(obj);

clear obj
obj.Color = pink4;
obj.LineWidth = 2.1;
obj.LineStyle = '-.';
linePinkDash = createProperty(obj);

clear obj
obj.Color = pink4;
obj.LineWidth = 2.1;
linePinkLight = createProperty(obj);

clear obj
obj.Color = pink5;
obj.LineWidth = 2.1;
linePinkMedium = createProperty(obj);

clear obj
obj.Color = pink6;
obj.LineWidth = 2.1;
linePinkDark = createProperty(obj);

clear obj
obj.Color = orange;
obj.LineWidth = 2.1;
obj.LineStyle = '-.';
lineOrange = createProperty(obj);

clear obj
obj.Color = orange;
obj.LineWidth = 1.4;
obj.LineStyle = '-.';
lineOrangeThin = createProperty(obj);

clear obj
obj.Color = orange;
obj.LineWidth = 2.1;
obj.LineStyle = '-.';
lineOrangeDot = createProperty(obj);

%% Predefine market properties

obj.Color = black;
obj.LineWidth = 0.7;
obj.MarkerSize = 8;
obj.MarkerFaceColor = black;
obj.LineStyle = '-.';
obj.Marker = 'o';
dotGray = createProperty(obj);

obj.Color = orange;
obj.LineWidth = 1.4;
obj.MarkerSize = 8;
obj.MarkerFaceColor = orange;
obj.LineStyle = 'none';
obj.Marker = 'o';
dotOrange = createProperty(obj);

obj.Color = purple;
obj.LineWidth = 1.4;
obj.MarkerSize = 8;
obj.MarkerFaceColor = purple;
obj.LineStyle = 'none';
obj.Marker = 'o';
dotPurple= createProperty(obj);

%% Predefine axis properties

clear obj
obj.Xlim = [1930, 2023.75];
obj.XTick = [1930, 1945, 1960, 1975, 1990, 2005, 2023];
xTotal = createProperty(obj);

clear obj
obj.Xlim = [1951, 2019.75];
obj.XTick = [1951, 1970, 1985, 2000, 2019];
xPostwar = createProperty(obj);

clear obj
obj.Xlim = [2020, 2023.75];
obj.XTick = [2020, 2021, 2022,2023];
xPandemic = createProperty(obj);

clear obj
obj.Xlim = [1930, 1950.75];
obj.XTick = [1930, 1935, 1940, 1945, 1950];
xDepression = createProperty(obj);

clear obj
obj.Xlim = [1994, 2023.75];
obj.XTick = [1994, 2005, 2015, 2023];
x345 = createProperty(obj);