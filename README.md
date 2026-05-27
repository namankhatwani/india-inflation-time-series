# Time Series Econometric Analysis of India's CPI and Inflation (2013-2025)

## Overview
[cite_start]This project explores the time-dependent behavior of India's Consumer Price Index (CPI) and inflation rate to understand long-term price stability, forecast future trends, and identify structural shifts caused by economic policies and global events[cite: 328, 329]. 

[cite_start]**Author:** Naman Khatwani [cite: 317]

## Data & Methodology
* [cite_start]**Dataset:** All-India Combined CPI and YoY inflation rate (Base 2012=100) from the Ministry of Statistics and Programme Implementation (MoSPI) covering January 2013 to August 2025[cite: 346, 347, 348].
* [cite_start]**Stationarity Testing:** Conducted Augmented Dickey-Fuller (ADF) and Phillips-Perron (PP) tests to determine the integration order[cite: 379, 380].
* [cite_start]**Time-Series Forecasting:** Applied Seasonal ARIMA (SARIMA) modeling (via `auto.arima()` in R) to capture trend and seasonality[cite: 386, 387, 397].
* [cite_start]**Structural Break Detection:** Utilized the Bai-Perron multiple structural breakpoint test to identify regime shifts in the inflation process[cite: 400, 401].

## Key Findings
* [cite_start]**Stationarity:** The CPI index is a non-stationary, integrated process (I(1)) following an upward trend, whereas the first-differenced inflation rate is roughly stationary (I(0))[cite: 568, 768, 769].
* [cite_start]**Predictive Modeling:** The best fit model, SARIMA(2,1,0)(0,1,1)[12], successfully captured annual seasonal effects and forecasts a stable, moderate increase in the CPI over the next 12 months[cite: 635, 771, 773]. 
* [cite_start]**Regime Shifts:** The Bai-Perron test identified three major structural breaks in the inflation rate corresponding to significant macroeconomic shocks[cite: 658, 659, 660]:
    * [cite_start]**2016:** Demonetization and GST implementation[cite: 659, 776].
    * [cite_start]**2020:** Supply shocks and volatility from the COVID-19 pandemic[cite: 660, 777].
    * [cite_start]**2023:** The global commodity correction phase[cite: 660, 778].

## Repository Contents
* `[Insert R Script Name].R` - R script containing data preprocessing, ADF/PP tests, SARIMA model building, and Bai-Perron test execution.
* [cite_start]`ED405 TSE REPORT.pdf` - Comprehensive project report detailing the theoretical framework, statistical outputs, and macroeconomic interpretations[cite: 315].
