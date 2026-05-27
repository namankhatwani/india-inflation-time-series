# Time Series Econometric Analysis of India's CPI and Inflation (2013–2025)

## Overview
This project explores the time-dependent behavior of India’s Consumer Price Index (CPI) and inflation rate to understand long-term price stability, forecast future trends, and identify structural shifts caused by economic policies and global events.

---

## Data & Methodology

### Dataset
- **Source:** Ministry of Statistics and Programme Implementation (MoSPI)
- **Coverage:** January 2013 – August 2025
- **Variables Used:**
  - All-India Combined CPI (Base Year: 2012 = 100)
  - Year-on-Year (YoY) Inflation Rate

### Econometric Techniques

#### 1. Stationarity Testing
To determine the order of integration and verify whether the series are stationary, the following tests were conducted:
- Augmented Dickey-Fuller (ADF) Test
- Phillips-Perron (PP) Test

#### 2. Time Series Forecasting
Seasonal ARIMA (SARIMA) modeling was applied using `auto.arima()` in R to capture:
- Trend behavior
- Seasonal effects
- Short-run dynamics in CPI movements

#### 3. Structural Break Analysis
The Bai-Perron Multiple Structural Breakpoint Test was used to identify significant regime shifts in the inflation process over time.

---

## Key Findings

### Stationarity Results
- The CPI index was found to be **non-stationary** and integrated of order one, i.e., **I(1)**.
- The first-differenced inflation series was approximately **stationary**, i.e., **I(0)**.

### Forecasting Results
- The best-performing model was:
  
  `SARIMA(2,1,0)(0,1,1)[12]`

- The model effectively captured annual seasonality in the CPI series.
- Forecasts indicate a stable and moderate rise in CPI over the next 12 months.

### Structural Breaks Identified
The Bai-Perron test detected three major structural breaks corresponding to significant macroeconomic events:

#### 2016
- Demonetization
- GST implementation

#### 2020
- COVID-19 pandemic
- Supply chain disruptions and inflation volatility

#### 2023
- Global commodity price correction phase

---

## Repository Contents

- `main_analysis.R`  
  R script containing:
  - Data preprocessing
  - ADF and PP stationarity tests
  - SARIMA model estimation
  - Forecast generation
  - Bai-Perron structural break analysis

- `REPORT_TIME SERIES.pdf`  
  Detailed project report including:
  - Theoretical framework
  - Statistical methodology
  - Model outputs
  - Interpretation of macroeconomic implications

---

## Tools & Libraries Used

### Programming Language
- R

### Major Packages
- `forecast`
- `tseries`
- `urca`
- `strucchange`
- `ggplot2`

---

## Objectives of the Study
- Analyze the long-run behavior of India’s CPI and inflation dynamics
- Examine stationarity and persistence in inflation data
- Forecast future CPI movements using econometric models
- Detect structural shifts associated with policy changes and economic shocks

---

## Conclusion
The study highlights the importance of econometric time-series methods in understanding inflation dynamics in India. The results show that CPI exhibits strong persistence and seasonality, while inflation undergoes distinct regime shifts during major economic events. The SARIMA framework provides reliable short-term forecasting performance, and structural break analysis helps identify critical transitions in the inflationary environment.
