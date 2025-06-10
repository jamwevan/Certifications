# Title:  Decision Trees
# File:   DecisionTrees.R
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
  rattle,        # Pretty plot for decision trees
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

# MODEL TRAINING DATA ######################################

# set training control parameters
ctrlparam <- trainControl(
  method  = "repeatedcv",   # method
  number  = 5,              # 5 fold
  repeats = 3               # 3 repeats
)

# Train decision tree on training data (takes a moment).
# First method tunes the complexity parameter.
dt1 <- train(
  y ~ .,                  # Use all vars to predict spam
  data = trn,             # Use training data
  method = "rpart",       # Tune the complexity parameter
  trControl = ctrlparam,  # Control parameters
  tuneLength = 10         # Try ten parameters
)

# Show processing summary
dt1

# Plot accuracy by complexity parameter values
dt1 %>% plot()
dt1 %>% plot(ylim = c(0, 1))  # Plot with 0-100% range

# Second method tunes the maximum tree depth
dt2 <- train(
  y ~ .,                  # Use all vars to predict spam
  data = trn,             # Use training data
  method = "rpart2",      # Tune the maximum tree depth
  trControl = ctrlparam,  # Control parameters
  tuneLength = 10         # Try ten parameters
)

# Show processing summary
dt2

# Plot the accuracy for different parameter values
dt2 %>% plot()
dt2 %>% plot(ylim = c(0, 1))  # Plot with 0-100% range

# Select the final model depending upon final accuracy
finaldt <- if (max(dt1$results$Accuracy) > 
  max(dt2$results$Accuracy)) {
  dt1
  } else {
  dt2
  }

# Description of final training model
finaldt$finalModel

# Plot the final decision tree model
finaldt$finalModel %>%
  fancyRpartPlot(
    main = "Predicting Spam",
    sub  = "Training Data"
  )

# VALIDATE ON TEST DATA ####################################

# Predict on test set
pred <- finaldt %>%
  predict(newdata = tst)

# Accuracy of model on test data
cmtest <- pred %>%
  confusionMatrix(reference = tst$y)

# Plot the confusion matrix
cmtest$table %>% 
  fourfoldplot(color = c("red", "lightblue"))

# Print the confusion matrix
cmtest %>% print()

# RESULTS ##################################################

# Decision Tree Model
# Accuracy: .9029
# Reference: Not Spam: 796 / 62
# Reference: Spam: 72 / 450
# Sensitivity = 796 / (796 + 62) = .9277
# Specificity = 450 / (450 + 72) = .8621

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
