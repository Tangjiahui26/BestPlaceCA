library(httr)
library(glue)
library(rvest)
library(stringr)
library(tidyverse)
library(reshape)
library(ggplot2)

#Read data
All_city_job2 <- read_csv("./All_city_job.csv")
All_city_cost2 <- read_csv("./All_city_cost.csv")

#Replace symbols
Counties <- All_city_job2$Counties %>% 
    str_replace_all(", California","")
All_city_job2$Counties = Counties
All_city_cost2$Counties = Counties

IncomePerCap <- All_city_job2$IncomePerCap %>% 
    str_replace_all("\\$","")
All_city_job2$IncomePerCap = IncomePerCap

HouseholdIncome <- All_city_job2$HouseholdIncome %>% 
    str_replace_all("\\$","")
All_city_job2$HouseholdIncome = HouseholdIncome

UnemploymentRate <- All_city_job2$UnemploymentRate %>% 
    str_replace_all("%","")
All_city_job2$UnemploymentRate = UnemploymentRate

RecentJobGrowth <- All_city_job2$RecentJobGrowth %>% 
    str_replace_all("%","")
All_city_job2$RecentJobGrowth = RecentJobGrowth

FutureJobGrowth <- All_city_job2$FutureJobGrowth %>% 
    str_replace_all("%","")
All_city_job2$FutureJobGrowth = FutureJobGrowth

#Restore to local
write_csv(All_city_job2,"./CA_job.csv")
write_csv(All_city_cost2,"./CA_cost.csv")

#read
All_city_job2 <- read_csv("./CA_job.csv")
All_city_cost2 <- read_csv("./CA_cost.csv")

#Make some plots
#delete the row of US
All_city_cost3 <- All_city_cost2 %>% 
    filter(Counties != "United States")

#PLot1: Overall Cost-of-Living in Californi
plot1 <- All_city_cost3 %>% 
    ggplot()+
    geom_point(aes(x=Counties,y=Overall,color=Overall))+
    geom_hline(yintercept = 100, linetype = "dashed", color ="green")+
    annotate("text", Counties[40], 100, vjust = -1, label = "US Average") +
    geom_hline(yintercept = sum(All_city_cost3$Overall)/nrow(All_city_cost3), linetype = "dashed", color ="red")+
    annotate("text", Counties[40], sum(All_city_cost3$Overall)/nrow(All_city_cost3), vjust = -1, label = "CA Average") +
    theme_bw()+
    labs(title = "Overall Cost-of-Living in California") +
    scale_x_discrete("Counties")+
    scale_y_continuous("Overall Cost-of-living")+
    theme(axis.text.x = element_text(size = 8,angle = 90),
          plot.title = element_text(hjust = 0.5))

#Save to local
ggsave("./Overall Cost-of-Living in California.png",plot1,device = "png", width = 10, 
       height = 7,dpi = 500)

#Plot2: UnemploymentRate v.s. FutureJobGrowthRate
All_city_job3 <-All_city_job2 %>% 
    filter(Counties != "United States")
plot2 <- All_city_job3 %>% 
    ggplot(aes(x= UnemploymentRate/100,y= FutureJobGrowth/100,color = Counties))+
    geom_point() +
    theme_bw()+
    labs(title = "UnemploymentRate v.s. FutureJobGrowthRate") +
    scale_x_continuous("UnemploymentRate")+
    scale_y_continuous("FutureJobGrowthRate")+
    theme(axis.text.x = element_text(size = 8),
          plot.title = element_text(hjust = 0.5))

#Save to local
ggsave("./UnemploymentRate v.s. FutureJobGrowthRate.png",plot2,device = "png", width = 10, 
       height = 7,dpi = 500)

#Plot3: IncomePerCap in Californi
plot3 <- All_city_job3 %>% 
    ggplot()+
    geom_point(aes(x=Counties,y=IncomePerCap,color=IncomePerCap))+
    geom_hline(yintercept = 28555, linetype = "dashed", color ="green")+
    annotate("text", Counties[40], 28555, vjust = -1, label = "US Average") +
    geom_hline(yintercept = sum(All_city_job3$IncomePerCap)/nrow(All_city_job3), linetype = "dashed", color ="red")+
    annotate("text", Counties[20], sum(All_city_job3$IncomePerCap)/nrow(All_city_job3), vjust = 1, label = "CA Average") +
    theme_bw()+
    labs(title = "IncomePerCap in California") +
    scale_x_discrete("Counties")+
    scale_y_continuous("IncomePerCap($)")+
    theme(axis.text.x = element_text(size = 8,angle = 90),
          plot.title = element_text(hjust = 0.5))
#Save to local
ggsave("./IncomePerCap in California.png",plot3,device = "png", width = 10, 
       height = 7,dpi = 500)