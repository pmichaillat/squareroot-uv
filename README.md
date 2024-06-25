# u* = √uv : Code and Data

This repository contains the code and data accompanying the paper "u* = √uv", written by [Pascal Michaillat](https://pascalmichaillat.org) and [Emmanuel Saez](https://eml.berkeley.edu/~saez/), and posted on [arXiv](https://arxiv.org/abs/2206.13012v3) in June 2024.

## Paper webpage

The paper is available at https://pascalmichaillat.org/13/.

## Raw data

The raw data used by the code to produce the results in the paper are stored as CSV files. The data are placed in the folder `raw`. 

+ `20210719_cycle_dates_pasted.csv` – US recession dates, 1930–2023
	+ Source: [National Bureau of Economic Research (2023)](https://www.nber.org/research/data/us-business-cycle-expansions-and-contractions)
+ `CLF16OV.csv` – US labor-force level, 1948–2023
	+ Source: [US Bureau of Labor Statistics (2024a)](https://fred.stlouisfed.org/series/CLF16OV)
+ `CompositeHWI.xlsx - Sheet1.csv` – US vacancy rate, 1951–2020
	+ Source: [Barnichon (2010)](https://docs.google.com/spreadsheets/d/1fkMinSHkjTL99-bLZYFldQ8rHtgh8lxd)
+ `Fig8_B.csv` – US NAIRU, 1960–2017
	+ Source: [Crump, Eusepi, Giannoni, Sahin (2019)](https://www.brookings.edu/articles/a-unified-approach-to-measuring-u/)
+ `figure6.csv` – Elasticity of the US Beveridge curve, 1951–2019
	+ Source: [Michaillat, Saez (2021a)](https://github.com/pmichaillat/unemployment-gap)
+ `HistoricalSeries_JME_2020January.csv` – US unemployment and vacancy rates, 1890–2017
	+ Source: [Petrosky-Nadeau, Zhang (2021)](https://docs.google.com/spreadsheets/d/1Ym0zkHZtIvb73zjLzL2cz_P5lXrulzFgvZpA5ZYyElI)
+ `JTSJOL.csv` – Job openings in the United States, 2001–2023
	+ Source: [US Bureau of Labor Statistics (2024d)](https://fred.stlouisfed.org/series/JTSJOL)
+ `LNU05026642.csv` – Marginally attached workers in the United States, 1994–2023
	+ Source: [US Bureau of Labor Statistics (2024f)](https://fred.stlouisfed.org/series/LNU05026642)
+ `LNU05026645.csv` – Discouraged workers in the United States, 1994–2023
	+ Source: [US Bureau of Labor Statistics (2024e)](https://fred.stlouisfed.org/series/LNU05026645)
+ `NROU.csv` – US NRU, 1949–2023
	+ Source: [US Congressional Budget Office (2024)](https://fred.stlouisfed.org/series/NROU)
+ `NROUST.csv` – US short-term NRU, 1949–2021
	+ Source: [US Congressional Budget Office (2021)](https://fred.stlouisfed.org/series/NROUST)
+ `U4RATE.csv` – US U4 unemployment rate, 1994–2023
	+ Source: [US Bureau of Labor Statistics (2024g)](https://fred.stlouisfed.org/series/U4RATE)
+ `U5RATE.csv` – US U5 unemployment rate, 1994–2023
	+ Source: [US Bureau of Labor Statistics (2024h)](https://fred.stlouisfed.org/series/U5RATE)
+ `UNRATE.csv` – US unemployment (U3) rate, 1948–2023
	+ Source: [US Bureau of Labor Statistics (2024i)](https://fred.stlouisfed.org/series/UNRATE)

## Code

The results in the paper are produced with MATLAB code. The code is placed in the folder `code`.

### Main script

The main script, `main.m`, orchestrates the production of the results in the paper:

+ The script produces the 25 figures presented in the paper. The script generates each figure in a figure window and saves the figures as PDF files. The script saves the data used to generate each figure in CSV files.
+ The script also produces the numerical results associated with each figure. The results are displayed in the command window and saved in Markdown files.

### Setup scripts

Before the computations begin, the main script calls two setup scripts:

+ `setup.m` – Close figure windows, clear workspace and command window, set paths to folders with raw data and figures
+ `formatFigure` – Format default figure, and predefine line and axis styles

### Production scripts

The main script produces the individual figures using a collection of production scripts:

+ `figure1A.m` – Produce figure 1A
+ `figure1B.m` – Produce figure 1B
+ `figure2A.m` – Produce figure 2A
+ `figure2B.m` – Produce figure 2B
+ `figure3A.m` – Produce figure 3A
+ `figure3B.m` – Produce figure 3B
+ `figure4A.m` – Produce figure 4A
+ `figure4B.m` – Produce figure 4B
+ `figure5A.m` – Produce figure 5A
+ `figure5B.m` – Produce figure 5B
+ `figure6A.m` – Produce figure 6A
+ `figure6B.m` – Produce figure 6B
+ `figure7A.m` – Produce figure 7A
+ `figure7B.m` – Produce figure 7B
+ `figure8A.m` – Produce figure 8A
+ `figure8B.m` – Produce figure 8B
+ `figure9.m` – Produce figure 9
+ `figure10A.m` – Produce figure 10A
+ `figure10B.m` – Produce figure 10B
+ `figure11A.m` – Produce figure 11A
+ `figure11B.m` – Produce figure 11B
+ `figure12A.m` – Produce figure 12A
+ `figure12B.m` – Produce figure 12B
+ `figure13.m` – Produce figure 13
+ `figure14.m` – Produce figure 14

Each script produces a figure in a figure window, saves a copy of the figure in PDF format, and saves the data used to generate each figure in CSV files. Each script also produces the numerical results associated with the figure. The results are displayed in the command window and saved in a Markdown file.

### Helper scripts and functions

The production scripts rely on a collection of helper functions:
 
+ `getData345` – Return US U3, U4, U5 unemployment rates, 1994–2023
+ `getElasticity` – Return elasticity of the US Beveridge curve, 1951–2019
+ `getNairu` – Return US NAIRU, 1960–2017
+ `getNru` – Return US NRU, 1949–2023
+ `getNrust` – Return US short-term NRU, 1949–2021
+ `getRecession.m` – Return US recession dates, 1930–2023
+ `getRecession345` – Return US recession dates, 1994–2023
+ `getRecessionDepression.m` – Return US recession dates, 1930–1950
+ `getRecessionPandemic.m` – Return US recession dates, 2020–2023
+ `getRecessionPostwar.m` – Return US recession dates, 1951–2019
+ `getUnemployment.m` – Return US unemployment rate, 1930–2023
+ `getUnemploymentDepression.m` – Return US unemployment rate, 1930–1950
+ `getUnemploymentJolts.m` – Return US unemployment rate, 2001–2023
+ `getUnemploymentPandemic.m` – Return US unemployment rate, 2020–2023
+ `getUnemploymentPostwar.m` – Return US unemployment rate, 1951–2019
+ `getVacancy.m` – Return US vacancy rate, 1930–2023
+ `getVacancyDepression.m` – Return US vacancy rate, 1930–2023
+ `getVacancyJolts.m` – Return US vacancy rate, 2001–2023
+ `getVacancyPandemic.m` – Return US vacancy rate, 2020–2023
+ `getVacancyPostwar.m` – Return US vacancy rate, 1951–2019
+ `makeTimeline.m` – Create quarterly timeline
+ `monthly2quarterly.m` – Convert monthly data to quarterly data

## Figures

The 25 figures produced by the code are saved as 25 PDF files. The data used to generate each figure are saved in 25 CSV files. And the numerical results associated with each figure are saved in Markdown files. All these files are placed in the folder `figures`, each corresponding to a specific figure in the paper:

+ `figure1A.pdf`, `figure1A.csv`, `figure1A.md` – Figure 1A
+ `figure1B.pdf`, `figure1B.csv` – Figure 1B
+ `figure2A.pdf`, `figure2A.csv` – Figure 2A
+ `figure2B.pdf`, `figure2B.csv`, `figure2B.md` – Figure 2B
+ `figure3A.pdf`, `figure3A.csv`, `figure3A.md` – Figure 3A
+ `figure3B.pdf`, `figure3B.csv`, `figure3B.md` – Figure 3B
+ `figure4A.pdf`, `figure4A.csv`, `figure4A.md` – Figure 4A
+ `figure4B.pdf`, `figure4B.csv`, `figure4B.md` – Figure 4B
+ `figure5A.pdf`, `figure5A.csv` – Figure 5A
+ `figure5B.pdf`, `figure5B.csv`, `figure5B.md` – Figure 5B
+ `figure6A.pdf`, `figure6A.csv` – Figure 6A
+ `figure6B.pdf`, `figure6B.csv`, `figure6B.md` – Figure 6B
+ `figure7A.pdf`, `figure7A.csv`, `figure7A.md` – Figure 7A
+ `figure7B.pdf`, `figure7B.csv`, `figure7B.md` – Figure 7B
+ `figure8A.pdf`, `figure8A.csv`, `figure8A.md` – Figure 8A
+ `figure8B.pdf`, `figure8B.csv`, `figure8B.md` – Figure 8B
+ `figure9.pdf`, `figure9.csv` – Figure 9
+ `figure10A.pdf`, `figure10A.csv`, `figure10A.md` – Figure 10A
+ `figure10B.pdf`, `figure10B.csv`, `figure10B.md` – Figure 10B
+ `figure11A.pdf`, `figure11A.csv`, `figure11A.md` – Figure 11A
+ `figure11B.pdf`, `figure11B.csv`, `figure11B.md` – Figure 11B
+ `figure12A.pdf`, `figure12A.csv`, `figure12A.md` – Figure 12A
+ `figure12B.pdf`, `figure12B.csv`, `figure12B.md` – Figure 12B
+ `figure13.pdf`, `figure13.csv`, `figure13.md` – Figure 13
+ `figure14.pdf`, `figure14.csv`, `figure14.md` – Figure 14

## Software

The results were obtained using MATLAB R2024a on an Apple Silicon Mac running macOS Sonoma 14.5.

## License

The content of this repository is licensed under the terms of the MIT License.