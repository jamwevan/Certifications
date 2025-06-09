# Title:  LDA: Linear Discriminant Analysis
# File:   LDA.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  car,           # scatterplotMatrix
  caret,         # Train/test functions
  e1071,         # Confusion matrix
  magrittr,      # Pipes
  MASS,          # LDA
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# LOAD AND PREPARE DATA ####################################

# Use the `optdigits` datasets that were created previously 
# in "HandwrittenDigits.R."

# Import training data `trn`
trn <- import("data/optdigits_trn.rds")

# Import testing data `tst`
tst <- import("data/optdigits_tst.rds")

# Set random seed for reproducibility in processes like
# splitting the data
set.seed(1)  # You can use any number here

# EXPLORE DATA #############################################

# Make a scatterplot matrix of a few variables, note where
# the points from classes overlap
scatterplotMatrix(
  ~X1 + X4 + X5 | y,  # Mark groups on y by color and shape
  data = tst,
  regLine = FALSE,    # No regression line
  smooth  = FALSE,    # No smoother
  col = 4:6           # Colors 4-6 from `carPalette`
)

# MODEL DATA: TRAINING PHASE ##############################

# Call `lda`, specifying `y` as outcome, save as `fit`
fit <- lda(
  y ~ .,        # `y` as a function of everything else
  data = trn,   # Use training dataset
  tol = 0.0001  # Tolerance for singularity of matrix
)

# View the entire model with group means and coefficients,
# which represent the dimension reduction in LDA
fit

# Predict for training data
trnpred <- fit %>%
  predict(trn)

# View the stacked histogram for first discriminant
ldahist(           # Use `ldahist` function from `MASS`
  trnpred$x[, 1],  # Get `x` from `trnpred`, use first col.
  g = trn$y        # Split by classes in `y` in train data
)

# View the stacked histogram for second discriminant
ldahist(
  trnpred$x[, 2],  # Get `x` from `trnpred`, use second col.
  g = trn$y
)

# Plot the train points for all classes, colored by `y` 
fit %>% plot(col = (4:6)[trn$y])

# TEST PHASE ###############################################

# Predict on test data using model generated in train phase
pred <- fit %>% predict(tst)

# Look at variables returned from predict
pred %>% names()

# View the stacked histogram for first discriminant
ldahist(
  pred$x[, 1],  # Get `x` from `pred`, use first column
  g = tst$y     # Split by classes in `y` in test data
)

# View the stacked histogram for second discriminant
ldahist(
  pred$x[, 2],  # Get `x` from `pred`, use second column
  g = tst$y
)

# Plot of projected data onto LD1 and LD2, colored according
# to the class labels
pred$x %>% plot(col = pred$class)

# Add labels to points 
pred$x %>%
  text(
    label = tst$y, 
    pos = 2         # Position 2 is to the left
  )

# Accuracy of model on test data
table(
  actualclass = tst$y,         # True outcome
  predictedclass = pred$class  # Predicted outcome
) %>%
confusionMatrix() %>%          # Accuracy statistics
print()

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
