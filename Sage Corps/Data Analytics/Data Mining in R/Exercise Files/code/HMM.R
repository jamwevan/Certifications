# Title:  Hidden Markov Models (HMM)
# File:   HMM.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  datasets,      # R's built-in sample datasets
  depmixS4,      # 
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# SET RANDOM SEED ##########################################

# Set random seed for reproducibility in processes like
# sampling and splitting the data
set.seed(1)  # You can use any number here

# LOAD AND PREPARE DATA ####################################

# We'll use the sample dataset "speed" from depmixS4
data(speed)
str(speed)

# Plot the data
plot(ts(speed[, 1:3]), main = "speed data")

# Take random subsample to save time (if needed)
# df %<>% sample_n(500)

# SPLIT DATA ###############################################

# NOTE: I DIDN'T SPLIT THE DATA WHEN I CREATED THIS EXAMPLE
# A FEW YEARS AGO. I'M NOT SURE HOW TO DO THIS WITH HMM.
# DO YOU HAVE ANY IDEAS?

# Split data into training (trn) and testing (tst) sets
# trn <- df %>% sample_frac(.70)  # 70% in training data
# tst <- df %>% anti_join(trn)    # Rest in testing data

# MODEL DATA ###############################################

# Compare models with different numbers of hidden states.

# Model 1: Joint Gaussian-binomial response with 1 state 
model1 <- depmix(list(rt ~ 1, corr ~ 1), 
  data = speed, 
  nstates = 1,
  family = list(gaussian(), 
    multinomial("identity")
  )
)

fm1 <- fit(model1, verbose = FALSE)

# Model 2: HMM with 2 states and Pacc as covariate
model2 <- depmix(list(rt ~ 1, corr ~ 1), 
  data = speed, 
  nstates = 2,
  family = list(gaussian(), 
    multinomial("identity")
  ), 
  transition = ~ scale(Pacc),
  ntimes = c(168, 134, 137)
)

fm2 <- fit(model2, verbose = FALSE)

# Model 3: HMM with 3 states and Pacc as covariate 
model3 <- depmix(list(rt ~ 1,corr ~ 1), 
  data = speed, 
  nstates = 3,
  family = list(gaussian(), 
    multinomial("identity")
  ), 
  transition = ~ scale(Pacc),
  ntimes = c(168, 134, 137)
)

fm3 <- fit(model3, verbose = FALSE)

# COMPARE MODELS ###########################################

# Want lowest BIC (Bayesian Information Criterion)
plot(1:3, 
  c(BIC(fm1), BIC(fm2), BIC(fm3)),
  ty = "b", 
  xlab = "Model", 
  ylab = "BIC"
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
