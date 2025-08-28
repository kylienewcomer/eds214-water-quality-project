rm(list = ls())
library(tidyverse)
library(here)
library(janitor)
library(forecast)
library(zoo)
library(lubridate)
library(slider)

moving_average <- function(df, focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  for(i in nrow(df)){
    focal_date <- df[i, 2]
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc, na.rm = TRUE)
  
  return(result)
  }
}

conc_subset <- data.frame(
  stringsAsFactors = FALSE,
  sample_id = c("Q1","Q1","Q1","Q1","Q1",
                "Q1","Q1","Q1","Q1","Q1"),
  sample_date = c("1986-05-20","1986-05-20",
                  "1986-05-20","1986-05-20","1986-05-20","1986-05-27",
                  "1986-05-27","1986-05-27","1986-05-27","1986-05-27"),
  year = c("1986","1986","1986","1986",
           "1986","1986","1986","1986","1986","1986"),
  month = c("05","05","05","05","05",
            "05","05","05","05","05"),
  day = c("20","20","20","20","20",
          "27","27","27","27","27"),
  day_of_year = c(140, 140, 140, 140, 140, 147, 147, 147, 147, 147),
  no_day = c(140, 140, 140, 140, 140, 147, 147, 147, 147, 147),
  nutrient = c("no3_n","nh4_n","mg","ca",
               "k","no3_n","nh4_n","mg","ca","k"),
  concentration = c(118, NA, 3.04, 4.26, 0.81, 109, NA, 3.13, 3.17, 0.82)
)




conc_subset$sample_date <- as.Date(conc_subset$sample_date)

conc_mean <- conc_subset %>% 
  mutate(calc_rolling = sapply(x = sample_date,
                              FUN = moving_average(df = conc_subset,
                                              dates = as.Date(sample_date),
                                              conc = concentration,
                                              win_size_wks = 9)
  )) %>% 
  ungroup()
