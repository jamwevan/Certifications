# Title:  PCA: Principal Component Analysis
# File:   PCA.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  BiocManager,   # Necessary for ggbiplot
  # ggbiplot,      # Create biplots
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# Install one package from GitHub; You can respond "n" if it
# asks "Do you want to install from sources the package
# which needs compilation?" The first command installs the 
# package and the second loads it in R.
p_install_gh("vqv/ggbiplot")  # Creates biplots
p_load(ggbiplot)

n# LOAD AND PREPARE DATA ####################################

# Use the `optdigits` datasets that were created previously 
# in "HandwrittenDigits.R."

# Import training data `trn`
trn <- import("data/optdigits_trn.rds")

# Import testing data `tst`
tst <- import("data/optdigits_tst.rds")

# PRINCIPAL COMPONENT ANALYSIS #############################

# Four methods in R (uncomment to get info)
# ?prcomp     # Most common method
# ?princomp   # Slightly different method
# ?principal  # Method from psych package
# ?PCA        # Method from FactoMineR

# Principal components model using default method
pc <- trn %>% 
  select(-y) %>%    # Exclude variable with class labels
  prcomp(           # Most common method
    center = TRUE,  # Centers means to 0
    scale  = TRUE   # Scale to unit variance (SD = 1)
  )

# Get summary stats
pc %>% summary()

# Screeplot of eigenvalues
pc %>% plot(main = "Eigenvalues")

# Plot the projected data set on the first two principal 
# components using `ggbiplot`
pc %>% 
  ggbiplot(
    color  = trn$y,         # Color by group
    groups = factor(trn$y)  # Variable with groups
  )

# TEST MODEL ###############################################

# Predict with `prcomp`

# Project the test data onto the principal directions found
# with prcomp
newdata <- pc %>%  # Take PC model from training data
  predict(         # Use predict function to apply model
    tst %>%        # Apply model to the testing data
    select(-y)     # But remove the class label variable
  )

# Modify the PCA object with projected data
testpc <- pc         # Duplicate the PC model to `testpc`
testpc$x <- newdata  # And change x to the predicted values

# Look at training and test data projections together; this
# command uses base R commands because pc objects work
# differently from tibbles
plot(               # Generic X-Y plot for training data
  pc$x[, c(1, 2)],  # From PC, select x, then col. 1 & 2
  col = "gray"      # Draw gray circles
) 

points(                # Add points from testing data
  newdata[, c(1, 2)],  # Select columns 1 & 2 from `newdata`
  col = "red"          # Draw red circles
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
