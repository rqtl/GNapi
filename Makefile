.PHONY: doc vignette

all: doc docs/GNapi.html

# build package documentation
doc:
	R -e 'devtools::document()'

docs/GNapi.html: vignettes/GNapi.Rmd docs/badges.html docs/paste_badges.R
	R -e "rmarkdown::render('$<')"
	mv $(<D)/$(@F) $@
	cd $(@D);paste_badges.R $(@F)
