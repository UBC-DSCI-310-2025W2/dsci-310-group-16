library(pointblank)
library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)
input_arg <- args[grep("--input=", args)]

input <- if (length(input_arg) > 0) {
  sub("--input=", "", input_arg)
} else {
  here::here("data/processed/galton_clean.csv")
}

data <- read_csv(input)

fatal   <- action_levels(stop_at = 1)
warn    <- action_levels(warn_at = 0.05)
lenient <- action_levels(warn_at = 1)

agent <- data |>
  create_agent() |>
  
  #1 Correct column names
  col_exists(c("family", "father", "mother", "midparentHeight", "children", "childNum", "gender", "childHeight"),
             actions = fatal) |>
  
  #2 Correct data types in each column
  col_is_numeric(c("father", "mother", "children","midparentHeight", "childNum", "childHeight"), actions = fatal) |>
  
  #3 No empty observations
  col_vals_not_null(c("father", "mother", "childHeight", "gender"), actions = fatal) |>

  #4 Missingness not beyond expected threshold - At least 95% of the values in each column should be non-missing
  col_vals_not_null(
    columns = c("family", "father", "mother", "midparentHeight", 
                "children", "childNum", "gender", "childHeight"),
    actions = action_levels(warn_at = 0.05, stop_at = 0.20)
  ) |>
  
  #5 Target/response variable follows expected distribution
  col_vals_between(
    columns = childHeight,
    left  = 60, right = 72,
    na_pass = TRUE,
    actions = lenient,
    label = "childHeight mean plausibility"
  ) |>
  
  #6 No duplicate rows
  rows_distinct(actions = warn) |>
  
  #7 No outliers / anomalous values - Heights of parents and children should be within a reasonable range (e.g., 50 inches to 90 inches)
  col_vals_between(father, 50, 90) |>
  col_vals_between(mother, 50, 90) |>
  col_vals_between(childHeight, 50, 90) |>

  #8 Correct category levels (i.e., no string mismatches or single values)
  col_vals_in_set(gender, set = c("male", "female"), actions = fatal) |>

  interrogate()

get_agent_report(agent)