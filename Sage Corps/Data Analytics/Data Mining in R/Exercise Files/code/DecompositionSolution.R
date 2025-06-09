# Title:  Solution: Decomposition
# File:   DecompositionSolution.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  changepoint,   # Changepoint analysis
  datasets,      # R's built-in sample datasets
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# LOAD AND PREPARE DATA ####################################

# Use `EuStockMarkets` data from R's `datasets` package.
# This data gives the daily closing prices of major European
# stock indices: Germany's DAX (Ibis), Switzerland's SMI,
# France's CAC, and the UK's FTSE.

# Get info on the dataset
?EuStockMarkets

# See the data (with decimal dates)
EuStockMarkets

# Plot the data
EuStockMarkets %>% plot()

# Decomposition is easiest with just one time series, so
# we'll focus on France's CAC ("Cotation Assistée en
# Continu" or "continuous assisted trading"). We'll select
# that one time series and save it to `df`, which allows
# code to be reused
df <- EuStockMarkets[, 3]  # This selects the third series

# EXPLORE DATA #############################################

# See the time series
df

# Get structure of dataset
df %>% str()

# Histogram of values (ignores time)
df %>% 
  hist(
    main = "CAC Daily Closing Prices, 1991–1998",
    xlab = "Closing Price"
  )

# Plot time series
df %>% 
  plot(
    main = "CAC Daily Closing Prices, 1991–1998",
    xlab = "Year",
    ylab = "Closing Price",
    ylim = c(0, 5000)
  )

# DECOMPOSE TIME SERIES ####################################

# Uses the `decompose` function from R's built-in `stats`
# package; default method is "additive"
df %>% 
  decompose() %>%
  plot()

# Can also specify a multiplicative trend, which is good for
# trends that spread over time; the scales for the seasonal
# and random components are now multipliers instead of
# addends.
df %>% 
  decompose(
    type = "multiplicative"
  ) %>%
  plot()

# CHANGEPOINTS ############################################

# Compute and plot time series with change points; can look
# for changepoints in mean using `cpt.mean()`, in variance
# with `cpt.var()`, or both with `cpt.meanvar()`.
df %>%
  cpt.mean(
    test.stat = "Normal"
  ) %T>%                  # T-pipe
  plot(                   # Add change point lines to plot
    cpt.width = 3,        # Line width
    main = "Change Points for CAC Daily Closing Prices",
    xlab = "Year",
    ylab = "Closing Price",
    ylim = c(0, 5000)
  ) %>% 
  cpts.ts()               # Print change point location(s)

# CLEAN UP #################################################

# Clear data
rm(list = ls())  # Removes all objects from the environment

# Clear packages
detach("package:datasets", unload = T)  # For base packages
p_unload(all)    # Remove all contributed packages

# Clear plots
graphics.off()   # Clears plots, closes all graphics devices

# Clear console
cat("\014")      # Mimics ctrl+L

# Clear R
#   You may want to use Session > Restart R, as well, which 
#   resets changed options, relative paths, dependencies, 
#   and so on to let you start with a clean slate

# Clear mind :)
