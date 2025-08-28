rm(list = ls())

# Loading in packages
library(tidyverse)
library(here)
library(janitor)
library(forecast)
library(zoo)
library(lubridate)
library(slider)



# Reading in data

bq1 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca1-Bisley.csv"))

bq2 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca2-Bisley.csv"))

bq3 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca2-Bisley.csv"))

prm <- read_csv(here("data", "knb-lter-luq.20.4923064", "RioMameyesPuenteRoto.csv"))

# Combining data
bq_12 <- rbind(bq1, bq2)

bq <- rbind(bq_12, bq3)

all <- rbind(bq, prm)

#cleaning

clean_conc <- all %>% 
  
  clean_names() %>% 
  
  select(sample_id, sample_date, no3_n, nh4_n, mg, ca, k) %>% 
  
  mutate(day_of_year = lubridate::yday(sample_date)) %>% 

  
  separate(col = sample_date, 
           into = c("year", "month", "day"), sep = "-", remove = FALSE) %>% 
  
  filter(year <= 1995) %>% 
  
  #want to add a column of day relative to every day in 
  mutate(no_day = (as.numeric(year)-1986)*365 + day_of_year)


conc_long <- clean_conc %>% 
  #changing data format to better use in ggplot later
    pivot_longer("no3_n":"k", names_to = "nutrient",
                 values_to = "concentration") %>% 


#practicing means
conc_av <- conc_long %>% 
  group_by(sample_id, nutrient, year) %>% 
  summarize(ave = mean(concentration, na.rm = TRUE))

#plotting mean
ggplot(conc_av, aes(year, ave)) +
  geom_point(aes(color = sample_id)) +
  facet_wrap(~nutrient, scales = "free")



conc_long %>% mutate(
  start_date = sample_date - day(31),
       end_date = sample_date + day(31),
       average = seq(start_date, end_date),
average_invt = int_diff(average))

mean(sample_date[i] %within% average_invt)



means <- function(concentration){rollmean(concentration, 31)}

means(conc_av, concetration = concentration, k = no_day)



range <- day(1)
# trash

#conc <- conc_long %>%
  #group_by(sample_id, nutrient, sample_date, no_day) %>%
  
 # mutate(interval(sample_date - range, sample_date + range))
    
   # Npoints = 1:n() - interval(sample_date - range, sample_date + range)),
        # mean = rollapplyr(concentration, width = 9, 
                          # FUN = mean(concentration), partial = TRUE, 
                           #fill = NA) %>%
 # ungroup
         
conc_subset <- conc_long %>% 
  slice_head(n = 10)



conc <- conc_subset %>%
  group_by(sample_id, nutrient, sample_date, no_day, concentration) %>% 
  mutate(rolling_conc = rollmean(concentration, 31))


  
  mutate(Npoints = 1:n() - interval(Date - w, Date + )),
         Mean3 = rollapplyr(Value, Npoints, mean, 
                            partial = TRUE, fill = NA)) %>%
  
  ungroup

conc_mean <- conc_subset %>%
  group_by(sample_id, nutrient) %>%
  mutate(roll_mean = slide_index_dbl(concentration, sample_date, 
                                     .f = mean,
                                      before = 31L, after = 31L, 
                                      complete = FALSE, na_rm = TRUE))

#sapply(c("right","center","left"),
       #function(x)zoo::rollmean(test,7,align = x, na.pad = TRUE))
for (i in seq_along(sample_date)){
  group_by()
  if(no_day >= days_before | no_day <= days_after){
    mean = mean
  }
  
  
}

ggplot(conc_mean, aes(sample_date, roll_mean)) +
  geom_point(aes(color = sample_id)) +
  facet_wrap(~nutrient, scales = "free")
  
#week_class(day = 308)
moving_average <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc, na.rm = TRUE)
  
  return(result)
}



conc_long %>% 
  group_by(sample_id, nutrient)
mutate(calc_rolling <- sapply(sample_date, moving_average,
  dates = sample_date,
  conc = concentration,
  win_size_wks = 9
)
)

