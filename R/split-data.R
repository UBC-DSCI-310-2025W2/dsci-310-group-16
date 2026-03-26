# Load libraries
library(tidyverse)
library(tidymodels)

#' Read the input file and split dataset into training and testing sets
#'
#' @param file_path A string path to the input CSV file
#' @param prop Proportion of data for training (default = 0.8)
#' @param seed Optional integer for reproducibility
#'
#' @return A list with two items. 
#'  The first item (named train) contains the training dataset.
#'  The second item (named test) contains the testing dataset. 
#'
#' @export
#' @examples
#' split_data("data.csv", prop = 0.7, seed = 999)

split_data <- function(file_path, prop = 0.8, seed = NULL) {
  # Error for invalid proportions
  if (prop <= 0 || prop >= 1) {
    stop("prop must be between 0 and 1")
  }
  
  # Error if file does not exist
  if (!file.exists(file_path)) {
    stop("file does not exist")
  }
  
  # Sets the seed if the user provides it
  if (!is.null(seed)) {
    set.seed(seed)
  }
  
  # Read data
  data <- read_csv(file_path, show_col_types = FALSE)
  
  # Error if the dataset is too small
  if (nrow(data) < 2) {
    stop("Data must have at least 2 rows to split into train and test")
  }
  
  # Split
  split <- initial_split(data, prop = prop)
  
  train <- training(split)
  test <- testing(split)
  
  # Return as list
  return(list(train = train, test = test))
}