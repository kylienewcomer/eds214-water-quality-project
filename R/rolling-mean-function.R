library(tidyverse)
library(here)
library(janitor)
library(forecast)
library(zoo)
library(lubridate)
library(slider)



rolling_mean <- function(df){
  df %>%
  arrange(sample_date) %>% # need to sort in chronological order 
  group_by(sample_id, nutrient) %>% # create means for each nutrient at each site
  mutate(roll_mean = slide_index_dbl(concentration, sample_date, # use rolling mean function
                                     .f = mean, na_rm = TRUE,
                                     .before = 31.5, .after = 31.5, #31 days before and after for 9 week span
                                     complete = FALSE))
}