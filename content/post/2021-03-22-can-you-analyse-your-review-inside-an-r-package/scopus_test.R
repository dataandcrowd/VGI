options(width=100)
library(bibliometrix)
library(tidyverse)

M <- convert2df(file = "scopus2.bib", dbsource = "scopus", format = "bibtex")
results <- biblioAnalysis(M, sep = ";")
S <- summary(object = results, k = 10, pause = FALSE)

plot(x = results, k = 10, pause = FALSE)

#M$CR[1]
CR <- citations(M, field = "article", sep = ";")
cbind(CR$Cited[1:10])

CR <- localCitations(M, sep = ";")
CR$Authors[1:10,]

CR$Papers[1:10,]


DF <- dominance(results, k = 10)
DF


topAU <- authorProdOverTime(M, k = 10, graph = TRUE)
head(topAU$dfAU)


M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
NetMatrix <- biblioNetwork(M, analysis = "collaboration", network = "countries", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, n = dim(NetMatrix)[1], Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE,labelsize=0.7,cluster="none")


#######
NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")

# Plot the network
net=networkPlot(NetMatrix, normalize="association", weighted=T, n = 30, Title = "Keyword Co-occurrences", type = "fruchterman", size=T,edgesize = 5,labelsize=0.7)


CS <- conceptualStructure(M,field="ID", method="CA", minDegree=4, clust=5, stemming=FALSE, labelsize=10, documents=10)
