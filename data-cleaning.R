library(tidyverse)
library(here)

bq1 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca1-Bisley.csv"))

bq2 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca2-Bisley.csv"))

bq3 <- read_csv(here("data", "knb-lter-luq.20.4923064", "QuebradaCuenca2-Bisley.csv"))

prm <- read_csv(here("data", "knb-lter-luq.20.4923064", "RioMameyesPuenteRoto.csv"))
