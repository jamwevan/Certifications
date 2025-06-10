# Title:  "The Iliad" by Homer
# File:   TheIliad.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  gutenbergr,    # Import Project Gutenberg texts
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidytext,      # Text functions
  tidyverse      # So many reasons
)

# IMPORT DATA ##############################################

# Download "The Iliad" by Homer from Project Gutenberg. The
# `gutenberg_download` function can access books by ID,
# which you can get from the Gutenberg website,
# https://www.gutenberg.org. (The book's page is
# http://www.gutenberg.org/ebooks/6150)
df <- gutenberg_download(  # Save to `df`
  6150,                    # Book ID
  strip = TRUE             # Remove headers and footers
)

# Look at the first few rows
df

# Quick summary statistics
df %>% summary()

# This saves the downloaded file in a format R expects
df %>% export("data/Iliad.txt")

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
