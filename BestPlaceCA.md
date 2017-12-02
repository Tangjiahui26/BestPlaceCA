BestPlaceCA
================
Jiahui Tang
2017-12-01

``` r
library(httr)
library(glue)
library(rvest)
library(stringr)
library(tidyverse)
library(reshape)
library(ggplot2)
```

Scrape data
-----------

Work through the final set of slides from the rOpenSci UseR! 2016 workshop. This will give you basic orientation, skills, and pointers on the rvest package.

Scrape a multi-record dataset off the web! Convert it into a clean and tidy data frame. Store that as a file ready for (hypothetical!) downstream analysis. Do just enough basic exploration of the resulting data, possibly including some plots, that you and a reader are convinced you’ve successfully downloaded and cleaned it.

About this project
------------------

***This project is one homework for [STAT547](http://stat545.com/index.html)***

I followed the tutorial of @ropensci and scraped some data about the Cost-of-Living and Job of Counties in California. I used some functions like read\_html(), html\_nodes() and html\_attr() to get useful data without using API.

The website that I extracted is [bestplaces](https://www.bestplaces.net).

Display data and plots
----------------------

``` r
CA_cost <- read_csv("./CA_cost.csv")
CA_job <- read_csv("./CA_job.csv")
```

I scraped some data and created two data.frame for them, namely CA\_job and CA\_cost. The detailed informations are shown below.

``` r
knitr::kable(CA_job)
knitr::kable(CA_cost)
```

### Plot1: Overall Cost-of-Living in California

![](./Overall%20Cost-of-Living%20in%20California.png)

We can esaily find from the figure above that the average cost-of-living is higher than the average of US. Only very few counties' cost-of-living are below the US average. Also, the highest is San Francisco.

*Overall cost-of-living:*

*The total of all the cost of living categories weighted subjectively as follows: housing (30%), food and groceries (15%), transportation (10%), utilities (6%), health care (7%), and miscellaneous expenses such as clothing, services, and entertainment (32%). State and local taxes are not included in any category. Updated: December, 2016*

### Plot2: UnemploymentRate v.s. FutureJobGrowthRate

![](./UnemploymentRate%20v.s.%20FutureJobGrowthRate.png)

From the figure above we can see that most of counties in CA have a good future for people who want to search job because most results locate in the left upper hand corner(the UnemploymentRate is low and the FutureJobGrowthRate is high).

*UnemploymentRate: *

*The most recent unemployment data for an area. The unemployment rate is expressed as a percentage of the available work force that is not employed. Updated: December, 2016*

*FutureJobGrowthRate: *

*The projected change in job availability over the next ten years based on migration patterns, economic growth, and other factors. A projected decrease in available jobs is represented as a negative number. Updated: December, 2016*

### Plot3: IncomePerCap in California

![](./IncomePerCap%20in%20California.png) The figure above is about the IncomePerCap in California.

*IncomePerCap: *

*The average income of every resident of a geographic area, including all adults and children. Updated: December, 2016*

Useful Links
------------

[scraping-data-without-an-api](https://github.com/ropensci/user2016-tutorial/blob/master/03-scraping-data-without-an-api.pdf)

[Extracting data from the web APIs and beyond](https://github.com/ropensci/user2016-tutorial)
