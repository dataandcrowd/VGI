library(tidyverse)
library(bibliometrix)
library(janitor)

file <- "content/post/2021-03-22-can-you-analyse-your-review-inside-an-r-package/savedrecs.bib"
M <- convert2df(file, dbsource = "wos", format = "bibtex")
head(M["TC"])
