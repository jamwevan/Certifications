# Title:  
# File:   
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

# LOAD AND PREPARE DATA ####################################

# Save data to "df" (for "data frame")
# Rename outcome as "y" (if it helps)
# Specify outcome with df$y

# Data is saved in Project "data" folder

df <- import("data/StateData.xlsx") %>%
  as_tibble() %>%
  select(
    state_code, 
    psychRegions,
    instagram:modernDance
  ) %>% 
  mutate(
    psychRegions = as.factor(psychRegions)
  ) %>%
  rename(
    y = psychRegions
  ) %>%
  print()

# Set random seed
set.seed(1)

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
