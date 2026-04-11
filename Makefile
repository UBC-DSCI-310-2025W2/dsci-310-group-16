# Makefile for R Projects
# Usage: make all | make data | make reports | make clean

R       := Rscript
RFLAGS  := 
QUARTO  := quarto

# Directories
SRC   := src
DAT   := data
RAW   := $(DAT)/raw
PROC  := $(DAT)/processed
RES   := results
EDA   := $(RES)/eda
REG   := $(RES)/regression
RPT   := reports

# --- Directory targets -------------------------------------------------------

$(RAW) $(PROC) $(EDA) $(REG):
	mkdir -p $@

# --- Data pipeline -----------------------------------------------------------

# --- Step 1: Download raw dataset -------------------------------------------
# Input: None (downloads from URL)
# Output: data/raw/galton_raw.csv
# Purpose: Fetch the original Galton Families dataset from an online source

$(RAW)/galton_raw.csv: $(SRC)/01_download_data.R | $(RAW)
	$(R) $(RFLAGS) $< \
		--url="https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/HistData/GaltonFamilies.csv" \
		--output="$@"

# --- Step 2: Clean raw data --------------------------------------------------
# Input: raw dataset (galton_raw.csv)
# Output: cleaned dataset (galton_clean.csv)
# Purpose: Remove unnecessary columns, handle missing values, and prepare data for analysis

$(PROC)/galton_clean.csv: $(SRC)/02_clean_data.R $(RAW)/galton_raw.csv | $(PROC)
	$(R) $(RFLAGS) $< \
		--input="$(RAW)/galton_raw.csv" \
		--output="$@"

# --- Step 3: Exploratory Data Analysis (EDA) --------------------------------
# Input: cleaned dataset
# Output: EDA results (summary statistics, plots saved with prefix "eda")
# Purpose: Generate exploratory statistics and visualizations to understand the data

$(EDA)/eda.csv: $(SRC)/03_eda.R $(PROC)/galton_clean.csv | $(EDA)
	$(R) $(RFLAGS) $< \
		--input="$(PROC)/galton_clean.csv" \
		--out_prefix="$(EDA)/eda"

# --- Step 4: Regression Modeling --------------------------------------------
# Input: cleaned dataset
# Output: regression results (coefficients, metrics saved with prefix "regression")
# Purpose: Fit a linear regression model to predict child height from parent height and gender

$(REG)/regression.csv: $(SRC)/04_regression-model.R $(PROC)/galton_clean.csv | $(REG)
	$(R) $(RFLAGS) $< \
		--input="$(PROC)/galton_clean.csv" \
		--out_prefix="$(REG)/regression"

DATA_TARGETS := \
	$(RAW)/galton_raw.csv \
	$(PROC)/galton_clean.csv \
	$(EDA)/eda.csv \
	$(REG)/regression.csv

# --- Reports: .qmd → .html / .pdf -------------------------------------------

# Will render directly to reports/ folder where .qmd file is 

$(RPT)/galton-heights-regression.html: $(RPT)/galton-heights-regression.qmd $(DATA_TARGETS)
	$(QUARTO) render $< --to html 


	
RPT_TARGETS := \
	$(RPT)/galton-heights-regression.html 
# --- Top-level targets -------------------------------------------------------

.PHONY: all data reports clean

# run the entire pipeline: data processing and report generation
all: data reports

# run all data processing steps
data: $(DATA_TARGETS)

# run all report generation steps
reports: $(RPT_TARGETS)

# remove all generated files and directories
clean:
	rm -f $(PROC)/*.csv
	rm -rf $(EDA)
	rm -rf $(REG)
	rm -r $(RPT)/galton-heights-regression.html
