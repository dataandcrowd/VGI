library(tidyverse)
library(bibliometrix)
library(janitor)
#library(rscopus)


file <- "content/post/2021-03-22-can-you-analyse-your-review-inside-an-r-package/wos.bib"
M <- convert2df(file, dbsource = "wos", format = "bibtex")
head(M["TC"])


results <- biblioAnalysis(M, sep = ";")
S <- summary(object = results, k = 10, pause = FALSE)
plot(x = results, k = 10, pause = FALSE)

