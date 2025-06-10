# Title:  Association Analysis with Apriori
# File:   Apriori.R
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
data("Groceries")   # Load data

# Save data to `df`
df <- Groceries

# RULES ####################################################

rules <- df %>%
  apriori(
    parameter = list(
      supp = 0.001,    # Minimum level of support
      conf = 0.75      # Minimum level of confidence
    )
  )

# Get number of rules
rules

# See the rules with most support (this works best if the
# Console window is wide)
options(digits = 2)   # Reset R session when done
inspect(rules[1:20])  # See the first 20 rules

# PLOTS ####################################################

# Scatterplot of support x confidence (colored by lift)
plot(rules)

# Graph of top 20 rules
plot(
  rules[1:20], 
  method = "graph", 
  control = list(type = "items")
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
