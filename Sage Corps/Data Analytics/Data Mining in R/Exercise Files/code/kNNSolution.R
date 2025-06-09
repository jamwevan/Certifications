# Title:  Solution: kNN
# File:   kNNSolution.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  caret,         # Train/test functions
  e1071,         # Machine learning functions
  GGally,        # Plotting
  magrittr,      # Pipes
  mlbench,       # BreastCancer dataset
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# Set random seed to reproduce the results
set.seed(1)

# LOAD AND PREPARE DATA ####################################

# Use the `BreastCancer` dataset from the `mlbench` package

# Get info on dataset
?BreastCancer

# Load data
data(BreastCancer)

# Summarize raw data
summary(BreastCancer)

# Prepare data
df <- BreastCancer %>%   # Save to `df`
  select(-Id) %>%        # Remove `Id` 
  rename(y = Class) %>%  # Rename `Class` to `y`
  mutate(                # Modify several variables
    across(              # Select several variables
      -y,                # Select all except `y`
      as.numeric         # Convert selected vars to numeric
    )
  ) %>%
  na.omit() %>%          # Omit cases with missing data
  as_tibble() %>%        # Save as tibble
  print()                # Show data in Console

# Split data into training (trn) and testing (tst) sets
df %<>% mutate(ID = row_number())  # Add row ID
trn <- df %>%                      # Create trn
  slice_sample(prop = .70)         # 70% in trn
tst <- df %>%                      # Create tst
  anti_join(trn, by = "ID") %>%    # Remaining data in tst
  select(-ID)                      # Remove id from tst
trn %<>% select(-ID)               # Remove id from trn
df %<>% select(-ID)                # Remove id from df

# EXPLORE TRAINING DATA ####################################

# Bar chart of `y`
trn %>%
  ggplot() + 
  geom_bar(aes(x = y, fill = y)) 

# Randomly select a few variables and look at their plots
# in particular look at the first column and first row
trn %>% 
  select(y, 1:3)  %>%
  ggpairs(
    aes(color = trn$y),  # Color by class
    lower = list(
      combo = wrap(
        "facethist", 
        binwidth = 0.5
      )
    )
  )

# COMPUTE KNN MODEL ON TRAINING DATA #######################

# Define parameters
statctrl <- trainControl(
  method  = "repeatedcv",  # Repeated cross-validation
  number  = 5,             # Number of folds
  repeats = 3              # Number of sets of folds
)  

# Set up parameters to try while training
k = rep(seq(3, 20, by = 2), 2)

# Apply model to training data (takes a moment)
fit <- train(
  y ~ ., 
  data = trn,                        # Use training data
  method = "knn",                    # kNN training method
  trControl = statctrl,              # Control parameters
  tuneGrid = data.frame(k),          # Search grid param
  preProcess = c("center","scale"),  # Preprocess
  na.action = "na.omit"
)

# Plot accuracy against various k values
fit %>% plot()                # Automatic range on y
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

# View the confusion matrix
cm$table %>% 
  fourfoldplot(color = c("red", "lightblue"))

# Print the confusion matrix
cm %>% print()

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
