# Load libraries
library(tidyverse)
library(tidymodels)
library(testthat)

source("../../R/evaluate_model.R")

# Create a simple fitted model for testing
set.seed(123)
sample_data <- tibble(
  childHeight = c(60, 62, 64, 66, 68, 70, 72, 74),
  midparentHeight = c(61, 63, 65, 67, 69, 71, 73, 75),
  gender = c("male", "female", "male", "female", "male", "female", "male", "female")
)

lm_spec <- linear_reg() %>%
  set_engine("lm") %>%
  set_mode("regression")

lm_recipe <- recipe(childHeight ~ midparentHeight + gender, data = sample_data)

lm_fit <- workflow() %>%
  add_recipe(lm_recipe) %>%
  add_model(lm_spec) %>%
  fit(data = sample_data)

# Tests for simple expected use cases

test_that("evaluate_model returns correct structure", {
  
  result <- evaluate_model(lm_fit, sample_data)
  
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 1)
  expect_true(all(c("rmse", "mae", "rsq") %in% names(result)))
})

test_that("evaluate_model returns numeric metric values", {
  
  result <- evaluate_model(lm_fit, sample_data)
  
  expect_true(is.numeric(result$rmse))
  expect_true(is.numeric(result$mae))
  expect_true(is.numeric(result$rsq))
})

test_that("evaluate_model works with custom truth column name", {
  
  renamed_data <- sample_data %>%
    rename(height = childHeight)
  
  custom_recipe <- recipe(height ~ midparentHeight + gender, data = renamed_data)
  
  custom_fit <- workflow() %>%
    add_recipe(custom_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = renamed_data)
  
  result <- evaluate_model(custom_fit, renamed_data, truth_col = "height")
  
  expect_s3_class(result, "tbl_df")
  expect_true(all(c("rmse", "mae", "rsq") %in% names(result)))
})

# Tests for edge cases

test_that("evaluate_model returns zero error for perfect predictions", {
  
  perfect_data <- tibble(
    childHeight = c(60, 62, 64, 66, 68),
    midparentHeight = c(60, 62, 64, 66, 68)
  )
  
  perfect_spec <- linear_reg() %>%
    set_engine("lm") %>%
    set_mode("regression")
  
  perfect_recipe <- recipe(childHeight ~ midparentHeight, data = perfect_data)
  
  perfect_fit <- workflow() %>%
    add_recipe(perfect_recipe) %>%
    add_model(perfect_spec) %>%
    fit(data = perfect_data)
  
  result <- evaluate_model(perfect_fit, perfect_data)
  
  expect_equal(result$rmse, 0, tolerance = 1e-10)
  expect_equal(result$mae, 0, tolerance = 1e-10)
  expect_equal(result$rsq, 1, tolerance = 1e-10)
})

# Tests for error cases

test_that("evaluate_model returns error when test_data is not a data frame", {
  
  expect_error(
    evaluate_model(lm_fit, c(1, 2, 3))
  )
})

test_that("evaluate_model returns error when truth_col is not a single string", {
  
  expect_error(
    evaluate_model(lm_fit, sample_data, truth_col = c("childHeight", "other"))
  )
  
  expect_error(
    evaluate_model(lm_fit, sample_data, truth_col = NA)
  )
  
  expect_error(
    evaluate_model(lm_fit, sample_data, truth_col = 123)
  )
})

test_that("evaluate_model returns error when truth column is missing", {
  
  bad_data <- sample_data %>%
    select(-childHeight)
  
  expect_error(
    evaluate_model(lm_fit, bad_data)
  )
})