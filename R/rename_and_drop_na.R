# Load libraries
library(tidyverse)

#' Rename columns and drop rows with missing values
#'
#' @param df A data frame.
#' @param col_map Named character vector where names are the desired new
#'   column names and values are the existing column names in `df`.
#'   Defaults to the Galton dataset column mapping.
#'
#' @return A data frame with renamed columns and no rows containing
#'   missing values.
#'
#' @export
#' @examples
#' df <- data.frame(father = c(68, 70, NA), mother = c(64, 65, 63),
#'                  midparentHeight = c(66, 67.5, 65), childHeight = c(65, 67, 64))
#' rename_and_drop_na(df)

rename_and_drop_na <- function(df, col_map = c(
                                    father_height    = "father",
                                    mother_height    = "mother",
                                    midparent_height = "midparentHeight",
                                    child_height     = "childHeight"
                                  )) {
  # Error if df is not a data frame
  if (!is.data.frame(df)) {
    stop("`df` must be a data frame.")
  }

  # Error if col_map is not a named character vector
  if (!is.character(col_map) || is.null(names(col_map)) || any(names(col_map) == "")) {
    stop("`col_map` must be a named character vector with no empty names.")
  }

  # Error if any source columns are missing from df
  missing_cols <- setdiff(col_map, colnames(df))
  if (length(missing_cols) > 0) {
    stop("The following columns are not present in `df`: ",
         paste(missing_cols, collapse = ", "))
  }

  # Rename columns then drop rows with missing values
  cleaned <- df %>%
    dplyr::rename(!!!rlang::set_names(col_map, names(col_map))) %>%
    tidyr::drop_na()

  return(cleaned)
}