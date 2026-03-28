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
# will be using vdiffr to compare the unit test graphical output with expected graphical output

# Expected Cases ------------------------

plot_two_numeric_columns <- ggplot(two_numeric_columns, aes(x = x, y = y)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")


plot_two_negative_numeric_columns <- ggplot(two_numeric_columns, aes(x = neg_x, y = neg_y)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")


plot_two_numeric_columns_color  <- ggplot(two_numeric_columns_color, 
                                          aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")


plot_mixed_col_types <- ggplot(mixed_col_types_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")

plot_missing <- ggplot(missing_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")

plot_no_line_se <- ggplot(two_numeric_columns_color, 
                          aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")

plot_line_color <- ggplot(two_numeric_columns_color, 
                          aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")


plot_labels <- ggplot(two_numeric_columns_color, 
                          aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "NEW Label for X-Axis",
    y = "NEW Label for Y-Axis",
    title = "NEW Plot Title")


# Edge Cases -----------------------------------

plot_no_variance  <- ggplot(no_variance_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")

plot_color_one_class  <- ggplot(one_color_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "Label for X-Axis",
    y = "Label for Y-Axis",
    title = "Plot Title")


plot_outliers  <- ggplot(outliers_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "X Label",
    y = "Y Label",
    title = "Edge Case - Outliers in X and Y"
  )


plot_two_rows  <- ggplot(two_rows_df, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    x = "X Label",
    y = "Y Label",
    title = "Edge Case - Only Two Rows of Data"
  )



# Error Cases ---------------------------------------------

#these are the error messages that should be generated in the event of error cases

plot_empty <- "Dataframe is empty. Please input valid data"


plot_one_row <- "Not enough data. Please input at least two rows of data"

plot_wrong_dtype <- "Incorrect data type. Please specify numerical data for the x and y-axis"

 
plot_line_se_bool <- "Invalid argument. Please enter a boolean argument"