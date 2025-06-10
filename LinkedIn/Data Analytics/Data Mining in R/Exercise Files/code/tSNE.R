# Title:  t-SNE: t-Distributed Stochastic Neighbor Embedding 
# File:   tSNE.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  car,           # For scatterplotMatrix
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  Rtsne,         # t-SNE
  tidyverse      # So many reasons
)

# LOAD AND PREPARE DATA ####################################

# Use the `optdigits` datasets that were created previously
# in "HandwrittenDigits.R." We'll use the complete dataset
# `df` instead of the split training/testing datasets
# because t-SNE is primarily an exploratory approach.

# Import the data into `df`
df <- import("data/optdigits.rds")

# Set random seed for reproducibility in processes like
# splitting the data
set.seed(1)  # You can use any number here

# PERPLEXITY = 1 ###########################################

# We'll run several analyses and vary the perplexity to see
# how it affects the outcome, which we'll check by graphing;
# Look for clear separation between classes

# Model the data with t-SNE
df %>%
  select(-y) %>%     # Exclude labels from calculations
  Rtsne(             # Use Rtsne function
    perplexity = 1,  # Value to vary
    verbose = TRUE,  # Give progress updates
    max_iter = 500   # Default is 1000
  ) %>%              # Send results to plot
  .$Y %>%            # Select Y (2 col.) from results
  plot(              # Generic X-Y plot
    col = df$y,      # Color by class label
    pch = 19         # Solid circle
  )

# PERPLEXITY = 2 ###########################################

df %>%
  select(-y) %>% 
  Rtsne(
    perplexity = 2,  # Value to vary
    verbose = TRUE,
    max_iter = 500
  ) %>%
  .$Y %>%
  plot(
    col = df$y,
    pch = 19
  )

# PERPLEXITY = 5 ###########################################

# Common values for perplexity range from 5 to 50

df %>%
  select(-y) %>% 
  Rtsne(
    perplexity = 5,  # Value to vary
    verbose = TRUE,
    max_iter = 500
  ) %>%
  .$Y %>%
  plot(
    col = df$y,
    pch = 19
  )

# PERPLEXITY = 10 ##########################################

df %>%
  select(-y) %>% 
  Rtsne(
    perplexity = 10,  # Value to vary
    verbose = TRUE,
    max_iter = 500
  ) %>%
  .$Y %>%
  plot(
    col = df$y,
    pch = 19
  )

# PERPLEXITY = 50 #########################################

df %>%
  select(-y) %>% 
  Rtsne(
    perplexity = 50,  # Value to vary
    verbose = TRUE,
    max_iter = 500
  ) %>%
  .$Y %>%
  plot(
    col = df$y,
    pch = 19
  )

# CLEAN UP #################################################

# Clear data
rm(list = ls())  # Removes all objects from the environment

# Clear packages
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
