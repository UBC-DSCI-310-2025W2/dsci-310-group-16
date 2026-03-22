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

$(RAW)/galton_raw.csv: $(SRC)/01_download_data.R | $(RAW)
	$(R) $(RFLAGS) $< \
		--url="https://raw.githubusercontent.com/vincentarelbundock/Rdatasets/master/csv/HistData/GaltonFamilies.csv" \
		--output="$@"

$(PROC)/galton_clean.csv: $(SRC)/02_clean_data.R $(RAW)/galton_raw.csv | $(PROC)
	$(R) $(RFLAGS) $< \
		--input="$(RAW)/galton_raw.csv" \
		--output="$@"

$(EDA)/eda.csv: $(SRC)/03_eda.R $(PROC)/galton_clean.csv | $(EDA)
	$(R) $(RFLAGS) $< \
		--input="$(PROC)/galton_clean.csv" \
		--out_prefix="$(EDA)/eda"

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

$(RPT)/galton-heights-regression.pdf: $(RPT)/galton-heights-regression.qmd $(DATA_TARGETS)
	$(QUARTO) render $< --to pdf 
	
	
RPT_TARGETS := \
	$(RPT)/galton-heights-regression.html \
	$(RPT)/galton-heights-regression.pdf

# --- Top-level targets -------------------------------------------------------

.PHONY: all data reports clean

all: data reports

data: $(DATA_TARGETS)

reports: $(RPT_TARGETS)

clean:
	rm -f $(PROC)/*.csv
	rm -rf $(EDA)
	rm -rf $(REG)
	rm -r $(RPT)/galton-heights-regression.html
	rm -r $(RPT)/galton-heights-regression.pdf
