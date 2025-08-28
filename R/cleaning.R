##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##-------------- THIS SCRIPT IS FOR DATA CLEANING AND WRANGLING-----------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


library(tidyverse)
library(here)
library(janitor)
library(forecast)
library(zoo)
library(lubridate)
library(slider)

# Reading in data
bq1 <- read_csv(here("data", 
                     "knb-lter-luq.20.4923064", 
                     "QuebradaCuenca1-Bisley.csv"))

bq2 <- read_csv(here("data", 
                     "knb-lter-luq.20.4923064", 
                     "QuebradaCuenca2-Bisley.csv"))

bq3 <- read_csv(here("data", 
                     "knb-lter-luq.20.4923064", 
                     "QuebradaCuenca3-Bisley.csv"))

prm <- read_csv(here("data", 
                     "knb-lter-luq.20.4923064", 
                     "RioMameyesPuenteRoto.csv"))

# Combining data
bq_12 <- rbind(bq1, bq2)

bq <- rbind(bq_12, bq3)

all <- rbind(bq, prm)

# cleaning for all
clean_conc <- all %>% 
  clean_names() %>% 
  
  # selecting only the columns I want
  select(sample_id, 
         sample_date, 
         no3_n, 
         nh4_n, 
         mg, 
         ca, 
         k)

#making the data long
conc_long <- clean_conc %>% 
  #creating a nutrient column to better use facet in ggplot later
  pivot_longer("no3_n":"k", names_to = "nutrient",
               values_to = "concentration")


saveRDS(conc_long, file = here::here("outputs", "conc_final.RDS"))
