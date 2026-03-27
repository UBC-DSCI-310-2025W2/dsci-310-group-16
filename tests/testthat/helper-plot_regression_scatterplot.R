# function input for tests for plot_regression_scatterplot

# for expected cases 
two_numeric_columns <- data.frame(x=1:4, 
                                  y=10:13,
                                  neg_x = -4:-1,
                                  neg_y=-13:-10)

two_numeric_columns_color <- data.frame(x=1:4, 
                                        y=8:11,
                                        z=444:447)

mixed_col_types_df <- data.frame(x=c(100.00, 2123, 8723.9983, 123), 
                                 y=-11:-8,
                                 z=c("apple", "apple", "orange", "orange"))


missing_df <- data.frame(x=c(NA, 100, 723.9983, 123), 
                         y=c(-10, -5, 0, NA),
                         z=c("peach", "apple", "orange", "orange"))


# for edge cases


no_variance_df <- data.frame(x=c(1, 1, 1, 1), 
                             y=c(100, 100, 100, 100),
                             z=c("apple", "apple", "orange", "orange"))
            
one_color_df <- data.frame(x=c(100.00, 2123, 8723.9983, 123), 
                                 y=-11:-8,
                                 z=c("apple", "apple", "apple", "apple"))

outliers_df <- data.frame(x=c(-10000000, 2123, 8723.9983, 123), 
                          y=c(-10, -5, 0, 10000000),
                          z=c("apple", "apple", "orange", "orange"))


two_rows_df <- data.frame(x=c(100, 200), 
                          y=c(10, 20),
                          z=c("apple", "orange"))

# error cases 



mixed_var_types_df <- data.frame(x=c(1, "100", 723.9983, "123"), 
                                 y=-11:-8,
                                 z = c(999, "apple", "orange", "orange"))

empty_df <- data.frame(x = integer(),
                       y = integer(),
                       z = character())

one_row_df <- data.frame(x=c(100), 
                          y=c(10),
                          z=c("apple"))
                                 
wrong_dtype_df <- data.frame(x=c("100", "200", "300", "400"), 
                         y=c(TRUE, FALSE, FALSE, TRUE),
                         z=c("apple", "orange", "cherry", "peach"))                  
                                 
# expected function output from plot_regression_scatterplot

#### how am i supposed to do this for a graph?? do I manually hard code all the correct graphs with ggplot?
#### for the error cases, do I just return the error message then?