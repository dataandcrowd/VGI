Sys.setlocale("LC_ALL","English")

library(litsearchr)
library(synthesisr)
library(tidyverse)


path = "content/post/2021-04-01-database-search-part-2/"

bibfiles <- list.files(
  path = path,
  pattern = ".bib",
  full.names = TRUE)


naive_import <- read_refs(
  filename = bibfiles,
  return_df = TRUE)

#
keywords <- read_csv("content/post/2021-04-01-database-search-part-2/vgi1.csv")

naive_import %>% 
  bind_cols(keywords %>% 
              select(Keywords, DOI) %>% 
              select(-doi)) -> naive_import

#
nrow(naive_import)
naive_results <- remove_duplicates(naive_import, field = "title", method = "string_osa")


#
raked_keywords <-
  litsearchr::extract_terms(
    text = paste(naive_results$title, naive_results$abstract),
    method = "fakerake",
    min_freq = 2,
    ngrams = TRUE,
    min_n = 2,
    language = "English"
  )

head(raked_keywords, 20)

raked_keywords[grep("volunteered geographic information", raked_keywords)]


tagged_keywords <-
  litsearchr::extract_terms(
    keywords = naive_results$Keywords,
    method = "tagged",
    min_freq = 2,
    ngrams = TRUE,
    min_n = 2,
    language = "English"
  )

head(tagged_keywords, 20)

#######################################
#--Assessing How Important Terms Are--#
#######################################
library(igraph)

## 1
naive_dfm <- create_dfm(
  elements = my_text,
  features = raked_keywords
)

naive_graph <- create_network(
  search_dfm = as.matrix(naive_dfm),
  min_studies = 2,
  min_occ = 2
)

strengths <- sort(strength(naive_graph), decreasing=TRUE)

head(strengths, 10)
plot(strengths, type="l", las=1)


## 2

cutoff <- find_cutoff(
  naive_graph,
  method = "cumulative",
  percent = .8,
  imp_method = "strength"
)
print(cutoff)


reduced_graph <- reduce_graph(naive_graph, cutoff_strength = cutoff)
plot(reduced_graph)

search_terms <- get_keywords(reduced_graph) %>% 
  remove_redundancies(., closure = "left")
search_terms


write.csv(search_terms, file=paste0(path,"./suggested_keywords.csv"), row.names = F)

## 3
my_text1 <- remove_redundancies(raked_keywords, closure = "left")

naive_dfm3 <- create_dfm(
  elements = my_text,
  features = my_text1
)


naive_graph3 <- create_network(
  search_dfm = as.matrix(naive_dfm3),
  min_studies = 8,
  min_occ = 2
)

plot(naive_graph3)


######################################
library(ggraph)

g <- create_network(naive_dfm, min_studies=3)

ggraph(g, layout="stress") +
  coord_fixed() +
  expand_limits(x=c(-3, 3)) +
  geom_edge_link(aes(alpha=weight)) +
  geom_node_point(shape="circle filled", fill="white") +
  geom_node_text(aes(label=name), hjust="outward", check_overlap=TRUE) +
  guides(edge_alpha=FALSE)

