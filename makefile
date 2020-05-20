LIST = implementation
LIST += data

all:
	for fol in $(LIST) ; do \
		pwd && echo $$fol && cp makefile.copy $$fol/makefile ; \
	done
	Rscript -e "source('notoc.R')" || true; 
	for fol in $(LIST) ; do \
		pwd && echo $$fol && cp makefile.copy $$fol/makefile && cd $$fol && make all && cd ../; \
	done
	for fol in $(LIST) ; do \
		cd $$fol && make index_notoc.html && cd ../; \
	done
	Rscript -e "rmarkdown::render('index.Rmd')"
	Rscript -e "rmarkdown::render('index_notoc.Rmd')"
#  

index.html: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

clean: 
	rm index.html
