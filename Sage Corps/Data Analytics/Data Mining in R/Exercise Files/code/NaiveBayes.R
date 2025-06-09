# Title:  Naive Bayes
# File:   NaiveBayes.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  caret,         # Train/test functions
  e1071,         # Machine learning functions
  magrittr,      # Pipes
  naivebayes,    # Naive Bayes functions
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

# MODEL DATA ###############################################

# Control parameters for training
ctrlparam <- trainControl(
  method  = "repeatedcv",   # Repeated cross-validation
  number  = 5,              # Number of folds
  repeats = 3               # Number of sets of folds
)  

# Tuning parameters: set up parameters on search grid
gridparam <- expand.grid(
  laplace = c(0, 0.005, 0.1, 0.5, 0.8, 1.0), 
  usekernel = c(FALSE, TRUE),
  adjust = c(0.1, 0.5))

# Train using training data and control parameters (takes a
# moment)
nb <- train(
  y ~ .,
  data = trn,              # Use training data
  method = "naive_bayes",  # Naive Bayes
  trControl = ctrlparam,   # Control parameters
  tuneGrid = gridparam,    # grid parameters
  na.action = "na.omit",   # Omit missing NA values
  )

# Plot parameter values against accuracy
nb %>% plot()

# Print the final model
nb %>% print()

# APPLY MODEL TO TEST DATA #################################

# Predict test set with best model
pred <- predict(  # Create new variable ("predicted")
  nb,             # Apply saved model
  newdata = tst   # Use test data
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

# Naive Bayes Model
# Accuracy: .7109
# Reference: Not Spam: 484 / 374
# Reference: Spam: 25 / 497
# Sensitivity = 484 / (484 + 374) = .5641
# Specificity = 497 / (497 + 25) = .9521

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
