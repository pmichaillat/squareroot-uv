# Code & Data for "u* = √uv"

This repository contains the code and data associated with the paper ["u* = √uv"](https://www.pascalmichaillat.org/13.html), written by [Pascal Michaillat](https://www.pascalmichaillat.org) and [Emmanuel Saez](https://eml.berkeley.edu/~saez/), and posted on [arXiv](https://doi.org/10.48550/arXiv.2206.13012) in June 2022.

## Data

The data used as input to produce the results in the paper are stored in the Excel file `data.xlsx`, which is placed in the folder `code`. 

## Code

The code used to produce the results in the paper is placed in the folder `code`. The code can be divided into two types of programs:

1. Matlab scripts producing the figures in the paper
2. Matlab helper scripts and functions called by the figure-producing scripts

### Figure-producing scripts

To produce the figures in the paper, run the following Matlab scripts:

* `figure1A.m` - produce figure 1A
* `figure1B.m` - produce figure 1B
* `figure3A.m` - produce figure 3A
* `figure3B.m` - produce figure 3B
* `figure4A.m` - produce figure 4A
* `figure4B.m` - produce figure 4B
* `figure5.m` - produce figure 5
* `figure6A.m` - produce figure 6A
* `figure6B.m` - produce figure 6B
* `figure7A.m` - produce figure 7A
* `figure7B.m` - produce figure 7B
* `figure8.m` - produce figure 8
* `figure9A.m` - produce figure 9A
* `figure9B.m` - produce figure 9B
* `figure10A.m` - produce figure 10A
* `figure10B.m` - produce figure 10B
* `figure11A.m` - produce figure 11A
* `figure11B.m` - produce figure 11B
* `figure12A.m` - produce figure 12A
* `figure12B.m` - produce figure 12B
* `figure12C.m` - produce figure 12C

Each script produces a figure in a Matlab window, saves a copy of the figure in PDF format, and saves a copy of the data plotted in the figure in an Excel file.

Figure 2 is directly borrowed from [Michaillat & Saez (2021, figure 5)](https://github.com/pascalmichaillat/unemployment-gap), so there is no script to produce it.

### Helper scripts and functions

The figure-producing scripts call the following Matlab scripts:

* `formatStandardPlot.m` - format standard plots
* `formatScatterPlot.m` - format scatter plots
* `formatLongPlot.m` - format long plots


The figure-producing scripts also call the following Matlab functions:
 
* `getRecession.m` - return dates of US recessions between 1930Q1 and 2022Q1
* `getRecessionDepression.m` - return dates of US recessions between 1930Q1 and 1950Q4
* `getRecessionPostwar.m` - return dates of US recessions between 1951Q1 and 2019Q4
* `getRecessionPandemic.m` - return dates of US recessions between 2020M1 and 2022M3
* `getTimeline.m` - return quarterly timeline for 1930Q1--2022Q1
* `getTimelineDepression.m` - return quarterly timeline for 1930Q1--1950Q4
* `getTimelinePostwar.m` - return quarterly timeline for 1951Q1--2019Q4
* `getTimelinePandemic.m` - return quarterly timeline for 2020M1--2022M3
* `getUnemployment.m` - return quarterly US unemployment rate, 1930Q1--2022Q1
* `getUnemploymentDepression.m` - return quarterly US unemployment rate, 1930Q1--1950Q4
* `getUnemploymentPostwar.m` - return quarterly US unemployment rate, 1951Q1--2019Q4
* `getUnemploymentPandemic.m` - return monthly US unemployment rate, 2020M1--2022M3
* `getUnemploymentJolts.m` - return monthly US unemployment rate, 2001M1--2022M3
* `getUnemploymentMS21.m` - return efficient unemployment rate by [Michaillat & Saez (2021)](https://doi.org/10.1016/j.pubecp.2021.100009)
* `getVacancyRate.m` - return quarterly US vacancy rate, 1930Q1--2022Q1
* `getVacancyRateDepression.m` - return quarterly US vacancy rate, 1930Q1--1950Q4
* `getVacancyRatePostwar.m` - return quarterly US vacancy rate, 1951Q1--2019Q4
* `getVacancyRatePandemic.m` - return monthly US vacancy rate, 2020M1--2022M3
* `getVacancyRateJolts.m` - return monthly US vacancy rate, 2001M1--2022M3
* `monthlyToQuarterly.m` - aggregate monthly data to quarterly frequency

## Figures

The 21 figures produced by the code are stored in the folder `figures`, both as PDF files and as Excel files.

### PDF files

The figures produced by the code are saved as PDF files and stored in the subfolder `pdf`. Any PDF file titled `figureX.pdf` corresponds to figure X in the paper.

### Excel files

The data underlying all the figures produced by the code are saved as Excel files and  stored in the subfolder `xlsx`. Any Excel file titled `figureX.xlsx` contains the data pertaining to figure X in the paper.

## Software versions

The results were obtained on a Mac running macOS Monterey 12.4 with Matlab R2021a and Microsoft Excel 16.62.
