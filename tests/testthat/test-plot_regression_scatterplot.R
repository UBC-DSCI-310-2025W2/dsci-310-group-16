library(testthat)
library(vdiffr)

source("../../R/plot_regression_scatterplot.R")

### Using vdiffr::expect_doppelganger() to compare unit test outputs to expected outputs
### Helper test data and expected outputs can be found at helper-plot_regression_scatterplot.R

# Expected Cases
# - two numerical columns specified for x and y (no negative values)
# - two numerical columns specified for x and y (with negative values)
# - two numerical columns for x and y and a numerical column for color
# - two numerical columns for x and y and a categorical column for color
# - data has missing values (for x-axis, y-axis, and color)
# - line_se is specified as FALSE
# - changing the colour of line (ex. to blue instead of the default black)
# - changing the title and axis labels 
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



test_that("plot_regression_scatterplot will run without error for two numeric columns with no missing values", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns, 
                                       x_var = "x", 
                                       y_var = "y")
  
  
  expect_doppelganger("two numeric columns, no missing", 
                      plot_two_numeric_columns) #should be identical to expected output in helper file
})



test_that("plot_regression_scatterplot will run without error for two numeric columns of negative values with no missing data", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns, 
                                       x_var = "neg_x", 
                                       y_var = "neg_y")
  
  expect_doppelganger("two negative numeric columns, no missing",
                      plot_two_negative_numeric_columns) #should be identical to expected output in helper file
  
  
})

test_that("plot_regression_scatterplot will run without error for two numeric columns with no missing values and numeric column specified for color", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns_color, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  expect_doppelganger("two numeric columns with color", 
                      plot_two_numeric_columns_color) #should be identical to expected output in helper file
  
  
})


test_that("plot_regression_scatterplot will run without error for two numeric columns with no missing values and categorical column specified for color", {
  
  chart <- plot_regression_scatterplot(mixed_col_types_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  expect_doppelganger("two numeric columns with categorical color column",
                      plot_mixed_col_types) #should be identical to expected output in helper file
  
  
})



test_that("plot_regression_scatterplot will run without error for data with missing values", {
  
  chart <- plot_regression_scatterplot(missing_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  expect_doppelganger("has missing values in axis columns and color column",
                      plot_missing) #should be identical to expected output in helper file
  
  
})



test_that("plot_regression_scatterplot will not have the standard deviation of the regression line if line_se = FALSE", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns_color, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z",
                                       line_se = FALSE)
  
 
  expect_doppelganger("line_se is specified FALSE",
                      plot_no_line_se) #should be identical to expected output in helper file
  
})



test_that("plot_regression_scatterplot will generate a regression line of the specified color", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns_color, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z",
                                       line_color = "blue")
  
  expect_doppelganger("regression line should be blue",
                      plot_line_color) #should be identical to expected output in helper file
  

})




test_that("plot_regression_scatterplot will run display specified title and axis labels", {
  
  chart <- plot_regression_scatterplot(two_numeric_columns_color, 
                                       x_var = "x", 
                                       y_var = "y",
                                       x_labs = "New X-Axis Label",
                                       y_labs = "New Y-Axis Label",
                                       title_labs = "New Title")
  
  expect_doppelganger("chart should have specified axis labels and title",
                      plot_labels) #should be identical to expected output in helper file
  
  
})

# ---------Edge cases-------------------------------------

test_that("plot_regression_scatterplot will run without error for data with no variance", {
  
  chart <- plot_regression_scatterplot(no_variance_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  expect_doppelganger("data has no variance, should not have a regression line",
                      plot_no_variance) #should be identical to expected output in helper file
  
})


test_that("plot_regression_scatterplot will have datapoints all be the same colour if theres only one class for specified column", {
  
  chart <- plot_regression_scatterplot(one_color_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  expect_doppelganger("specified color column has only one class",
                      plot_color_one_class) #should be identical to expected output in helper file
  
})


test_that("plot_regression_scatterplot will plot outliers without error", {
  
  chart <- plot_regression_scatterplot(outliers_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  expect_doppelganger("outliers in x and y axis",
                      plot_outliers) #should be identical to expected output in helper file
  
  

})


test_that("plot_regression_scatterplot will plot a regression graph with only two data points", {
  
  chart <- plot_regression_scatterplot(two_rows_df, 
                                       x_var = "x", 
                                       y_var = "y",
                                       color_var = "z")
  
  expect_doppelganger("dataset with only twos",
                      plot_two_rows) #should be identical to expected output in helper file
  
  

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
              plot_empty)
})



test_that("plot_regression_scatterplot return an error if there is only one row of data", {
  
  expect_error(plot_regression_scatterplot(one_row_df, 
                                           x_var = "x", 
                                           y_var = "y",
                                           color_var = "z"), 
               plot_one_row)
})


test_that("plot_regression_scatterplot return an error if x_var and y_var are not numerical columns", {
  
  expect_error(plot_regression_scatterplot(wrong_dtype_df, 
                                           x_var = "x", 
                                           y_var = "y",
                                           color_var = "z"), 
               plot_wrong_dtype)
})


test_that("plot_regression_scatterplot return an error if specification for line_se is not a valid boolean", {
  
  expect_error(plot_regression_scatterplot(two_numeric_columns_color, 
                                           x_var = "x", 
                                           y_var = "y",
                                           color_var = "z",
                                           line_se = "FALSE"), 
               plot_line_se_bool)
})





