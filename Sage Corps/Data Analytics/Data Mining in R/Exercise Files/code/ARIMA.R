# Title:  ARIMA: Autoregressive Integrated Moving Average
# File:   ARIMA.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  datasets,      # R's built-in sample datasets
  forecast,      # Time series analysis
  ggfortify,     # Time series graphing
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# Set random seed for reproducibility in processes like
# splitting the data. You can use any number.
set.seed(1)

# LOAD AND PREPARE DATA ####################################

# Use `AirPassengers` data from R's `datasets` package
?AirPassengers

# Save data to `df`, which allows code to be reused
df <- AirPassengers

# See data
df

# Plot data
df %>% 
  plot(
    main = "Monthly Intl Air Passengers",
    xlab = "Year: 1949-1960",
    ylab = "Monthly Passengers (1000s)",
    ylim = c(0, 700)
  )

# SPLIT DATA ###############################################

# Use data from 1949 through 1957 for training
trn <- df %>% window(end = c(1957, 12))
trn      # Show data in Console
trn %>%  # Plot data
  plot(
    main = "Monthly Intl Air Passengers: Training Data",
    xlab = "Year: 1949-1957",
    ylab = "Monthly Passengers (1000s)",
    ylim = c(0, 700)
  )

# Use data from 1958 through 1960 for testing
tst <- df %>% window(start = 1958)
tst      # Show data in Console
tst %>%  # Plot data
  plot(
    main = "Monthly Intl Air Passengers: Testing Data",
    xlab = "Year: 1958-1960",
    ylab = "Monthly Passengers (1000s)",
    ylim = c(0, 700)
  )

# TEST STATIONARITY ########################################

# ARIMA requires non-stationary data. That is, ARIMA needs
# data where means that the mean, the variance, and/or the
# covariance vary over time. Non-stationary data shows
# significant correlations when lagged. A "correlogram"
# graph shows the degree of correlation at different values
# of lag. Ideally, none of the lag values will fall in the
# range of nonsignificant correlations.
trn %>% acf()

# LINEAR MODEL #############################################

# Graph time series using with linear regression line; the 
# `autoplot` functions helps ggplot2 work well with many 
# kinds of data, including time-series data
trn %>% 
  autoplot() +
  geom_smooth(      # Add a trend line
    method = "lm",  # Use linear regressions
    aes(y = value)  # Predict `value` in time-series
  ) +
  labs(
    x = "Year",
    y = "Monthly Passengers",
    title = "Monthly Intl Air Passengers 1949-1958"
  )

# MODEL DATA ###############################################

# Test auto ARIMA to have the best p, q, d parameters
trn %>% auto.arima()

# auto.arima suggests ARIMA(1,1,0)(0,1,0)[12] 
# First set of numbers is for the basic, non-seasonal model
#   1    # p: Auto-regressive (AR) order
#   1    # d: Integrate (I), or degree of differencing
#   0    # q: Moving average (MA) order
# Second set of numbers is for seasonality
#   0    # P: Auto-regressive (AR) order
#   1    # D: Integrate (I), or degree of differencing
#   0    # Q: Moving average (MA) order
# Number in square brackets (usually written as subscript)
#   12:  # M: Model period or seasonality

# See the diagnostic plots: standardized residuals, ACF 
# (autocorrelation function) of residuals, and the Ljung-Box
# test for autocorrelations
trn %>% 
  auto.arima() %>%
  ggtsdiag()

# FORECAST AND EVALUATE ####################################

# Use `auto.arima` to predict intervals for last three
# years; print and graph predictions, add observed values
# from testing data
trn %>% 
  auto.arima() %>%
  forecast(
    level = 95,     # 95% confidence level
    h = 36          # Forecast 36 months
  ) %T>%            # T-pipe
  print() %>%
  plot()
tst %>% lines(lwd = 2, col = "red")  # Add testing data

# CLEAN UP #################################################

# Clear data
rm(list = ls())  # Removes all objects from the environment

# Clear packages
detach("package:datasets", unload = T)  # For base packages
p_unload(all)  # Remove all contributed packages

# Clear plots
graphics.off()  # Clears plots, closes all graphics devices

# Clear console
cat("\014")  # Mimics ctrl+L

# Clear R
#   You may want to use Session > Restart R, as well, which 
#   resets changed options, relative paths, dependencies, 
#   and so on to let you start with a clean slate

# Clear mind :)
