library(HistData)
library(tidyverse)

# load dataset
data("GaltonFamilies")

# convert to dataframe
galton_raw <- as_tibble(GaltonFamilies)

# save raw dataset
write_csv(
  galton_raw,
  "data/raw/galton_families.csv")
