# Title:  Sentiment Analysis: Binary Classification
# File:   BinaryClassification.R
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

# Import local file and save as tibble
df <- import("data/Iliad.txt") %>% as_tibble()

# Look at the first few rows
df

# PREPARE DATA #############################################

# Tokenize the data
df %<>%              # Overwrite data
  select(text) %>%   # Keep text only
  unnest_tokens(     # Separate the text
    word,            # Split text into words
    text             # Save in text format
  )

# See the tokens/words by frequency
df %>% count(word, sort = TRUE) 

# Remove "stop words" like "the," "to," "a," and so on.
df %<>% anti_join(stop_words)

# See the revised tokens/words by frequency
df %>% count(word, sort = TRUE) 

# CATEGORIZE SENTIMENTS ####################################

# Find positive and negative words with the "bing" lexicon
df %>%
  inner_join(                # Match words with sentiments
    get_sentiments("bing")   # Use "bing" sentiment library
  ) 

# Sort sentiment words by frequency
df %>%
  inner_join(                # Match words with sentiments
    get_sentiments("bing")   # Use "bing" sentiment library
  ) %>% 
  count(word, sort = TRUE) 

# Summarize the number (and proportion) of sentiments
df %>%
  inner_join(                # Match words with sentiments
    get_sentiments("bing")   # Use "bing" sentiment library
  ) %>% 
  group_by(sentiment) %>%    # Group sentiments
  summarize(n = n()) %>%     # Count number of words
  mutate(prop = n / sum(n))  # Get proportions of total

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
