# $u^{\ast} = \sqrt{uv}$ : Code and Data

This repository contains the code and data accompanying the paper "u* = √uv", written by [Pascal Michaillat](https://pascalmichaillat.org) and [Emmanuel Saez](https://eml.berkeley.edu/~saez/), and posted on [arXiv](https://doi.org/10.48550/arXiv.2206.13012) in June 2022.

## Paper webpage

The paper is available at https://pascalmichaillat.org/13/.

## Data

The data used as input to produce the results in the paper are stored in the Excel file `data.xlsx`, which is placed in the folder `code`. 

## Code

The results in the paper are produced with MATLAB code. The code is placed in the folder `code`. There are two types of programs:

1. Scripts producing the figures in the paper
2. Helper scripts and functions called by the figure-producing scripts

### Figure-producing scripts

The figures in the paper are produced bythe following scripts:

+ `figure1A.m` – Produce figure 1A
+ `figure1B.m` – Produce figure 1B
+ `figure3A.m` – Produce figure 3A
+ `figure3B.m` – Produce figure 3B
+ `figure4A.m` – Produce figure 4A
+ `figure4B.m` – Produce figure 4B
+ `figure5.m` – Produce figure 5
+ `figure6A.m` – Produce figure 6A
+ `figure6B.m` – Produce figure 6B
+ `figure7A.m` – Produce figure 7A
+ `figure7B.m` – Produce figure 7B
+ `figure8.m` – Produce figure 8
+ `figure9A.m` – Produce figure 9A
+ `figure9B.m` – Produce figure 9B
+ `figure10A.m` – Produce figure 10A
+ `figure10B.m` – Produce figure 10B
+ `figure11A.m` – Produce figure 11A
+ `figure11B.m` – Produce figure 11B
+ `figure12A.m` – Produce figure 12A
+ `figure12B.m` – Produce figure 12B
+ `figure12C.m` – Produce figure 12C

Each script produces a figure in a MATLAB window, saves a copy of the figure in PDF format, and saves a copy of the data plotted in the figure in an Excel file.

Figure 2 is directly borrowed from [Michaillat and Saez (2021, figure 5)](https://pascalmichaillat.org/9/), so there is no script to produce it.

### Helper scripts and functions

The figure-producing scripts call the following helper scripts:

+ `formatStandardPlot.m` – Format standard plots
+ `formatScatterPlot.m` – Format scatter plots
+ `formatLongPlot.m` – Format long plots

The figure-producing scripts also call the following functions:
 
+ `getRecession.m` – Return dates of US recessions between 1930Q1 and 2022Q1
+ `getRecessionDepression.m` – Return dates of US recessions between 1930Q1 and 1950Q4
+ `getRecessionPostwar.m` – Return dates of US recessions between 1951Q1 and 2019Q4
+ `getRecessionPandemic.m` – Return dates of US recessions between 2020M1 and 2022M3
+ `getTimeline.m` – Return quarterly timeline for 1930Q1–2022Q1
+ `getTimelineDepression.m` – Return quarterly timeline for 1930Q1–1950Q4
+ `getTimelinePostwar.m` – Return quarterly timeline for 1951Q1–2019Q4
+ `getTimelinePandemic.m` – Return monthly timeline for 2020M1–2022M3
+ `getTimelineJolts.m` – Return monthly timeline for 2001M1–2022M3
+ `getUnemployment.m` – Return quarterly US unemployment rate, 1930Q1–2022Q1
+ `getUnemploymentDepression.m` – Return quarterly US unemployment rate, 1930Q1–1950Q4
+ `getUnemploymentPostwar.m` – Return quarterly US unemployment rate, 1951Q1–2019Q4
+ `getUnemploymentPandemic.m` – Return monthly US unemployment rate, 2020M1–2022M3
+ `getUnemploymentJolts.m` – Return monthly US unemployment rate, 2001M1–2022M3
+ `getUnemploymentMS21.m` – Return the efficient unemployment rate by [Michaillat and Saez (2021)](https://pascalmichaillat.org/9/)
+ `getVacancyRate.m` – Return quarterly US vacancy rate, 1930Q1–2022Q1
+ `getVacancyRateDepression.m` – Return quarterly US vacancy rate, 1930Q1–1950Q4
+ `getVacancyRatePostwar.m` – Return quarterly US vacancy rate, 1951Q1–2019Q4
+ `getVacancyRatePandemic.m` – Return monthly US vacancy rate, 2020M1–2022M3
+ `getVacancyRateJolts.m` – Return monthly US vacancy rate, 2001M1–2022M3
+ `monthlyToQuarterly.m` – Aggregate monthly data to quarterly frequency

## Figures

The 21 figures produced by the code are stored both as PDF files and as Excel files. The figures are placed in the folder `figures`.

### PDF files

The figures are saved as PDF files and stored in the subfolder `pdf`. Any PDF file titled `figureX.pdf` corresponds to figure X in the paper.

### Excel files

The data underlying the figures are saved as Excel files and stored in the subfolder `xlsx`. Any Excel file titled `figureX.xlsx` contains the data plotted in figure X in the paper.

## Software

The results were obtained on a Mac running macOS Ventura 13.2 with MATLAB R2022b and Microsoft Excel 16.71.

## License

The content of this repository is licensed under the terms of the MIT License.
