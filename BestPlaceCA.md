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
```

| Counties        |  IncomePerCap|  HouseholdIncome|  UnemploymentRate|  RecentJobGrowth|  FutureJobGrowth|
|:----------------|-------------:|----------------:|-----------------:|----------------:|----------------:|
| United States   |         28555|            53482|               5.2|             1.59|            37.98|
| Alameda         |         36439|            73775|               4.7|             2.62|            40.53|
| Alpine          |         24375|            61343|               7.6|             1.70|            35.80|
| Amador          |         27373|            52964|               6.1|             1.60|            37.10|
| Butte           |         24430|            43165|               7.2|             1.45|            35.71|
| Calaveras       |         29296|            54936|               6.0|             2.92|            39.85|
| Colusa          |         22211|            50503|              13.7|             2.84|            31.99|
| Contra Costa    |         38770|            79799|               4.9|             2.56|            40.23|
| Del Norte       |         19424|            39302|               7.4|             0.86|            34.31|
| El Dorado       |         35128|            68507|               5.4|             2.19|            38.99|
| Fresno          |         20231|            45201|               9.4|             2.33|            35.25|
| Glenn           |         21698|            40106|               8.6|             3.98|            39.36|
| Humboldt        |         23516|            42153|               5.2|             0.94|            36.68|
| Imperial        |         16409|            41772|              23.7|             0.25|            16.80|
| Inyo            |         27028|            45625|               5.3|             0.13|            34.95|
| Kern            |         20467|            48574|              10.8|            -0.06|            29.07|
| Kings           |         18518|            47341|              10.2|             2.62|            35.04|
| Lake            |         21310|            35997|               6.7|             0.30|            33.90|
| Lassen          |         19847|            53351|               6.7|             2.09|            37.49|
| Los Angeles     |         27987|            55870|               5.2|             1.37|            37.55|
| Madera          |         17797|            45490|               9.4|            -1.82|            26.97|
| Marin           |         58004|            91529|               3.5|             1.84|            40.17|
| Mariposa        |         28327|            50560|               5.8|             1.02|            36.25|
| Mendocino       |         23712|            43290|               5.1|             0.19|            35.27|
| Merced          |         18464|            43066|              10.6|             1.77|            32.94|
| Modoc           |         21830|            38560|               7.2|            -1.65|            29.51|
| Mono            |         29578|            61814|               5.9|             1.53|            37.16|
| Monterey        |         25048|            58582|               6.2|             2.15|            38.11|
| Napa            |         35092|            70925|               4.2|             2.36|            40.51|
| Nevada          |         32117|            56949|               5.0|             1.82|            38.64|
| Orange          |         34416|            75998|               4.4|             2.26|            40.13|
| Placer          |         35711|            73747|               4.8|             2.25|            39.70|
| Plumas          |         29167|            48032|               8.3|            -1.18|            29.34|
| Riverside       |         23660|            56592|               6.7|             3.40|            40.10|
| Sacramento      |         27071|            55615|               5.9|             2.27|            38.64|
| San Benito      |         26317|            67874|               6.9|             3.32|            39.74|
| San Bernardino  |         21384|            54100|               6.4|             3.44|            40.49|
| San Diego       |         31043|            63996|               5.1|             2.22|            39.34|
| San Francisco   |         49986|            78378|               3.5|             3.85|            44.19|
| San Joaquin     |         22642|            53253|               8.3|             2.82|            37.35|
| San Luis Obispo |         30392|            59454|               4.5|             2.58|            40.66|
| San Mateo       |         47198|            91421|               3.3|             3.79|            44.29|
| Santa Barbara   |         30526|            63409|               4.9|             1.30|            37.70|
| Santa Clara     |         42666|            93854|               4.1|             3.34|            42.59|
| Santa Cruz      |         33050|            66923|               6.3|             2.14|            37.98|
| Shasta          |         23763|            44556|               7.2|             1.38|            35.56|
| Sierra          |         28030|            43107|               7.4|            -3.76|            25.09|
| Siskiyou        |         22482|            37495|               7.5|             1.65|            35.80|
| Solano          |         29132|            67341|               5.9|             2.81|            39.72|
| Sonoma          |         33361|            63799|               4.2|             2.24|            40.28|
| Stanislaus      |         21729|            49573|               9.2|             2.16|            35.12|
| Sutter          |         23828|            51527|               9.8|             2.77|            35.74|
| Tehama          |         21002|            42369|               7.8|             1.66|            35.51|
| Trinity         |         23145|            36862|               6.4|             2.10|            37.80|
| Tulare          |         17888|            42863|              10.8|             3.75|            36.70|
| Tuolumne        |         26063|            48493|               6.4|             1.30|            36.20|
| Ventura         |         33308|            77335|               5.4|             0.36|            35.31|
| Yolo            |         28080|            55508|               5.9|             2.21|            38.52|
| Yuba            |         19586|            45470|               8.8|             2.48|            36.17|

``` r
knitr::kable(CA_cost)
```

| Counties        |  Overall|  Grocery|  Health|  Housing|  Utilities|  Transportation|  Miscellaneous|
|:----------------|--------:|--------:|-------:|--------:|----------:|---------------:|--------------:|
| United States   |      100|    100.0|     100|      100|        100|             100|            100|
| Alameda         |      202|    118.4|     112|      396|         96|             106|            110|
| Alpine          |      131|    102.6|     114|      186|         92|             106|            105|
| Amador          |      119|    102.6|     114|      148|         92|             106|            105|
| Butte           |      112|    101.5|     105|      134|         94|             105|             99|
| Calaveras       |      118|    102.6|     114|      145|         92|             106|            105|
| Colusa          |      105|    102.6|     114|      104|         92|             106|            105|
| Contra Costa    |      168|    118.5|     111|      289|         95|             107|            112|
| Del Norte       |      104|    100.4|     107|      112|         96|             105|             97|
| El Dorado       |      141|    110.0|     108|      211|        111|             112|            102|
| Fresno          |      108|    105.0|     105|      110|        121|             111|            104|
| Glenn           |      114|    102.6|     114|      133|         92|             106|            105|
| Humboldt        |      116|     99.6|     106|      146|         95|             107|             99|
| Imperial        |      100|     99.8|     105|       98|         95|             107|             98|
| Inyo            |      117|    100.2|     107|      151|         93|             107|             97|
| Kern            |      102|    101.2|     106|       98|        112|             108|            101|
| Kings           |       98|    101.4|     106|       91|         94|             107|             98|
| Lake            |      114|    116.1|     114|      115|         99|             111|            115|
| Lassen          |       96|    101.3|     105|       84|         95|             107|             97|
| Los Angeles     |      156|     95.5|      93|      283|        110|             102|             91|
| Madera          |      104|    100.3|     105|      110|         94|             107|             98|
| Marin           |      248|    118.5|     111|      539|         95|             107|            112|
| Mariposa        |      111|    102.6|     114|      125|         92|             106|            105|
| Mendocino       |      138|    116.8|     114|      192|         98|             111|            114|
| Merced          |      104|     99.8|     107|      111|         95|             106|             97|
| Modoc           |      102|    102.6|     114|       97|         92|             106|            105|
| Mono            |      133|    102.6|     114|      192|         92|             106|            105|
| Monterey        |      148|    100.4|     107|      250|         95|             105|             96|
| Napa            |      175|    116.6|     116|      308|        100|             112|            114|
| Nevada          |      151|    138.3|     114|      206|        125|             120|            126|
| Orange          |      187|    106.3|     108|      356|        110|             113|            104|
| Placer          |      145|    110.0|     108|      224|        111|             112|            102|
| Plumas          |      110|    102.6|     114|      121|         92|             106|            105|
| Riverside       |      126|    108.3|     100|      173|        110|             110|             98|
| Sacramento      |      127|    111.8|     108|      167|        114|             108|            103|
| San Benito      |      160|    117.0|     116|      263|        127|             110|            104|
| San Bernardino  |      121|    108.0|     103|      153|        107|             113|            100|
| San Diego       |      160|    106.8|     111|      273|        101|             112|            103|
| San Francisco   |      275|    121.6|     115|      610|         96|             115|            119|
| San Joaquin     |      122|    105.1|     110|      156|         98|             108|            105|
| San Luis Obispo |      162|    101.0|     105|      292|         94|             107|             97|
| San Mateo       |      258|    118.5|     111|      571|         95|             107|            112|
| Santa Barbara   |      164|    101.9|     105|      297|         95|             106|             97|
| Santa Clara     |      242|    120.4|     114|      515|        128|             112|            105|
| Santa Cruz      |      194|    101.1|     105|      391|         93|             105|             97|
| Shasta          |      107|     99.7|     107|      119|         94|             106|             98|
| Sierra          |      110|    102.6|     114|      121|         92|             106|            105|
| Siskiyou        |       98|    102.6|     114|       83|         92|             106|            105|
| Solano          |      139|    116.2|     114|      193|         99|             112|            114|
| Sonoma          |      171|    117.6|     116|      293|        100|             111|            114|
| Stanislaus      |      118|    114.4|     109|      136|        111|             111|            104|
| Sutter          |      116|    113.5|     108|      130|        110|             110|            105|
| Tehama          |       97|    100.1|     105|       90|         95|             105|             98|
| Trinity         |      112|    102.6|     114|      126|         92|             106|            105|
| Tulare          |       99|    101.4|     105|       96|         95|             107|             97|
| Tuolumne        |      126|    114.3|     109|      163|        111|             111|            104|
| Ventura         |      159|     99.7|     105|      285|         95|             104|             97|
| Yolo            |      137|    110.0|     108|      200|        111|             112|            102|
| Yuba            |      110|    112.0|     109|      113|        111|             109|            106|

### Plot1: Overall Cost-of-Living in California

![](./Overall%20Cost-of-Living%20in%20California.png)

We can esaily find from the figure above that the average cost-of-living is higher than the average of US. Only very few counties' cost-of-living are below the US average. Also, the highest is San Francisco.

*Overall cost-of-living:*

*The total of all the cost of living categories weighted subjectively as follows: housing (30%), food and groceries (15%), transportation (10%), utilities (6%), health care (7%), and miscellaneous expenses such as clothing, services, and entertainment (32%). State and local taxes are not included in any category. Updated: December, 2016*

### Plot2: UnemploymentRate v.s. FutureJobGrowthRate

![](./UnemploymentRate%20v.s.%20FutureJobGrowthRate.png)

From the figure above we can see that most of counties in CA have a good future for people who want to search job because most results locate in the left upper hand corner(the UnemploymentRate is low and the FutureJobGrowthRate is high).

*UnemploymentRate:*

*The most recent unemployment data for an area. The unemployment rate is expressed as a percentage of the available work force that is not employed. Updated: December, 2016*

*FutureJobGrowthRate:*

*The projected change in job availability over the next ten years based on migration patterns, economic growth, and other factors. A projected decrease in available jobs is represented as a negative number. Updated: December, 2016*

### Plot3: IncomePerCap in California

![](./IncomePerCap%20in%20California.png) The figure above is about the IncomePerCap in California.

*IncomePerCap:*

*The average income of every resident of a geographic area, including all adults and children. Updated: December, 2016*

Useful Links
------------

[scraping-data-without-an-api](https://github.com/ropensci/user2016-tutorial/blob/master/03-scraping-data-without-an-api.pdf)

[Extracting data from the web APIs and beyond](https://github.com/ropensci/user2016-tutorial)
