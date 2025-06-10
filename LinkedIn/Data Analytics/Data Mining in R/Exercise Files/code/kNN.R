# Title:  kNN: k-Nearest Neighbors
# File:   kNN.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  caret,         # Train/test functions
  e1071,         # Machine learning functions
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# Set random seed to reproduce the results
set.seed(1)

# LOAD AND PREPARE DATA ####################################

# Use the `spambase` datasets that were created previously 
# in "Spambase.R."

# Import training data `trn`
trn <- import("data/spambase_trn.rds")

# Import testing data `tst`
tst <- import("data/spambase_tst.rds")

# COMPUTE KNN MODEL ON TRAINING DATA #######################

# Define parameters for kNN
statctrl <- trainControl(
  method  = "repeatedcv",  # Repeated cross-validation
  number  = 5,             # Number of folds
  repeats = 3              # Number of sets of folds
)  

# Set up parameters to try while training (3-19)
k = rep(seq(3, 20, by = 2), 2)

# Apply model to training data (takes a moment)
fit <- train(
  y ~ ., 
  data = trn,                         # Use training data
  method = "knn",                     # kNN training method
  trControl = statctrl,               # Control parameters
  tuneGrid = data.frame(k),           # Search grid param.
  preProcess = c("center", "scale"),  # Preprocess
  na.action = "na.omit"
)

# Plot accuracy against various k values
fit %>% plot()                # Automatic range on Y axis
fit %>% plot(ylim = c(0, 1))  # Plot with 0-100% range

# Print the final model
fit %>% print()

# APPLY MODEL TO TEST DATA #################################

# Predict test set
pred <- predict(    # Create new variable ("predicted")
  fit,              # Apply saved model
  newdata = tst     # Use test data
)

# Get the confusion matrix
cm <- pred %>%
  confusionMatrix(reference = tst$y)

# Plot the confusion matrix
cm$table %>% 
  fourfoldplot(color = c("red", "lightblue"))

# Print the confusion matrix
cm %>% print()

# RESULTS ##################################################

# kNN Model
# Accuracy: .9097
# Reference: Not Spam: 816 / 42
# Reference: Spam: 84 / 438
# Sensitivity = 816 / (816 + 42) = .9510
# Specificity = 438 / (438 + 42) = .8391

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
