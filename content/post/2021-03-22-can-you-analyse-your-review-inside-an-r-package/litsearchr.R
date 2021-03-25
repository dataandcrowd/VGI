library(litsearchr)
library(synthesisr)

bibfiles <- list.files(
  path = "content/post/2021-03-22-can-you-analyse-your-review-inside-an-r-package/",
  pattern = ".bib",
  full.names = TRUE)


naive_import <- read_refs(
  filename = bibfiles,
  return_df = TRUE)

nrow(naive_import)
naive_results <- remove_duplicates(naive_import, field = "title", method = "string_osa")


rakedkeywords <-
  litsearchr::extract_terms(
    text = paste(naive_results$title, naive_results$abstract),
    method = "fakerake",
    min_freq = 2,
    ngrams = TRUE,
    min_n = 2,
    language = "English"
  )
#> Loading required namespace: stopwords

taggedkeywords <-
  litsearchr::extract_terms(
    keywords = naive_results$keywords,
    method = "tagged",
    min_freq = 2,
    ngrams = TRUE,
    min_n = 2,
    language = "English"
  )



#############

all_keywords <- unique(append(taggedkeywords, rakedkeywords))

naivedfm <-
  litsearchr::create_dfm(
    elements = paste(naive_results$title, naive_results$abstract),
    features = all_keywords
  )

naivegraph <-
  litsearchr::create_network(
    search_dfm = naivedfm,
    min_studies = 2,
    min_occ = 2
  )


cutoff <-
  litsearchr::find_cutoff(
    naivegraph,
    method = "cumulative",
    percent = .80,
    imp_method = "strength"
  )

reducedgraph <-
  litsearchr::reduce_graph(naivegraph, cutoff_strength = cutoff[1])

searchterms <- litsearchr::get_keywords(reducedgraph)

head(searchterms, 20)

# https://elizagrames.github.io/litsearchr/litsearchr_vignette.html