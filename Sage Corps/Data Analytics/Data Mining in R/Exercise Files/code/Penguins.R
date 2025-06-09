# Title:  Penguins Dataset
# File:   Penguins.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(    # Use p_load function from pacman
  magrittr,        # Pipes
  pacman,          # Load/unload packages
  palmerpenguins,  # Data on penguins
  rio,             # Import/export data
  tidyverse        # So many reasons
)

# LOAD AND PREPARE DATA ####################################

# For all three demonstrations of clustering, we'll use the
# `penguins` dataset, which is available in the R package
# `palmerpenguins` and is also described at
# https://bit.ly/2N9pIB9

p_data(palmerpenguins)            # Info on two datasets
?palmerpenguins::penguins         # Get help with links
palmerpenguins::penguins          # See first dataset
palmerpenguins::penguins_raw      # See second dataset

(df <- palmerpenguins::penguins)  # Save/show data to df

df %>% summary()

# Select and rename variables
df %<>%
  as_tibble()%>%      
  rename(y = species) %>%  # Rename species to y
  select(                  # Use `select` to remove vars
    -island,               # Remove island
    -sex,                  # Remove sex
    -year) %>%             # Remove year
  na.omit()                # Remove incomplete cases

# Look at the first few rows of the prepared data frame
df

# SAVE DATA ################################################

# Use saveRDS(), which saves data to native R formats
df %>% saveRDS("data/penguins.rds")

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
