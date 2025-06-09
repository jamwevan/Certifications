# Title:  DBSCAN: Density-Based Spatial Clustering of  
#         Applications with Noise
# File:   DBSCAN.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(    # Use p_load function from pacman
  car,             # scatterplotMatrix  
  dbscan,          # Fast DBSCAN implementation  
  factoextra,      # Visualize factors and clusters
  magrittr,        # Pipes
  pacman,          # Load/unload packages
  rio,             # Import/export data
  tidyverse        # So many reasons
)

# Set the seed to reproduce results
set.seed(1)

# LOAD AND PREPARE DATA ####################################

# Save the `penguins` dataset to `df`
df <- import("data/penguins.RDS")

# Take a look at the data
df

# Summarize the data
df %>% summary()

# Separate the class labels
species <- df %>%  # Rename `y` back to `species`
  pull(y)          # Select just `y` as a vector

df %<>% 
  select(-y) %>%   # Select everything except `y`
  scale()          # Standardize variables

# DBSCAN CLUSTERING ########################################

# Choose a value for "minPts" or "k," which is the minimum
# number of neighboring points for clustering. minPts should
# be odd and have a value of at least 3, with higher values
# for larger datasets. We'll use 5 in this example.

# Using the chosen value of minPts (k = 5 in our case), find
# the optimal value of "eps" (epsilon neighborhood radius)
# by graphing distances and looking for a pronounced "knee"
# or bend.
df %>% 
  scale() %>%       
  kNNdistplot(k =  5)

# Draw a horizontal line at the optimal value
abline(h = 0.8, lty = 2, col = "red")

# Run DBSCAN with the parameter values for minPts (k = 5)
# and eps (0.8)
db <- df %>% 
  dbscan(
    eps = 0.8, 
    minPts = 5
  ) 

# Print the DBSCAN object
db %>% print()

# Visualize the clusters according to species
db %>%
  fviz_cluster(
    df, 
    geom = "point"
  )  +
  geom_text(
    vjust=1.5, #add label below
    aes(               #label points excluding noise
      color = as.factor(db$cluster[db$cluster!=0]),
      label = species[db$cluster!=0]
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
