# Title:  Challenge: Association Analysis with Apriori
# File:   AprioriChallenge.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  arules,        # Association rules mining
  arulesViz,     # Visualize association rules
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# SET RANDOM SEED ##########################################

# Set random seed for reproducibility in processes like
# sampling and splitting the data
set.seed(1)  # You can use any number here

# LOAD DATA ################################################

## Read transactional data from arules package
?Epub
data("Epub")   # Load data
str(Epub)      # Structure of data
summary(Epub)  # Includes 5 most frequent items

# Save data to `df`
df <- Epub

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

