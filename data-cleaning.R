library(tidyverse)
library(here)
library(janitor)
library(forecast)
library(zoo)

rm(list = ls())

bq1 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca1-Bisley.csv"))

bq2 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca2-Bisley.csv"))

bq3 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca2-Bisley.csv"))

prm <- read_csv(here("data", "knb-lter-luq.20.4923064", "RioMameyesPuenteRoto.csv"))

bq_12 <- rbind(bq1, bq2)

bq <- rbind(bq_12, bq3)

all <- rbind(bq, prm)

clean_conc <- all %>% 
  clean_names() %>% 
  select(sample_id, sample_date, no3_n, nh4_n, mg, ca, k) %>% 
  mutate(day_of_year = lubridate::yday(sample_date)) %>% 
  separate(col = sample_date, 
           into = c("year", "month", "day"), sep = "-", remove = FALSE) %>% 
  mutate(no_day = (as.numeric(year)-1986)*365 + day_of_year)


conc_long <- clean_conc %>% 
    pivot_longer("no3_n":"k", names_to = "nutrient",
                 values_to = "concentration") %>% 
  mutate(days_before = no_day - 22,
         days_after = no_day +22)

if days_before >= 31
  & days_after <=


conc_av <- conc_long %>% 
  group_by(sample_id, nutrient, year) %>% 
  summarize(ave = mean(concentration, na.rm = TRUE))


ggplot(conc_av, aes(year, ave)) +
  geom_point(aes(color = sample_id)) +
  facet_wrap(~nutrient, scales = "free")



week_class <- function(day, n = n){
  for (i in nrow(conc_long)){
    group_by(group_id, day) %>% 
      weeks_before <- (day - 22)
      weeks_after <- (day + 22)
  }
}


TTR::SMA(conc_long, n = 31)

means <- function(concentration){rollmean(concentration, 31)}

means(conc_av, concetration = concentration, k = no_day)


sapply(c("right","center","left"),
       function(x)zoo::rollmean(test,7,align = x, na.pad = TRUE))


#week_class(day = 308)

