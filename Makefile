all: BestPlaceCA.html

clean:
	rm -f *.csv
	rm -f *.png
	rm -f BestPlaceCA.md
	rm -f *.html

CA_counties_job.csv CA_counties_cost.csv All_city_cost.csv All_city_job.csv:
	Rscript ScrapeData.R
	
CA_job.csv CA_cost.csv plot: TidyAndPlot.R All_city_cost.csv All_city_job.csv
	Rscript $<
	rm -f Rplots.pdf
	
BestPlaceCA.html: BestPlaceCA.Rmd CA_job.csv CA_cost.csv plot
	Rscript -e 'rmarkdown::render("$<")'