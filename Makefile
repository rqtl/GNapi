.PHONY: doc vignette

all: doc docs/GNapi.html

# build package documentation
doc:
	R -e 'devtools::document()'

docs/GNapi.html: vignettes/GNapi.Rmd
	R -e "rmarkdown::render('$<')"
	mv $(<D)/$(@F) $@
