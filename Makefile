
all: pages 

skeleton-%.R: %.Rmd
	Rscript -e "knitr::purl('$<', output='$@', documentation=0L)"

%.html: %.Rmd
	Rscript -e "rmarkdown::render('$<', output_format=rmarkdown::html_document(toc=TRUE, highlight='tango', self_contained=FALSE, lib_dir='libs'))"

index.html: index.md
	pandoc -o $@ $^

motivation.html: motivation.md
	pandoc -o $@ $^

handout-script.R: skeleton-00-before-we-start.R skeleton-01-intro-to-R.R skeleton-02-starting-with-data.R skeleton-03-data-frames.R skeleton-04-dplyr.R
	for f in $^; do cat $$f; echo "\n"; done > $@
	make clean-skeleton

pages: index.html motivation.html 00-before-we-start.html 01-help.html 03-creating-things.html 04-vectors.html 05-starting-with-data.html 06-factors.html 07-data-frames.html 08-dplyr.html 09-visualization-ggplot2.html 10-r-and-sql.html

clean-skeleton:
	-rm skeleton-*-*.R

clean-html:
	-rm *.html

clean: clean-skeleton clean-html
