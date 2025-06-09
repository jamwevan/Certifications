# Title:  MLP: Multilayer Perceptron Neural Networks
# File:   MLP.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  datasets,      # R's built-in sample datasets
  magrittr,      # Pipes
  nnfor,         # Neural networks for time-series data
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

# FIT MLP MODELS ###########################################

# Fit default MLP model; number of hidden nodes = 5 (can add
# the argument hd.auto.type = "set") (takes a few seconds)
fit1  <- trn  %>% mlp()
pred1 <- fit1 %>% forecast(h = 36)
pred1                                  # Show predictions
pred1 %>% plot()                       # Plot predictions
tst   %>% lines(lwd = 2, col = "red")  # Plot testing data

# Fit MLP model with number of hidden nodes determined by
# 20% validation (takes a while; 35 seconds on my machine)
fit2  <- trn  %>% mlp(hd.auto.type = "valid")
pred2 <- fit2 %>% forecast(h = 36)
pred2                                  # Show predictions
pred2 %>% plot()                       # Plot predictions
tst   %>% lines(lwd = 2, col = "red")  # Plot testing data

# Fit MLP model with number of hidden nodes determined by
# 5-fold cross-validation (takes an even longer while; about
# 3 minutes on my machine)
fit3  <- trn  %>% mlp(hd.auto.type = "cv")
pred3 <- fit3 %>% forecast(h = 36)
pred3                                  # Show predictions
pred3 %>% plot()                       # Plot predictions
tst   %>% lines(lwd = 2, col = "red")  # Plot testing data

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
