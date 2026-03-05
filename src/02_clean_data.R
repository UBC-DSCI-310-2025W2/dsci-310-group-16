library(tidyverse)

# read raw data
galton <- read_csv("data/raw/galton_families.csv")

# select useful variables
galton_clean <- galton %>%
  select(
    family,
    father,
    mother,
    midparentHeight,
    gender,
    childHeight)

# rename variables
galton_clean <- galton_clean %>%
  rename(
    father_height = father,
    mother_height = mother,
    midparent_height = midparentHeight,
    child_height = childHeight)

# remove missing values
galton_clean <- galton_clean %>%
  drop_na()

# save cleaned dataset
write_csv(
  galton_clean,
  "data/processed/galton_clean.csv")