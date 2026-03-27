# Load libraries
library(tidyverse)
library(testthat)

source("../../R/rename-and-drop-na.R")

# Tests for simple expected use cases

test_that("rename_and_drop_na() renames columns and removes NA rows correctly", {

  df <- data.frame(
    father          = c(68, 70, NA, 67),
    mother          = c(64, 65, 63, NA),
    midparentHeight = c(66, 67.5, 65, 66),
    childHeight     = c(65, 67, 64, 66)
  )

  expected <- data.frame(
    father_height    = c(68, 70),
    mother_height    = c(64, 65),
    midparent_height = c(66, 67.5),
    child_height     = c(65, 67)
  )

  result <- rename_and_drop_na(df)

  expect_s3_class(result, "data.frame")
  expect_named(result, c("father_height", "mother_height",
                         "midparent_height", "child_height"))
  expect_equal(result, expected, ignore_attr = TRUE)
  expect_false(anyNA(result))
})

test_that("rename_and_drop_na() works with a custom col_map", {

  df <- data.frame(a = c(1, NA, 3), b = c(4, 5, 6))

  expected <- data.frame(col_a = c(1, 3), col_b = c(4, 6))

  result <- rename_and_drop_na(df, col_map = c(col_a = "a", col_b = "b"))

  expect_s3_class(result, "data.frame")
  expect_named(result, c("col_a", "col_b"))
  expect_equal(result, expected, ignore_attr = TRUE)
})


# Tests for edge cases

test_that("rename_and_drop_na() returns all rows when there are no NAs", {

  df <- data.frame(
    father          = c(68, 70),
    mother          = c(64, 65),
    midparentHeight = c(66, 67.5),
    childHeight     = c(65, 67)
  )

  result <- rename_and_drop_na(df)

  expect_equal(nrow(result), 2)
  expect_false(anyNA(result))
})

test_that("rename_and_drop_na() returns zero rows when all values are NA", {

  df <- data.frame(
    father          = c(NA, NA),
    mother          = c(NA, NA),
    midparentHeight = c(NA, NA),
    childHeight     = c(NA, NA)
  )

  result <- rename_and_drop_na(df)

  expect_equal(nrow(result), 0)
})


# Tests for error cases

test_that("rename_and_drop_na() returns error when df is not a data frame", {

  expect_error(
    rename_and_drop_na(list(father = 1))
  )
})

test_that("rename_and_drop_na() returns error when col_map is unnamed", {

  df <- data.frame(
    father          = c(68, 70),
    mother          = c(64, 65),
    midparentHeight = c(66, 67.5),
    childHeight     = c(65, 67)
  )

  expect_error(
    rename_and_drop_na(df, col_map = c("father", "mother"))
  )
})

test_that("rename_and_drop_na() returns error when source column does not exist in df", {

  df <- data.frame(
    father          = c(68, 70),
    mother          = c(64, 65),
    midparentHeight = c(66, 67.5),
    childHeight     = c(65, 67)
  )

  expect_error(
    rename_and_drop_na(df, col_map = c(new_col = "nonexistent"))
  )
})