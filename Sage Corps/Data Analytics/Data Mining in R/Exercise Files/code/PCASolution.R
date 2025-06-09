# Title:  Solution: PCA
# File:   PCASolution.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  car,           # For scatterplotMatrix
  datasets,      # R's built-in sample datasets
  ggbiplot,      # Create biplots
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  tidyverse      # So many reasons
)

# LOAD DATA ################################################

# Use the `swiss` dataset from R's built-in `datasets`
# package

?swiss

# Import data into `df`
df <- swiss %>% as_tibble()

df

# EXPLORE DATA #############################################

# Make a scatter plot matrix of the variables
df %>% scatterplotMatrix()

# PRINCIPAL COMPONENT ANALYSIS #############################

# Principal components model using default method
pc <- df %>% 
  prcomp(           # Most common method
    center = TRUE,  # Centers means to 0
    scale  = TRUE   # Scale to unit variance (SD = 1)
  )

# Get summary stats
pc %>% summary()

# Screeplot of eigenvalues
pc %>% plot(main = "Eigenvalues")

# Plot the projected data set on the first two principal 
# components using `biplot`
pc %>% ggbiplot()

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
