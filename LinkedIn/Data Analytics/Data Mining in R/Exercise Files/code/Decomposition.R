# Title:  Time-Series Decomposition
# File:   Decomposition.R
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

# Use `AirPassengers` data from R's `datasets` package
?AirPassengers

# Save data to `df`, which allows code to be reused
df <- AirPassengers

# EXPLORE DATA #############################################

# See entire dataset
df

# Plot time series
df %>% 
  plot(
    main = "Monthly Intl Air Passengers",
    xlab = "Year: 1949-1960",
    ylab = "Monthly Passengers (1000s)",
    ylim = c(0, 700)
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
    main = "Change Points for Air Passengers 1949-1960",
    xlab = "Year"
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
