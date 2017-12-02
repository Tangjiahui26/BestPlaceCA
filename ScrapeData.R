library(httr)
library(glue)
library(rvest)
library(stringr)
library(tidyverse)
library(reshape)
library(ggplot2)

#Download the HTML and turn it into an XML file with read_html()
my_url <- "http://www.bestplaces.net/find/county.aspx?counties=ca"
bestplace_ca <- read_html(my_url)

#Extract some Links baesd on Webpage structure
bestplace_ca_link <- bestplace_ca %>% 
    html_nodes("a") %>% 
    html_attr("href")

#Extract some text(ounties' name) baesd on Webpage structure
bestplace_ca_counties <- bestplace_ca %>% 
    html_nodes("a") %>% 
    html_text()

#Create a new data.frame for CA_counties
CA_counties <- data.frame(
    State = "California",
    Counties = bestplace_ca_counties[55:112],
    Link = bestplace_ca_link[55:112]
)

#Add Job_url
Job_url <- "https://www.bestplaces.net/jobs"
Job_Link <- CA_counties$Link %>% 
    str_replace_all("\\.\\.",Job_url)
CA_counties$Link=Job_Link

#Store to the local
write_csv(CA_counties,"./CA_counties_job.csv")

#Function to get table of a url
Get_table <- function(url){
    kw <- read_html(url)
    c <- html_nodes(kw, css = "table")
    html_table(c, head = TRUE,fill = TRUE)[[1]]
}

#Call the function and get the table recursively
All_city_job <- lapply(unique(CA_counties$Link), Get_table)
All_city_job <- merge_recurse(All_city_job)
All_city_job <- All_city_job %>% 
    drop_na()

#Switch the rows and columns
All_city_job2 <- data.frame(t(All_city_job[-1]))
colnames(All_city_job2) <- All_city_job[ , 1]

#Rename the columns
All_city_job2 <- cbind(rownames(All_city_job2), All_city_job2)
rownames(All_city_job2) <- NULL
colnames(All_city_job2) <- c("Counties","IncomePerCap","HouseholdIncome","UnemploymentRate","RecentJobGrowth","FutureJobGrowth")

#Store to the local
write_csv(All_city_job2,"./All_city_job.csv")

#Do the same work for Cost of living part

#Add cost_url
Cost_url <- "https://www.bestplaces.net/cost_of_living"
Cost_Link <- CA_counties$Link %>% 
    str_replace_all("https://www.bestplaces.net/jobs",Cost_url)
CA_counties$Link=Cost_Link

#Store to the local
write_csv(CA_counties,"./CA_counties_cost.csv")

#Get table
Get_table2 <- function(url){
    kw <- read_html(url)
    c <- html_nodes(kw, css = "table")
    html_table(c, head = TRUE,fill = TRUE)[[2]]
}

#Call the function and get the table recursively
All_city_cost <- lapply(unique(CA_counties$Link), Get_table2)
All_city_cost <- merge_recurse(All_city_cost)

#Switch the rows and columns
All_city_cost2 <- data.frame(t(All_city_cost[-1]))
colnames(All_city_cost2) <- All_city_cost[ , 1]

#Rename the columns
All_city_cost2 <- cbind(rownames(All_city_cost2), All_city_cost2)
rownames(All_city_cost2) <- NULL
colnames(All_city_cost2) <- c("Counties","Overall","Grocery","Health","Housing","Utilities","Transportation","Miscellaneous")

#Store to the local
write_csv(All_city_cost2,"./All_city_cost.csv")