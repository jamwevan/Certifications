# Title:  Association Analysis with FP-Growth
# File:   FPGrowth.R
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

# SET RANDOM SEED ##########################################

# Set random seed for reproducibility in processes like
# sampling and splitting the data
set.seed(1)  # You can use any number here

# LOAD AND PREPARE DATA ####################################

# For our examples in this course, we'll use datasets from
# the Machine Learning Repository at the University of
# California, Irvine (UCI). Here is a link to the
# repository's main page:
browseURL("http://archive.ics.uci.edu/ml/index.php")

# Take random subsample to save time
df %<>% sample_n(500)

# SPLIT DATA ###############################################

# Split data into training (trn) and testing (tst) sets
trn <- df %>% sample_frac(.70)  # 70% in training data
tst <- df %>% anti_join(trn)    # Rest in testing data

# EXPLORE DATA #############################################



# MODEL DATA ###############################################



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
