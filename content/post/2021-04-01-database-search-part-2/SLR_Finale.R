#https://luketudge.github.io/litsearchr-tutorial/litsearchr_tutorial.html
# Tutorial
library(tidyverse)
library(litsearchr)
library(synthesisr)
library(magrittr)
library(bib2df)
#library(bibliometrix)


dir()

#bibfiles <- list.files(
#  path = getwd(),
#  pattern = ".bib",
#  full.names = TRUE)

#import <- read_refs(
#  filename = bibfiles,
#  return_df = TRUE)


#nrow(import)
#results <- remove_duplicates(import, field = "title", method = "string_osa")
#results$type <- tolower(results$type)

#results %<>% arrange(desc(n_duplicates))

load('slr.rda')

raked_keywords <-
  litsearchr::extract_terms(
    text = paste(results$title, results$abstract),
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
    keywords = results$keywords,
    method = "tagged",
    min_freq = 2,
    ngrams = TRUE,
    min_n = 3,
    language = "English"
  )

tail(tagged_keywords, 20)

sum(is.na(results[, "keywords"])) # How many articles have keywords missing?

############################
extract_terms(keywords=results[, "keywords"], method="tagged")

keywords <- extract_terms(keywords=results[, "keywords"], method="tagged", min_n=1)
keywords

all_stopwords <- get_stopwords("English")

title_terms <- extract_terms(
  text=results[, "title"],
  method="fakerake",
  min_freq=3, min_n=2,
  stopwords=all_stopwords
)

terms <- unique(c(keywords, title_terms))

docs <- results[, "title"]

dfm <- create_dfm(elements=docs, features=terms)
dfm[1:3, 1:4]
g <- create_network(dfm, min_studies=2) # min_studies default was 3

################################
library(ggraph)

ggraph(g, layout="stress") +
  coord_fixed() +
  expand_limits(x=c(-3, 3)) +
  geom_edge_link(aes(alpha=weight)) +
  geom_node_point(shape="circle filled", fill="white") +
  geom_node_text(aes(label=name), hjust="outward", check_overlap=TRUE) +
  guides(edge_alpha=FALSE)


strengths <- igraph::strength(g)

term_strengths <- data.frame(term=names(strengths), strength=strengths, row.names=NULL) %>%
  mutate(rank=rank(strength, ties.method="min")) %>%
  arrange(strength)

term_strengths %>% arrange(desc(strength))

################################

results %>% 
  filter(n_duplicates >= 2) -> finale


################################

library(sysrevdata)
library(leaflet)
library(tidygeocoder)

finale %<>% 
  select(author, title, journal, year, note, affiliation, author_keywords)

#affiliation <- str_split(finale$affiliation, "; ") %>% flatten_chr()
finale %>% 
  select(author, title, affiliation) -> authored

authored %<>% 
  mutate(affiliation = str_split(.$affiliation, "; ")) %>% 
  group_by(author, title)

authored %>% unnest(affiliation) -> authored_aff

# Attempt 1
address <- geo(address = authored_aff$affiliation, method = 'osm', lat = latitude, long = longitude) %>%
  mutate(address = case_when(!is.na(latitude) ~ .$address,
                             is.na(latitude) ~ gsub("^.*?\\, ","", .$address)
                             ))
# Attempt 2
address <- geo(address = address$address, method = 'osm', lat = latitude, long = longitude) %>%
  mutate(address = case_when(!is.na(latitude) ~ .$address,
                             is.na(latitude) ~ gsub("^.*?\\, ","", .$address)
  ))

# Attempt 3
address <- geo(address = address$address, method = 'osm', lat = latitude, long = longitude) %>%
  mutate(address = case_when(!is.na(latitude) ~ .$address,
                             is.na(latitude) ~ gsub("^.*?\\, ","", .$address)
  ))

# Attempt 4
address <- geo(address = address$address, method = 'osm', lat = latitude, long = longitude) %>%
  mutate(address = case_when(!is.na(latitude) ~ .$address,
                             is.na(latitude) ~ gsub("^.*?\\, ","", .$address)
  ))


authored_final <- bind_cols(authored_aff$author, authored_aff$title, address) %>% 
  rename(author = `...1`, title = `...2`)


authored_final$label <- with(authored_final, paste(
  "<p> <b>", author, "</b> </br>",
  "Title:", title,
  "</p>"))



##########
authored_final %>% 
  mutate(lat=as.numeric(latitude)) %>% 
  mutate(lng=as.numeric(longitude)) %>% 
  #mutate(tag = author) %>% 
  leaflet(width = "100%") %>% 
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=~lng, lat=~lat, 
             popup=~label, 
             clusterOptions = markerClusterOptions())

# https://estech.shinyapps.io/eviatlas/


##########
df2bib(results)


