# Load required library
library(dplyr)
library(magrittr)
# Function to randomize sentences in a markdown file

randomize_sentences <- function(file_path) {
  # Read the entire markdown file as text
  text <- readLines(file_path, warn = FALSE)

  # Collapse into one string (so line breaks don't interfere)
  text <- paste(text, collapse = " ")

  text <- gsub("%%.*?%%", "", text)
  # Split into sentences using regex (., ?, ! followed by space)
  sentences <- unlist(strsplit(text, "(?<=[.!?])\\s+", perl = TRUE))

  # Create dataframe: one row per sentence
  df <- data.frame(sentence = sentences, stringsAsFactors = FALSE)

  # Filter out sentences that are comments (wrapped in %% ... %%)
  # df <- df %>% filter(!grepl("^%%.*%%$", sentence))

  # Randomize row order
  df %>% slice_sample(n = nrow(df))
}
# increase the maximum number of items printed
options(max.print = 999999)
getOption("max.print")

randomize_sentences(file_path = "writingclub/2025-11-13.md") |>
  pull(sentence) |>
  paste(collapse = " ") |>
  print.default(max = 1000)
