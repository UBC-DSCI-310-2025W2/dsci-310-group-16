# This script performs exploratory data analysis and saves plots and tables.

library(docopt)
library(tidyverse)
library(ggplot2)

doc <- "
Usage:
03_eda.R --input=<input_file> --out_prefix=<prefix>

Options:
--input=<input_file>     Path to cleaned data
--out_prefix=<prefix>    Prefix for output files
"

opt <- docopt(doc)

main <- function(input_file, out_prefix) {
  
  # Read data
  data <- read_csv(input_file, show_col_types = FALSE)
  
  # Missing values table
  missing_vals <- colSums(is.na(data))
  missing_df <- tibble(
    variable = names(missing_vals),
    missing_values = missing_vals)
  
  write_csv(missing_df, paste0(out_prefix, "_missing.csv"))
  
  # Child height histogram
  hist_child_height <- ggplot(data, aes(x = child_height)) +
    geom_histogram(bins = 30, fill = "steelblue", color = "black") +
    labs(
      title = "Distribution of Child Height",
      x = "Child Height (inches)",
      y = "Count"
    )
  
  ggsave(paste0(out_prefix, "_hist-child-height.png"), hist_child_height)
  
  # Child height vs midparent height scatter plot
  scatter_parent_child <- ggplot(data, aes(x = midparent_height, y = child_height)) +
    geom_point(alpha = 0.5) +
    geom_smooth(method = "lm", color = "red") +
    labs(
      title = "Child Height vs Midparent Height",
      x = "Midparent Height",
      y = "Child Height"
    )
  
  ggsave(paste0(out_prefix, "_scatter-parent-child-height.png"), scatter_parent_child)
  
  # Child height by gender boxplot
  boxplot_gender_height <- ggplot(data, aes(x = gender, y = child_height)) +
    geom_boxplot(fill = "lightblue") +
    labs(
      title = "Child Height by Gender",
      x = "Gender",
      y = "Child Height"
    )
  
  ggsave(paste0(out_prefix, "_boxplot-gender-height.png"), boxplot_gender_height)
}

main(opt$input, opt$out_prefix)