library(tidyverse)
library(here)
library(janitor)
library(forecast)
library(zoo)
library(lubridate)

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
  mutate(days_before = no_day - 31,
         days_after = no_day +31)



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
conc_long %>% mutate(
  start_date = sample_date - day(31),
       end_date = sample_date + day(31),
       average = seq(start_date, end_date),
average_invt = int_diff(average))

mean(sample_date[i] %within% average_invt)



means <- function(concentration){rollmean(concentration, 31)}

means(conc_av, concetration = concentration, k = no_day)



range <- day(1)

conc <- conc_long %>%
  group_by(sample_id, nutrient, sample_date) %>%
  mutate(interval(sample_date - range, sample_date + range))
    
    Npoints = 1:n() - interval(sample_date - range, sample_date + range)),
         mean = rollapplyr(concentration, width = 9, 
                           FUN = mean(concentration), partial = TRUE, 
                           fill = NA)) %>%
  ungroup

w <- 3 
data %>%
  group_by(Group) %>%
  mutate(Npoints = 1:n() - interval(Date - w, Date + )),
         Mean3 = rollapplyr(Value, Npoints, mean, partial = TRUE, fill = NA)) %>%
  ungroup

#sapply(c("right","center","left"),
       #function(x)zoo::rollmean(test,7,align = x, na.pad = TRUE))


#week_class(day = 308)

