# packages used in this walkthrough
library(sysrevdata)
library(tidyverse)
library(leaflet)

# this avoids tidyverse conflicts with the base function filter
conflicted::conflict_prefer("filter", "dplyr")

path = "content/post/2021-04-01-database-search-part-2/"

vgi <- read_csv(paste0(path,"PoPCites.csv"))

