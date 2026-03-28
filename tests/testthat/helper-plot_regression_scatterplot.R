# function input for tests for plot_regression_scatterplot

# ---------------- HELPER DATA FOR TESTS ------------------------------------

# For Expected Cases ----------------------------- 
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
                         z=c(NA, "apple", "orange", "orange"))


# For Edge Cases ----------------------------------------

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

# For Error Cases ------------------------------


empty_df <- data.frame(x = integer(),
                       y = integer(),
                       z = character())

one_row_df <- data.frame(x=c(100), 
                          y=c(10),
                          z=c("apple"))
                                 
wrong_dtype_df <- data.frame(x=c("100", "200", "300", "400"), 
                         y=c(TRUE, FALSE, FALSE, TRUE),
                         z=c("apple", "orange", "cherry", "peach")) 


                                 
# ---------EXPECTED FUNCTION OUTPUT FROM PLOT_REGRESSION_SCATTERPLOT()-----------

# since this function is a plot, the expected output will either be a chart or an error message
# the helper data are toy datasets so there's not much value in repeatedly generating garbage graphs for expected cases
# therefore, will be creating the expected outputs of a valid case, edge case, and error cases for coverage 


# Expected Cases ------------------------

plot_mixed_col_types_df <- ggplot(mixed_col_types_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "X Label",
    y = "Y Label",
    title = "Expected Test Case"
  )

#print(plot_mixed_col_types_df) #uncomment to view in the console 
  

# Edge Cases -----------------------------------

plot_no_variance_df  <- ggplot(no_variance_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "X Label",
    y = "Y Label",
    title = "Edge Case - No Variance"
  )

#print(plot_no_variance_df) #uncomment to view in console


plot_outliers_df  <- ggplot(outliers_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "X Label",
    y = "Y Label",
    title = "Edge Case - Outliers in X and Y"
  )

#print(plot_outliers_df) #uncomment to view in console 


plot_two_rows_df  <- ggplot(two_rows_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "X Label",
    y = "Y Label",
    title = "Edge Case - Only Two Rows of Data"
  )

#print(plot_two_rows_df) #uncomment to view in console 


# Error Cases ---------------------------------------------

#note: these should be error messages but I can't store them as actual error messages with stop()
# or else the test suite won't continue running

plot_empty_df <- "Dataframe is empty. Please input valid data"


plot_one_row_df <- "Not enough data. Please input at least two rows of data"

plot_wrong_dtype_df <- "Incorrect data type. Please specify numerical data for the x and y-axis"

 