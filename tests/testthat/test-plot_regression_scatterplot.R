library(testthat)

source("../../R/plot_regression_scatterplot.R")

# Expected Cases
# - two numerical columns specified for x and y (no negative values)
# - two numerical columns specified for x and y (with negative values)
# - two numerical columns for x and y and a numerical column for color
# - two numerical columns for x and y and a categorical column for color
# - data has missing values (for x-axis, y-axis, and color)
# - line_se is specified as FALSE
# - changing the colour of line (ex. to blue instead of the default black)
# 
# Edge Cases
# - no variance in the data (ex. same value in entire column)
# - variable used for color grouping only has one category 
# - extreme outliers in either X or Y
# - only 2 rows of data
# 
# 
# Error Cases
# - specified column names don't exist 
# - dataframe has mixed data types 
# - empty dataframe
# - one row of data (ie. 1 data point)
# - x and y are not numerical values 
# - line_se input is not a valid Boolean value 





# ---------Expected cases-------------------------------------

# for certain plot attributes, not going to explicitly test in every case (Ex. line_se = TRUE and line_color = "red")
#those attributes will be the same unless explicitly changed (see tests)

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
  
  
  # pull the second layer which is the geom_smooth() layer 
  smooth_layer <- (ggplot_build(chart))$data[[2]]
  
  expect_true("se" %in% names(smooth_layer)) #should be TRUE because of default value
  expect_equal(head(smooth_layer,1)[['colour']], "black") #should be black because of default value
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
  
  #skipping tests for line_se and line_color because they won't have changed from defaults 
  
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
  
  
  # ensuring aes color argument doesn't override line color
  smooth_layer <- (ggplot_build(chart))$data[[2]] # pull the second layer which is the geom_smooth() layer 
  expect_equal(head(smooth_layer,1)[['colour']], "black") #should still be black 
  
  
  
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
  
  #omitting explicit tests for line_se and line_color because defaults are tested above 
  
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
  
  #omitting explicit tests for line_se and line_color because defaults are tested above 
  
  
})



test_that("plot_regression_scatterplot will not have the standard deviation of the regression line if line_se = FALSE", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns_color, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z",
                                       line_se = "FALSE")
  
  # pull the first layer to make sure axis are actually numeric 
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))
  
  # pull the second layer which is the geom_smooth() layer 
  smooth_layer <- (ggplot_build(chart))$data[[2]]
  
  expect_false("se" %in% names(smooth_layer)) #should be FALSE from input specification

})



test_that("plot_regression_scatterplot will generate a regression line of the specified color", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns_color, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z",
                                       line_color = "blue")
  
  
  # pull the first layer to make sure axis are actually numeric 
  geom_point_layer <- ggplot2::layer_data(chart, 1)  #pulls the geom_point layer
  
  
  expect_no_error(chart) #chart generated without error
  expect_true(!is.null(chart$labels$x)) #x label exists
  expect_true(!is.null(chart$labels$y)) #y label exists
  expect_true(!is.null(chart$labels$title)) #chart title exists
  expect_true(is.numeric(geom_point_layer$x))
  expect_true(is.numeric(geom_point_layer$y))

  
 # pull the second layer which is the geom_smooth() layer 
 smooth_layer <- (ggplot_build(chart))$data[[2]]
  
  expect_equal(head(smooth_layer,1)[['colour']], "blue") #check if the line colour is correct
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
  
  smooth_layer <- (ggplot_build(chart))$data[[2]]
  expect_false("se" %in% names(smooth_layer)) #should be FALSE. No variance means no relation between X and Y

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
  
  #ensure the regression line is graphed between the two points
  smooth_layer <- (ggplot_build(chart))$data[[2]]
  expect_true("se" %in% names(smooth_layer)) #should be TRUE because of default value
  
  
  

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


test_that("plot_regression_scatterplot return an error if specification for line_se is not a valid boolean", {
  
  expect_error(plot_regression_scatterplot(two_numeric_columns_color, 
                                           x_var = "x", 
                                           y_var = "y",
                                           color_var = "z",
                                           line_se = "YES"), 
               "Invalid argument. Please enter TRUE or FALSE")
})





