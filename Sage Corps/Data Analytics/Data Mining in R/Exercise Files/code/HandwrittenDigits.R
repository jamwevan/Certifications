# Title:  Handwritten Digits Dataset
# File:   HandwrittenDigits.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  janitor,       # Remove constants
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  psych,         # Descriptive statistics
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# LOAD AND PREPARE DATA ####################################

# Many of the for this course come from the Machine Learning
# Repository at the University of California, Irvine (UCI),
# at https://archive.ics.uci.edu/

# For all three demonstrations of dimensionality reduction,
# we'll use the "Optical Recognition of Handwritten Digits
# Data Set," which can be accessed via https://j.mp/34NFNGn

# We'll use the dataset saved in "optdigits.tra," which is
# the training dataset. This data can be downloaded as a CSV
# file without the variable names, but you'll need to
# manually change the extension. However, to save the
# variable names, I imported it directly into R and then
# saved it as a CSV file from there.

# Import data from UCI ML (but you can skip this step)
# df <- read.csv(
#   url(
#     paste(
#       "https://archive.ics.uci.edu/ml/",
#       "machine-learning-databases/",
#       "optdigits/optdigits.tra",
#       sep = ""  # No space between joined text
#     )
#   )
# ) %>%
# as_tibble()  # Save as tibble, which prints better

# Our data is saved in the R project's data folder, with 
# the name "optdigits.csv"

# Import the data
df <-  import("data/optdigits.csv") %>%
  as_tibble()  # Save as tibble, which prints better

# Look at the first few rows of the tibble
df

# Rename the last column with digit labels to y, which is
# easier to specify and allows code to be reused.
df %<>%                     # Assignment pipe
  rename(y = X0.26) %>%     # New = old
  mutate(y = as_factor(y))  # Convert to factor

# Check the variable `y`; `forcats::fct_count` gives
# frequencies in factor order
df %>% 
  pull(y) %>%  # Return a vector instead of a dataframe
  fct_count()  # Count frequencies in factor order

# Simplify the data for these demonstrations by using
# only the digits {1,3,6}. The pipe "|" means "or."
df %<>% 
  filter(y == 1 | y == 3 | y == 6) %>%
  mutate(y = fct_drop(y))  # Drop unused levels

# Check `y` again
df %>% pull(y) %>% fct_count()

# Remove columns that are constant and thus not informative
df %<>% remove_constant()

# SPLIT DATA ##############################################

# Some demonstrations will use separate testing and training
# datasets for validation.

# Set random seed for reproducibility in processes like
# splitting the data
set.seed(1)  # You can use any number here

# Split data into training (trn) and testing (tst) sets
df %<>% mutate(ID = row_number())  # Add row ID
trn <- df %>% sample_frac(.70)     # 70% in trn
tst <- df %>%                      # Start with df
  anti_join(trn, by = "ID") %>%    # Rest in tst
  select(-ID)                      # Remove id from tst
trn %<>% select(-ID)               # Remove id from trn
df %<>% select(-ID)                # Remove id from df

# SAVE DATA ################################################

# Use saveRDS(), which save data to native R formats
df  %>% saveRDS("data/optdigits.rds")
trn %>% saveRDS("data/optdigits_trn.rds")
tst %>% saveRDS("data/optdigits_tst.rds")

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
