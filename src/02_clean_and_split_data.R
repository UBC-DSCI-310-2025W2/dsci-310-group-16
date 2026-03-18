library(docopt)
library(readr)
library(dplyr)

doc <- "
Usage:
  02_clean_data.R --input=<input_path> --output=<output_path>
 
Options:
  --input=<input_path>   Path to the raw CSV data (output of 01_download_data.R).
  --output=<output_path> Path (including filename) where cleaned data will be saved.
"
opt <- docopt(doc)

main <- function(input, output) {
  # Read the raw data from the specified input file
  raw_data <- read_csv(input)
  
  # Clean the data (example: remove rows with missing values)
  cleaned_data <- raw_data %>%
  rename(
    father_height    = father,
    mother_height    = mother,
    midparent_height = midparentHeight,
    child_height     = childHeight
  ) %>%
  drop_na()
  
  # Save the cleaned data to the specified output file
  write_csv(cleaned_data, output)
}

main(opt$input, opt$output)