library(testthat)

source("../../R/plot_regression_scatterplot.R")

# Expected Cases
# - two numerical columns specified for x and y (no negative values)
# - two numerical columns specified for x and y (with negative values)
# - two numerical columns for x and y and a numerical column for color
# - two numerical columns for x and y and a categorical column for color
# - data has missing values (for x-axis, y-axis, and color)
# 
# 
# Edge Cases
# - no variance in the data (ex. same value in entire column)
# - variable used for color grouping only has one category 
# - extreme outliers in either X or Y
# - only 2 rows of data
# 
# 
# Error Cases
# - dataframe has mixed data types 
# - empty dataframe
# - one row of data (ie. 1 data point)
# - x and y are not numerical values 
# - specified column names don't exist 





# ---------Expected cases-------------------------------------

test_that("plot_regression_scatterplot will run without error for two numeric columns with no missing values", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns, 
                                       x_var = "x", 
                                       y_var = "y")
  
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))

  
})

test_that("plot_regression_scatterplot will run without error for two numeric columns of negative values with no missing data", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns, 
                                       x_var = "neg_x", 
                                       y_var = "neg_y")
  
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
  
})

test_that("plot_regression_scatterplot will run without error for two numeric columns with no missing values and numeric column specified for color", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns_color, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  # pull the first layer to make sure axis are actually numeric 
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer

  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
  
  
})

test_that("plot_regression_scatterplot will run without error for two numeric columns with no missing values and categorical column specified for color", {
  
  chart <- plot_regression_scatterplot(mixed_col_types_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
})



test_that("plot_regression_scatterplot will run without error for data with missing values", {
  
  chart <- plot_regression_scatterplot(missing_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
  
})


# ---------Edge cases-------------------------------------

test_that("plot_regression_scatterplot will run without error for data with no variance", {
  
  chart <- plot_regression_scatterplot(no_variance_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  # pull the first layer to make sure axis are actually numeric 
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
})

test_that("plot_regression_scatterplot will have datapoints all be the same colour if theres only one class for specified column", {
  
  chart <- plot_regression_scatterplot(one_color_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  # pull the first layer to make sure axis are actually numeric 
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
})


test_that("plot_regression_scatterplot will plot outliers without error", {
  
  chart <- plot_regression_scatterplot(outliers_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  # pull the first layer to make sure axis are actually numeric 
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
})


test_that("plot_regression_scatterplot will plot a regression graph with only two data points", {
  
  chart <- plot_regression_scatterplot(two_rows_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  # pull the first layer to make sure axis are actually numeric 
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
})


# ---------Error cases-------------------------------------

test_that("plot_regression_scatterplot return an error if a non-existent column name is declared", {
  
  expect_error(plot_regression_scatterplot(two_numeric_columns_color, 
                                           x_var = "wrong_x", 
                                           y_var = "wrong_y",
                                           color_var = "wrong_z"),
               "Column does not exist. Please enter a valid column name")
})



test_that("plot_regression_scatterplot return an error if the dataframe is empty", {

  
  expect_error(plot_regression_scatterplot(empty_df, 
                                           x_var = "x", 
                                           y_var = "y",
                                           color_var = "z"), 
               "Dataframe is empty. Please input valid data")
})



test_that("plot_regression_scatterplot return an error if there is only one row of data", {
  
  expect_error(plot_regression_scatterplot(one_row_df, 
                                           x_var = "x", 
                                           y_var = "y",
                                           color_var = "z"), 
               "Not enough data. Please input at least two rows of data")
})


test_that("plot_regression_scatterplot return an error if x_var and y_var are not numerical columns", {
  
  expect_error(plot_regression_scatterplot(wrong_dtype_df, 
                                           x_var = "x", 
                                           y_var = "y",
                                           color_var = "z"), 
               "Incorrect data type. Please specify numerical data for the x and y-axis")
})



