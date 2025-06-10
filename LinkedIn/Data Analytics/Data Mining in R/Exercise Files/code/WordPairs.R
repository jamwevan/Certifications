# Title:  Visualizing Word Pairs
# File:   WordPairs.R
# Course: Data Mining with R

# INSTALL AND LOAD PACKAGES ################################

# Install pacman if you don't have it (uncomment next line)
# install.packages("pacman")

# Install and/or load packages with pacman
pacman::p_load(  # Use p_load function from pacman
  ggraph,        # Visualize network graphs
  gutenbergr,    # Import Project Gutenberg texts
  igraph,        # Network graph functions
  magrittr,      # Pipes
  pacman,        # Load/unload packages
  rio,           # Import/export data
  tidytext,      # Text functions
  tidyverse      # So many reasons
)

# Set random seed for reproducibility in processes like
# splitting the data
set.seed(1)  # You can use any number here

# IMPORT DATA ##############################################

# Download "The Iliad" by Homer from Project Gutenberg. The
# `gutenberg_download` function can access books by ID,
# which you can get from the Gutenberg website,
# https://www.gutenberg.org. (The book's page is
# http://www.gutenberg.org/ebooks/6150.)

# Import local file
df <- import("data/Iliad.txt") %>% as_tibble()

# Look at the first few rows
df

# PREPARE DATA #############################################

#Tokenize the data
df %<>%                # Overwrite data
  unnest_tokens(       # Separate the text
    wordpairs,         # Save data in variable `wordpairs`
    text,              # Save in text format
    token = "ngrams",  # Split into multiple-word "ngrams"
    n = 2              # Two words at a time
  )

# See the tokens/words by frequency
df %>% count(wordpairs, sort = TRUE) 

# Split word pairs into two variables, which is necessary
# for network graphs.
df %<>%
  separate(
    wordpairs, 
    c("word1", "word2"), 
    sep = " "
  ) %>%
  select(-gutenberg_id) %>%  # Remove book ID number
  print()

# Remove word pairs that have stop words. Because there are
# now two words, it doesn't work to use the `anti_join`
# function used previously. Instead, the cases are filtered
# out if either word contains a stop word. This reduces the
# total number of observations from 146,318 to 28,019, an
# 81% reduction.
df %<>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word) %>%
  print()

# Save sorted counts
df %<>% 
  count(
    word1, 
    word2, 
    sort = TRUE
  ) %>%
  print()

# Pair frequencies
df %>%
  group_by(n) %>%
  summarize(f = n()) %>%  # Count number of words
  mutate(p = n / sum(n))  # Get proportions of total

# VISUALIZE DATA ###########################################

# See graph data
df %>%
  filter(n > 12) %>%           # Use observations w/n > 12
  graph_from_data_frame()      # Print the data in Console

# Visualize graph data (takes a moment)
df %>%
  filter(n > 12) %>%           # Use observations w/n > 12
  graph_from_data_frame() %>%  # Draw graph from `df`
  ggraph(layout = "fr") +      # Select "fr" layout
  geom_edge_link() +           # Graph the links 
  geom_node_point() +          # Graph the nodes
  geom_node_text(              # Add labels to nodes
    aes(label = name),         # Label each node by name
    nudge_x = .5,              # Move label slightly right
    nudge_y = .5               # Move label slightly up
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
