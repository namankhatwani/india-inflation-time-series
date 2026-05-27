packages <- c(
  "tidyverse","lubridate","zoo",
  "tseries","urca","forecast","strucchange",
  "rugarch","PerformanceAnalytics","gridExtra"
)

to_install <- setdiff(packages, rownames(installed.packages()))
if(length(to_install)) install.packages(to_install, quiet=TRUE)

invisible(lapply(packages, require, character.only=TRUE))

months <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")

cpi_wide <- readr::read_csv(
  "C:/Users/Naman/Downloads/cpi_index_wide.csv",
  show_col_types = FALSE
)

infl_wide <- readr::read_csv(
  "C:/Users/Naman/Downloads/inflation_wide.csv",
  show_col_types = FALSE
)

cpi_long <- cpi_wide |>
  tidyr::pivot_longer(
    cols = all_of(months),
    names_to = "Month",
    values_to = "CPI_Index"
  ) |>
  dplyr::mutate(
    Date = as.Date(
      paste0(Year,"-",Month,"-01"),
      format="%Y-%b-%d"
    )
  ) |>
  dplyr::arrange(Date) |>
  dplyr::select(Date, CPI_Index)

infl_long <- infl_wide |>
  tidyr::pivot_longer(
    cols = all_of(months),
    names_to = "Month",
    values_to = "Inflation_YoY_Percent"
  ) |>
  dplyr::mutate(
    Date = as.Date(
      paste0(Year,"-",Month,"-01"),
      format="%Y-%b-%d"
    )
  ) |>
  dplyr::arrange(Date) |>
  dplyr::select(Date, Inflation_YoY_Percent)

df <- dplyr::full_join(cpi_long, infl_long, by = "Date") |>
  dplyr::arrange(Date)

df <- df |>
  dplyr::mutate(
    Inflation_YoY_from_CPI =
      100 * ((CPI_Index / dplyr::lag(CPI_Index,12)) - 1)
  )

summary_stats <- df |>
  dplyr::summarise(
    start = min(Date, na.rm=TRUE),
    end   = max(Date, na.rm=TRUE),

    CPI_mean = mean(CPI_Index, na.rm=TRUE),
    CPI_sd   = sd(CPI_Index, na.rm=TRUE),
    CPI_min  = min(CPI_Index, na.rm=TRUE),
    CPI_max  = max(CPI_Index, na.rm=TRUE),

    INF_mean = mean(Inflation_YoY_Percent, na.rm=TRUE),
    INF_sd   = sd(Inflation_YoY_Percent, na.rm=TRUE),
    INF_min  = min(Inflation_YoY_Percent, na.rm=TRUE),
    INF_max  = max(Inflation_YoY_Percent, na.rm=TRUE)
  )

print(summary_stats)

p_cpi <- ggplot(df, aes(Date, CPI_Index)) +
  geom_line() +
  labs(
    title = "CPI (Index, Base 2012=100)",
    x = NULL,
    y = "Index"
  )

p_inf <- ggplot(df, aes(Date, Inflation_YoY_Percent)) +
  geom_line() +
  labs(
    title = "Inflation Rate (YoY, %)",
    x = NULL,
    y = "%"
  )

gridExtra::grid.arrange(p_cpi, p_inf, ncol=1)

start_year <- year(min(df$Date, na.rm=TRUE))
start_mon  <- month(min(df$Date, na.rm=TRUE))

CPI_ts <- ts(
  df$CPI_Index,
  frequency = 12,
  start = c(start_year, start_mon)
)

INF_ts <- ts(
  df$Inflation_YoY_Percent,
  frequency = 12,
  start = c(start_year, start_mon)
)

cat("\nADF (CPI levels):\n")
print(
  ur.df(
    na.omit(CPI_ts),
    type="trend",
    lags=12
  )@teststat
)

cat("PP (CPI levels):\n")
print(
  ur.pp(
    na.omit(CPI_ts),
    type="Z-tau",
    model="trend",
    lags="short"
  )@teststat
)

dCPI_ts <- diff(CPI_ts)

cat("\nADF (diff CPI):\n")
print(
  ur.df(
    na.omit(dCPI_ts),
    type="drift",
    lags=12
  )@teststat
)

cat("\nADF (Inflation YoY):\n")
print(
  ur.df(
    na.omit(INF_ts),
    type="drift",
    lags=12
  )@teststat
)

cat("PP (Inflation YoY):\n")
print(
  ur.pp(
    na.omit(INF_ts),
    type="Z-tau",
    model="constant",
    lags="short"
  )@teststat
)

fit_sarima <- forecast::auto.arima(
  CPI_ts,
  seasonal=TRUE,
  stepwise=FALSE,
  approximation=FALSE,
  ic="aic"
)

cat("\nBest SARIMA model (CPI):\n")
print(fit_sarima)

forecast::checkresiduals(fit_sarima)

fc <- forecast::forecast(fit_sarima, h=12)

autoplot(fc) +
  labs(
    title="SARIMA Forecast (CPI)",
    x=NULL,
    y="Index"
  )

INF_df <- data.frame(y = as.numeric(INF_ts))

bp <- breakpoints(y ~ 1, data = INF_df)

cat("\nBai-Perron BIC-selected breaks (Inflation mean):\n")
print(bp)

plot(bp)
lines(INF_df$y, col=4)

bp3 <- breakpoints(
  y ~ 1,
  data=INF_df,
  breaks=3
)

cat("\n3-break model:\n")
print(bp3)

plot(bp3)
lines(INF_df$y, col=4)

cat("\nEstimated break dates (indexes -> time):\n")
print(breakdates(bp3))

