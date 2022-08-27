.DEFAULT_GOAL := help

SRC_DIR := ./tex
TEX_FILES :=  $(shell ls $(SRC_DIR)/*.tex)

.PHONY: all
all: # Make slides 
all: beamer.pdf

# MAIN LATEXMK RULE
# https://tex.stackexchange.com/a/40759
# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.
# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

beamer.pdf: beamer.tex $(TEX_FILES)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $<

.PHONY: clean
clean: # Clean aux and log files
	rm -f *.aux *.log

.PHONY: purge
purge: # Purge all other files that are not the original .tex and pdf output
	rm -f *.aux *.log
	rm -f *.nav *.out *.snm *.toc *.fdb_latexmk *.fls *.synctex.gz

.PHONY: help
help: # Show Help
	@egrep -h '\s#\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
