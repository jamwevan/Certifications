# Title:  Challenge: k-Means
# File:   kMeansChallenge.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  car,           # For scatterplotMatrix
  cluster,       # Cluster analysis
  datasets,      # R's built-in sample datasets
  factoextra,    # Evaluate clusters
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidyverse      # So many reasons
)

# LOAD AND PREPARE DATA ####################################

# Use the `iris` dataset from R's `datasets` package

?iris

# Set random seed for reproducibility in processes like
# splitting the data
set.seed(1)  # You can use any number here

# Import data into `df`
df <- iris %>% tibble()

# Check data
df

# Separate the class labels
Species <- df %>% 
  pull(Species)

df %<>%                  # Overwrite `df`
  select(-Species) %>%   # Select everything except `y`
  scale()                # Standardize variables

# EXPLORE DATA #############################################

# Make a scatter plot of some exploratory variables and
# color according to species (y)
scatterplotMatrix(
  ~ Sepal.Length +
    Sepal.Width +
    Petal.Length +
    Petal.Width | 
    Species,
  data = df
)

# K-MEANS CLUSTERING #######################################

# Compute three clusters
km <- df %>% 
  kmeans(3) %>%  # Set the number of clusters
  print()        # Print output

# Visualize the clusters
km %>% fviz_cluster(
  data = df,
  geom = c("point")
  ) +
  geom_text(
    vjust = 1.5,  # Color points according to cluster
    aes(
      color = as.factor(km$cluster),
      label = Species # label according to species
    )
  )

# CLEAN UP #################################################

# Clear data
rm(list = ls())  # Removes all objects from the environment

# Clear packages
detach("package:datasets", unload = T)  # For base packages
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
