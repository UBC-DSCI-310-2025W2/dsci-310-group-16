# This script fits a regression model and outputs results.

library(docopt)
library(tidyverse)
library(tidymodels)
library(ggplot2)

source("R/plot_regression_scatterplot.R") 
source("R/evaluate_model.R")

doc <- "
Usage:
04_regression-model.R --input=<input_file> --out_prefix=<prefix>

Options:
--input=<input_file>     Path to cleaned data
--out_prefix=<prefix>    Prefix for outputs
"

opt <- docopt(doc)

main <- function(input_file, out_prefix) {
  set.seed(123)
  
  # Read data
  data <- read_csv(input_file, show_col_types = FALSE)
  
  # Split the data into training (80%) and testing (20%) sets
  split <- initial_split(data, prop = 0.8)
  
  train <- training(split)
  test  <- testing(split)
  
  # Specify the linear regression model
  lm_spec <- linear_reg() %>%
    set_engine("lm") %>%
    set_mode("regression")
  
  # Define the model formula 
  lm_recipe <- recipe(child_height ~ midparent_height + gender, data = train)
  
  # Build workflow and fit the model
  lm_fit <- workflow() %>%
    add_recipe(lm_recipe) %>%
    add_model(lm_spec) %>%
    fit(data = train)
  
  # Save coefficients
  coeffs <- lm_fit %>%
    extract_fit_parsnip() %>%
    tidy()
  
  write_csv(coeffs, paste0(out_prefix, "_coefficients.csv"))
  
  # Save metrics
  metrics <- evaluate_model(lm_fit, test, truth_col = "child_height")
  
  write_csv(metrics, paste0(out_prefix, "_metrics.csv"))
  
  # Scatter plot with regression line

  
  regression_scatter <- plot_regression_scatterplot(data,
                                                       x_var = "midparent_height" , 
                                                       y_var = "child_height",
                                                       color_var = "gender",
                                                       x_labs = "Midparent Height (inches)",
                                                       y_labs = "Child Height (inches)", 
                                                       title_labs = "Midparent Height vs Child Height") 
  
  
  ggsave(filename = paste0(out_prefix, "_model-plot.png"), regression_scatter)
}

main(opt$input, opt$out_prefix)