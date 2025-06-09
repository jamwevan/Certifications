# Title:  Dataset: AirPassengers
# File:   AirPassengers.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  datasets,      # R's built-in sample datasets
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# LOAD DATA ################################################

# Use the "AirPassengers" dataset from R's built-in
# `datasets` package
?AirPassengers               # Info on data
data("AirPassengers")        # Load the data
AirPassengers                # Show the data
AirPassengers %>% str()      # Structure of data
AirPassengers %>% summary()  # Summary of data
AirPassengers %>%            # Plot the data
  plot(
    main = "Monthly Intl Air Passengers",
    xlab = "Year: 1949-1960",
    ylab = "Monthly Passengers (1000s)",
    ylim = c(0, 700)
  )

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
