library(docopt)
library(readr)
library(dplyr)
library(tidyr)

source("R/rename-and-drop-na.R")

doc <- "
Usage:
  02_clean_data.R --input=<input_path> --output=<output_path>
 
Options:
  --input=<input_path>   Path to the raw CSV data (output of 01_download_data.R).
  --output=<output_path> Path (including filename) where cleaned data will be saved.
"
opt <- docopt(doc)

main <- function(input, output) {
  raw_data <- read_csv(input)
  
  cleaned_data <- rename_and_drop_na(raw_data)
  
  write_csv(cleaned_data, output)
}

main(opt$input, opt$output)