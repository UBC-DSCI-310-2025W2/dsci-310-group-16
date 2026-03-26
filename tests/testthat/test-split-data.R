# Load libraries
library(tidyverse)
library(tidymodels)
library(testthat)

source("../../R/split-data.R")


# Tests for simple expected use cases

test_that("split_data returns correct structure for default proportion", {
  
  temp_file <- tempfile(fileext = ".csv")
  
  df <- data.frame(x = 1:100)
  write_csv(df, temp_file)
  
  result <- split_data(temp_file)
  
  expect_type(result, "list")
  expect_true(all(c("train", "test") %in% names(result)))
  expect_equal(nrow(result$train) + nrow(result$test), 100)
  expect_true(nrow(result$train) > nrow(result$test))
})

test_that("split_data works with different proportion", {
  
  temp_file <- tempfile(fileext = ".csv")
  
  df <- data.frame(x = 1:75)
  write_csv(df, temp_file)
  
  result <- split_data(temp_file, prop = 0.6)
  
  expect_type(result, "list")
  expect_true(all(c("train", "test") %in% names(result)))
  expect_equal(nrow(result$train) + nrow(result$test), 75)
  expect_true(nrow(result$train) > nrow(result$test))
})

test_that("split_data is reproducible with set seed", {
  
  temp_file <- tempfile(fileext = ".csv")
  df <- data.frame(x = 1:100)
  write_csv(df, temp_file)
  
  result1 <- split_data(temp_file, prop = 0.85, seed = 123)
  result2 <- split_data(temp_file, prop = 0.85, seed = 123)
  
  expect_equal(result1$train, result2$train)
  expect_equal(result1$test, result2$test)
})

# Tests for edge cases

test_that("split_data works with small datasets greater than 1", {
  
  temp_file <- tempfile(fileext = ".csv")
  
  df <- data.frame(x = 1:2)
  write_csv(df, temp_file)
  
  result <- split_data(temp_file, prop = 0.5)
  
  expect_type(result, "list")
  expect_true(all(c("train", "test") %in% names(result)))
  expect_equal(nrow(result$train) + nrow(result$test), 2)
})

test_that("split_data works with proportion close to 1", {
  
  temp_file <- tempfile(fileext = ".csv")
  
  df <- data.frame(x = 1:60)
  write_csv(df, temp_file)
  
  result <- split_data(temp_file, prop = 0.99)
  
  expect_type(result, "list")
  expect_true(all(c("train", "test") %in% names(result)))
  expect_equal(nrow(result$train) + nrow(result$test), 60)
  expect_true(nrow(result$train) > nrow(result$test))
})

# Tests for error cases
test_that("split_data returns error with invalid file path", {
  
  expect_error(
    split_data("invalid_file.csv")
  )
})

test_that("split_data returns error with datasets less than 2", {
  
  temp_file <- tempfile(fileext = ".csv")
  
  df <- data.frame(x = 1)
  write_csv(df, temp_file)
  
  expect_error(
    split_data(temp_file)
  )
})

test_that("split_data returns error with invalid proportion (e.g., 0, 1, negative values, or greater than 1)", {
  
  temp_file <- tempfile(fileext = ".csv")
  
  df <- data.frame(x = 1:10)
  write_csv(df, temp_file)
  
  expect_error(
    split_data(temp_file, prop = 0)
  )
  
  expect_error(
    split_data(temp_file, prop = 1)
  )
  
  expect_error(
    split_data(temp_file, prop = -0.8)
  )
  
  expect_error(
    split_data(temp_file, prop = 1.5)
  )
})