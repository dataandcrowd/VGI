library(tidyverse)
library(bibliometrix)
library(janitor)
#library(rscopus)


file <- "content/post/2021-03-22-can-you-analyse-your-review-inside-an-r-package/wos.bib"
M <- convert2df(file, dbsource = "wos", format = "bibtex")
head(M["TC"])


results <- biblioAnalysis(M, sep = ";")
S <- summary(object = results, k = 10, pause = FALSE)
plot(x = results, k = 10, pause = F)


S[2]

###############
#--Citations--#
###############

#M$CR[1]

article <- citations(M, field = "article", sep = ";")
cbind(article$Cited[1:10])

author <- citations(M, field = "author", sep = ";")
cbind(author$Cited[1:10])


#####################
#--Local Citations--#
#####################

localc <- localCitations(M, sep = ";")
localc$Authors[1:10,]

localc$Papers[1:10,]



#######################
#--Dominance Ranking--#
#######################
# Kumar, S., & Kumar, S. (2008)

DF <- dominance(results, k = 10)
DF

######################
#--Authors’ h-index--#
######################

indices <- Hindex(M, field = "author", elements="HAWORTH B", sep = ";", years = 10)
indices$H

indices$CitationList


authors=gsub(","," ",names(results$Authors)[1:10])
indices <- Hindex(M, field = "author", elements=authors, sep = ";", years = 50)
indices$H


#########################################
#--Top Author's Productivity over Time--#
#########################################
topAU <- authorProdOverTime(M, k = 10, graph = TRUE)

head(topAU$dfAU)


########################################
#--Lotka’s Law coefficient estimation--#
########################################
L <- lotka(results)

# Author Productivity. Empirical Distribution
L$AuthorProd

# Beta coefficient estimate
L$Beta

# Constant
L$C

# Goodness of fit
L$R2


# P-value of K-S two sample test
L$p.value

# Observed distribution
Observed <- L$AuthorProd[,3]

# Theoretical distribution with Beta = 2
Theoretical <- 10^(log10(L$C)-2*log10(L$AuthorProd[,1]))

plot(L$AuthorProd[,1],Theoretical,type="l",col="red",ylim=c(0, 1), xlab="Articles",ylab="Freq. of Authors",main="Scientific Productivity")
lines(L$AuthorProd[,1],Observed,col="blue")
legend(x="topright",c("Theoretical (B=2)","Observed"),col=c("red","blue"),lty = c(1,1,1),cex=0.6,bty="n")



##################################
#-Bibliographic network matrices-#
##################################

# Bipartite networks
A <- cocMatrix(M, Field = "SO", sep = ";")
sort(Matrix::colSums(A), decreasing = TRUE)[1:5] # Get a list of top Journals

# Citation Network
A <- cocMatrix(M, Field = "CR", sep = ".  ")
sort(Matrix::colSums(A), decreasing = TRUE)[1:5]


A <- cocMatrix(M, Field = "AU", sep = ";")
sort(Matrix::colSums(A), decreasing = TRUE)[1:5]


# Bibliographic coupling
NetMatrix <- biblioNetwork(M, analysis = "coupling", network = "references", sep = ".  ")

NetMatrix <- biblioNetwork(M, analysis = "coupling", network = "authors", sep = ";")
net=networkPlot(NetMatrix,  normalize = "salton", weighted=NULL, n = 100, Title = "Authors' Coupling", type = "fruchterman", size=5,size.cex=T,remove.multiple=TRUE,labelsize=0.8,label.n=10,label.cex=F)

# Descriptive analysis of network graph characteristics
NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")
netstat <- networkStat(NetMatrix)
summary(netstat, k=10)


# Visualizing bibliographic networks
# Create a country collaboration network
M1 <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
NetMatrix <- biblioNetwork(M1, analysis = "collaboration", network = "countries", sep = ";")

# Plot the network
net <- networkPlot(NetMatrix, 
                   n = dim(NetMatrix)[1], 
                   Title = "Country Collaboration", 
                   type = "circle", 
                   size=TRUE, 
                   remove.multiple=FALSE,
                   labelsize=1,
                   cluster="none")


# Keyword Occurrences
# Create keyword co-occurrences network
NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")

# Plot the network
net <- networkPlot(NetMatrix, 
                   normalize="association", 
                   weighted=T, 
                   n = 30, 
                   Title = "Keyword Co-occurrences", 
                   type = "fruchterman", 
                   size=T,
                   edgesize = 5,
                   labelsize= 1)


####################################################################
#--The Intellectual Structure of the field - Co-citation Analysis--#
####################################################################

#--Article (References) co-citation analysis--#
NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ";")
net <- networkPlot(NetMatrix, 
                   n = 20, 
                   Title = "Co-Citation Network", 
                   type = "fruchterman", 
                   size.cex=TRUE, 
                   size= 10, 
                   remove.multiple=FALSE, 
                   labelsize= 1.4,
                   edgesize = 7, 
                   edges.min= 3)




# Article (References) co-citation analysis
#M=metaTagExtraction(M,"CR_SO",sep=";")
#NetMatrix <- biblioNetwork(M, analysis = "co-citation", network = "sources", sep = ";")
#net=networkPlot(NetMatrix, n = 30, Title = "Co-Citation Network", type = "auto", size.cex=TRUE, size=5, remove.multiple=FALSE, labelsize=0.7,edgesize = 10, edges.min=5)






NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")
net <- networkPlot(NetMatrix, 
                   normalize="association", 
                   n = 30, 
                   Title = "Keyword Co-occurrences", 
                   type = "fruchterman", 
                   size.cex = T, 
                   size = 20, 
                   remove.multiple = T, 
                   edgesize = 10, 
                   edges.min = 5,
                   labelsize = 1.2,
                   label.cex = F,
                   label.n = 15,
                   #label.color = "black",
                   alpha = 1)




##########################
#--Conceptual Structure--#
##########################

#CS <- conceptualStructure(M,
#                          field="ID", 
#                          method="CA", 
#                          minDegree=4, 
#                          clust=5, 
#                          stemming=FALSE, 
#                          labelsize=10, 
#                          documents=10)


#######################################
#- Historial Direct Citation Network--#
#######################################
#options(width=130)
#histResults <- histNetwork(M, min.citations = 1, sep = ";")
#net <- histPlot(histResults, n=15, size = 10, labelsize=5) # Plot a historical co-citation network


