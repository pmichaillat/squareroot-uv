%% figure2.m
% 
% Produce the six panels of figure 2
%
%% Description
%
% This script produces figures 2A, 2B, 2C, 2D, 2E, and 2F. The six panels display on log scales the six branches of the Beveridge curve in the United States, 1951Q1–2019Q4.
%
%% Requirements
%
% * inputFolder – String giving the location of the input folder. By default inputFolder is defined in main.m.
% * outputFolder – String giving the location of the output folder. By default outputFolder is defined in main.m.
% * formatFigure.m – Script defining plot colors and properties. By default formatFigure.m is run in main.m.
%
%% Output
%
% * figure2A.pdf – PDF file with figure 2A
% * figure2B.pdf – PDF file with figure 2B
% * figure2C.pdf – PDF file with figure 2C
% * figure2D.pdf – PDF file with figure 2D
% * figure2E.pdf – PDF file with figure 2E
% * figure2F.pdf – PDF file with figure 2F
% * figure2.csv – CSV file with data underlying figures 2A–2F
%

%% Specify figure name and output files

% Define figure numbers
number = {'2A', '2B', '2C', '2D', '2E', '2F', '2'};

% Construct figure names
clear figureName
figureName{1} = ['Figure ', number{1}];
figureName{2} = ['Figure ', number{2}];
figureName{3} = ['Figure ', number{3}];
figureName{4} = ['Figure ', number{4}];
figureName{5} = ['Figure ', number{5}];
figureName{6} = ['Figure ', number{6}];

% Construct file names
clear figureFile
figureFile{1} = fullfile(outputFolder, ['figure', number{1}, '.pdf']);
figureFile{2} = fullfile(outputFolder, ['figure', number{2}, '.pdf']);
figureFile{3} = fullfile(outputFolder, ['figure', number{3}, '.pdf']);
figureFile{4} = fullfile(outputFolder, ['figure', number{4}, '.pdf']);
figureFile{5} = fullfile(outputFolder, ['figure', number{5}, '.pdf']);
figureFile{6} = fullfile(outputFolder, ['figure', number{6}, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number{7}, '.csv']);

%% Get data

% Produce quarterly timeline
timeline = [1951 : 0.25 : 2019.75]';

% Get unemployment rate
u = getUnemploymentPostwar(inputFolder);

% Get vacancy rate
v = getVacancyPostwar(inputFolder);

% Get break dates in Beveridge curve
breakDate = getBreak(inputFolder);

%% Construct branches of Beveridge curve

% Construct start and end dates for branches
startBranch = [1951; breakDate+0.25];
endBranch = [breakDate; 2019.75];
nBranch = numel(startBranch);

% Get indices for each branch
clear branch
for iBranch = 1 : nBranch 
	branch{iBranch} = [(timeline >= startBranch(iBranch)) & (timeline <= endBranch(iBranch))];
end

%% Produce figures

for iBranch = 1 : nBranch

	fig = figure('NumberTitle', 'off', 'Name', figureName{iBranch});
	hold on
	
	% Set figure to 4:3 ratio
	widthFigure = 8.5;
	heightFigure = 6.375;
	fig.Position = [1,1,widthFigure,heightFigure];
	fig.PaperPosition = [0, 0, widthFigure,heightFigure];
	fig.PaperSize = [widthFigure,heightFigure];

	% Format axes
	ax = gca;
	ax.FontSize = 26;
	ax.LineWidth = 1.3;
	ax.XGrid = 'on';
	ax.TickLength = [0 0];

	% Format x-axis
	ax.XLim = log([0.02,0.16]);
	ax.XTick =  log([0.02,0.04,0.08,0.16]);
	ax.XTickLabel = [' 2%'; ' 4%'; ' 8%'; '16%'];
	ax.XLabel.String =  'Unemployment rate (log scale)';

	% Format y-axis
	ax.YLim = log([0.01,0.08]);
	ax.YTick =  log([0.01,0.02,0.04,0.08]);
	ax.YTickLabel = ['1%'; '2%'; '4%'; '8%'];
	ax.YLabel.String =  'Vacancy rate (log scale)';

	% Readjust axes position slightly to improve figure layout
	ax.Position = ax.Position + [0.002,0.002,0,0]; 

	% Plot background Beveridge curve
	h1 = plot(log(u), log(v));

	% Format background Beveridge curve
	h1.Color = gray;
	h1.LineWidth = 1.3;
	h1.LineStyle = '-.';

	% Plot branch of Beveridge curve
	h2 = plot(log(u(branch{iBranch})), log(v(branch{iBranch})));

	% Format branch of Beveridge curve
	h2.LineStyle = 'none';
	h2.Color = purple;
	h2.MarkerFaceColor = purple;
	h2.Marker = 'o';
	h2.MarkerSize = 9;

	% Save figure
	print('-dpdf', figureFile{iBranch})

end

%% Save figure data

% Create empty matrix for data
data = zeros(numel(timeline), 3 + 2.*nBranch);

%Create initial header
header = {'Year', 'Unemployment rate', 'Vacancy rate'};

% Add initial data
data(:, 1) = timeline;
data(:, 2) = u;
data(:, 3) = v;

% Add data for each branch
for iBranch = 1 : nBranch

	header = {header{:},['Unemployment rate: branch ',num2str(iBranch)],['Vacancy rate: branch ',num2str(iBranch)]};
	data(branch{iBranch}, 3+iBranch.*2-1) = u(branch{iBranch});
	data(branch{iBranch}, 3+iBranch.*2) = v(branch{iBranch});

end

% Write header
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write data
writematrix(round(data,4), dataFile, 'WriteMode', 'append')