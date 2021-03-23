library(tidyverse)
library(bibliometrix)
library(janitor)
# Year Published = ( 2000 -  ) Publication Type = ( journal article  , book chapter  , book  , conference proceedings  , conference proceedings article  ) External ID Type = ( Microsoft Academic  , Crossref  ) Has Abstract  Cited By Scholarly Works  Open Access 



lens <- read_csv("content/post/2021-03-22-can-you-analyse-your-review-inside-an-r-package/lens-export.csv") %>% clean_names()

lens %>% 
  arrange(desc(citing_works_count)) %>% 
  slice_head(n=20)-> a

lens %>% 
  group_by(source_country) %>% 
  summarise(n = n())



