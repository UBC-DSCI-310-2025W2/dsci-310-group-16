library(docopt)
library(readr)

doc <- "
Usage:
  01_download_data.R --url=<url> --output=<output_path>
 
Options:
  --url=<url>            URL of the raw CSV data to download.
  --output=<output_path> Path (including filename) where the raw data will be saved.
"

opt <- docopt(doc)

main <- function(url, output) {
  # Download the raw data from the specified URL
  raw_data <- read_csv(url)
  
  # Save the raw data to the specified output file
  write_csv(raw_data, output)
}

main(opt$url, opt$output)