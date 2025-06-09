# Title:  CBA: Classification Based on Association
# File:   CBA.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  arulesCBA,     # Classification Based on Association
  caret,         # Confusion matrix for predictions
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# LOAD AND PREPARE DATA ####################################

# Set random seed for reproducibility in processes like
# splitting the data. You can use any number.
set.seed(1)

# Import pre-processed penguin data
df <- import("data/penguins.rds") %>%
  print()

# Discretize data using the "Minimum Description Length
# Principle" (MDLP) algorithm and save to `df`; by naming
# the `Species` variable `y` (done earlier), it's easier to
# reuse code
df <- 
  discretizeDF.supervised(  # Function from `arulesCBA`
    y ~ .,                  # Species based on rest
    data = df,              # Data source
    method = "mdlp"         # Algorithm to use
  )

# Check the first few rows of data
df              

# Split data into training (trn) and testing (tst) sets
df %<>% mutate(ID = row_number())  # Add row ID
trn <- df %>% sample_frac(.70)     # 70% in trn
tst <- df %>%                      # Start with df
  anti_join(trn, by = "ID") %>%    # Rest in tst
  select(-ID)                      # Remove id from tst
trn %<>% select(-ID)               # Remove id from trn

# MODEL DATA ###############################################

# Create a CBA model using `CBA` from `arulesCBA`
fit <- CBA(   # `fit` is a generic name for models
  y ~ .,      # Species based on all other variables
  data = trn  # Use training data
)

# Basic info on the model in `fit`
fit       

# Check the rules
options(digits = 2)  # Reset R session when done
inspect(rules(fit))  # Need a (very) wide Console window

# Check accuracy of the model on the training data
confusionMatrix(      # Create a confusion matrix
  reference = trn$y,  # True values
  predict(            # Predicted values
    fit,              # Based on the training model
    newdata = trn     # Use the training data
  )
)

# TEST MODEL ###############################################

# Check accuracy of the model on the testing data
confusionMatrix(      # Create a confusion matrix
  reference = tst$y,  # True values
  predict(            # Predicted values
    fit,              # Based on the training model
    newdata = tst     # Use the testing data
  )
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
