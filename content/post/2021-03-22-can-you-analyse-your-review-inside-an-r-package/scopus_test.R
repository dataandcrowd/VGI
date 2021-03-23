options(width=100)
library(bibliometrix)
library(tidyverse)

file <- "content/post/2021-03-22-can-you-analyse-your-review-inside-an-r-package/scopus2.bib"
M <- convert2df(file = file, dbsource = "scopus", format = "bibtex")
results <- biblioAnalysis(M, sep = ";")
S <- summary(object = results, k = 10, pause = FALSE)

plot(x = results, k = 10, pause = FALSE)

#M$CR[1]
CR <- citations(M, field = "article", sep = ";")
cbind(CR$Cited[1:10]) %>% View()

local <- localCitations(M, sep = ";")
local$Authors[1:10,]
local$Papers[1:10,]

local$Papers[1:20,] %>% View()


DF <- dominance(results, k = 10)
DF %>% View()

################

topAU <- authorProdOverTime(M, k = 10, graph = TRUE)
head(topAU$dfAU)

##################

M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")

NetMatrix <- biblioNetwork(M, 
                           analysis = "collaboration", 
                           network = "countries", 
                           sep = ";")

# Plot the network
net <- networkPlot(NetMatrix, 
                   n = dim(NetMatrix)[1], 
                   Title = "Country Collaboration", 
                   type = "fruchterman", 
                   size=TRUE, 
                   remove.multiple=FALSE,
                   labelsize=0.7,
                   cluster="none")

#########################
histResults <- histNetwork(M, 
                           min.citations = quantile(M$TC,0.75), 
                           sep = ";")

#options(width = 130)
net <- histPlot(histResults, 
                n=20,
                size = 5, 
                labelsize = 4)


################
NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")

# Plot the network
net <- networkPlot(NetMatrix, 
                   normalize="association", 
                   n = 30, 
                   Title = "Keyword Co-occurrences",
                   type = "fruchterman", 
                   size.cex=TRUE, 
                   size=20, 
                   remove.multiple=F, 
                   edgesize = 10, 
                   labelsize=3,
                   label.cex=TRUE,
                   label.n=10,
                   edges.min=2)


CS <- conceptualStructure(M,
                          field="ID", 
                          method="CA", 
                          minDegree=4, 
                          clust=5, 
                          stemming=FALSE, 
                          labelsize=10, 
                          documents=10)




NetMatrix <- biblioNetwork(M, analysis = "collaboration",  network = "universities", sep = ";")
net=networkPlot(NetMatrix,  n = 30, Title = "Edu collaboration",type = "auto", size=10,size.cex=T,edgesize = 3,labelsize=0.6)



M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
NetMatrix <- biblioNetwork(M, analysis = "collaboration",  network = "countries", sep = ";")
net=networkPlot(NetMatrix,  n = dim(NetMatrix)[1], Title = "Country collaboration",type = "sphere", size=10,size.cex=T,edgesize = 1,labelsize=0.6, cluster="none")

netstat <- networkStat(NetMatrix)
summary(netstat,k=15)






