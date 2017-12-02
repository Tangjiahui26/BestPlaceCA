all: CA_job.csv CA_cost.csv

clean:
	rm -f *.csv
	rm -f *.png

CA_counties_job.csv CA_counties_cost.csv All_city_cost.csv All_city_job.csv:
	Rscript ScrapeData.R
	
CA_job.csv CA_cost.csv: TidyAndPlot.R All_city_cost.csv All_city_job.csv
	Rscript $<
	rm -f Rplots.pdf
