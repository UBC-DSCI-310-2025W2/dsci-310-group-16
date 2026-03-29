# Load libraries
library(tidyverse)
library(tidymodels)

#' Evaluate a fitted model on test data
#'
#' @param fit A fitted model or workflow object that supports `predict()`.
#' @param test_data A data frame containing the test dataset, including the
#' response column.
#' @param truth_col A string giving the name of the true response column.
#' Defaults to `"childHeight"`.
#'
#' @return A tibble with one row and three columns: `rmse`, `mae`, and `rsq`.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' metrics <- evaluate_model(fit, test_data)
#' }
evaluate_model <- function(fit, test_data, truth_col = "childHeight") {

  # Error if test_data is not a data frame
  if (!is.data.frame(test_data)) {
    stop("'test_data' must be a data frame.")
  }

  # Error if truth_col is not a single string
  if (!is.character(truth_col) || length(truth_col) != 1 || is.na(truth_col)) {
    stop("'truth_col' must be a single character string.")
  }

  # Error if truth column is missing from test_data
  if (!(truth_col %in% colnames(test_data))) {
    stop(paste0("Column '", truth_col, "' is not present in 'test_data'."))
  }

  # Generate predictions and combine with test data
  preds <- predict(fit, test_data) %>%
    bind_cols(test_data)

  # Error if prediction column was not created
  if (!(".pred" %in% colnames(preds))) {
    stop("Prediction output must contain a '.pred' column.")
  }

  # Compute evaluation metrics
  metrics <- yardstick::metrics(
  preds,
  truth = !!rlang::sym(truth_col),
  estimate = .pred
)

return(metrics)
}