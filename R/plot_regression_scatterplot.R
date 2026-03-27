#' Create scatter plot graph 
#'
#' Creates a scatterplot with a regression line, taking in two numeric variables for x-axis and y-axis,
#' with optional variables for formatting, 
#' Plot will be saved as a png at specified location
#'
#' @param df A tidy dataframe 
#' @param x_var Unquoted column name to plot on the x-axis
#' @param y_var Unquoted column name to plot on the y-axis
#' @param color_var [Optional] Column name to map a color scheme to data points, 
#' @param alpha [Optional] Float from range 0,1 to control regression line transparency, default value is 0.5 
#' @param line_se [Optional] Display standard error of regression line, default value is True
#' @param line_color [Optional] Color of regression line, default value is red
#' @param x_labs [Optional] X-axis label 
#' @param y_labs [Optional] Y-axis label 
#' @param title_labs [Optional] Plot title 
#' 
#' @returns A labelled scatterplot with a simple linear regression line, using a linear smoothing method with 
#' 
#' 
#' @export
#'
#' @examples

library(tidyverse)

plot_regression_scatterplot <- function(df,
                                        x_var, 
                                        y_var, 
                                        color_var = NULL, #optional arg
                                        line_se = TRUE, #optional arg
                                        line_color = "black", #optional arg 
                                        x_labs = "X Axis Label",
                                        y_labs = "Y Axis Label", 
                                        title_labs = "Plot Title") 

  
{ 
  
  # if logic to check that column name actually exists
  
  if ( !(x_var %in% colnames(df)) & !(y_var %in% colnames(df))) {
    stop("Column does not exist. Please enter a valid column name")}
  

  # if logic to ensure dataframe isn't empty 
  if (nrow(df) == 0) {stop("Dataframe is empty. Please input valid data")}  
  
  
  # if logic to ensure theres more than 1 row of data
  if (nrow(df) == 1) {stop("Not enough data. Please input at least two rows of data")}
  
  
  
  # if logic to check that x and y axis columns are numeric   
  if (!is.numeric(df[[x_var]])) {
    stop("Incorrect data type. Please specify numerical data for the x and y-axis")
  }
  
  if (!is.numeric(df[[y_var]])) {
    stop("Incorrect data type. Please specify numerical data for the x and y-axis")
  }

  

  
  
# if logic to translate boolean string to actual boolean 
  if (is.character(line_se)) {
    if (line_se == "FALSE") {line_se_bool <- FALSE
      } else if (line_se == "TRUE") {line_se_bool <- TRUE
        } else { stop("Invalid argument. Please enter TRUE or FALSE")}

    } else if (is.logical(line_se)) {line_se_bool <- line_se
    } else {stop("Invalid argument. Please enter a boolean argument")}
  
  
  
# if statement for whether color is a specified column
if (!is.null(color_var)) {
  regression_scatterplot <- ggplot(df, aes(
    x = .data[[x_var]],
    y = .data[[y_var]],
    color = .data[[color_var]]
  ))
} else {
  regression_scatterplot <- ggplot(df, aes(
    x = .data[[x_var]],
    y = .data[[y_var]]
  ))
}
  
  # --- add layers ---
  regression_scatterplot <-  regression_scatterplot +
    geom_point(alpha = 0.5) +
    geom_smooth(method = "lm", se = line_se_bool, color = line_color) +
    labs(
      x = x_labs,
      y = y_labs,
      title = title_labs
    )
  
  return( regression_scatterplot)
}                 
                                          
                                          
                                        


