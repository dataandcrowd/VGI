library(visNetwork)

# Example
nodes <- data.frame(id = 1:4, 
                    shape = c("circle", "square"), 
                    label = LETTERS[1:4])
edges <- data.frame(from = c(2,4,3,3), to = c(1,2,4,2))

visNetwork(nodes, edges, width = "100%") %>% 
  visNodes(color = list(background = "lightblue", 
                        border = "darkblue",
                        highlight = "yellow"),
           shadow = list(enabled = TRUE, size = 10))  %>%
  visLayout(randomSeed = 12) # to have always the same network 


##--------- Global Configuration -----
nodes <- data.frame(id = 1:4)
edges <- data.frame(from = c(2,4,3,2), to = c(1,2,4,3))

visNetwork(nodes, edges, width = "100%") %>% 
  visEdges(shadow = TRUE,
           arrows =list(to = list(enabled = TRUE, scaleFactor = 2)),
           color = list(color = "lightblue", highlight = "red")) %>%
  visLayout(randomSeed = 12) # to have always the same network           


##------- Assigning Groups -----
nodes <- data.frame(id = 1:5, group = c(rep("A", 2), rep("B", 3)))
edges <- data.frame(from = c(2,5,3,3), to = c(1,2,4,2))

visNetwork(nodes, edges, width = "100%") %>% 
  # darkblue square with shadow for group "A"
  visGroups(groupname = "A", color = "darkblue", shape = "square", 
            shadow = list(enabled = TRUE)) %>% 
  # red triangle for group "B"
  visGroups(groupname = "B", color = "red", shape = "triangle")      


##------------
nb <- 10
nodes <- data.frame(id = 1:nb, label = paste("Label", 1:nb),
                    group = sample(LETTERS[1:3], nb, replace = TRUE), value = 1:nb,
                    title = paste0("<p>", 1:nb,"<br>Tooltip !</p>"), stringsAsFactors = FALSE)

edges <- data.frame(from = c(8,2,7,6,1,8,9,4,6,2),
                    to = c(3,7,2,7,9,1,5,3,2,9),
                    value = rnorm(nb, 10), label = paste("Edge", 1:nb),
                    title = paste0("<p>", 1:nb,"<br>Edge Tooltip !</p>"))

visNetwork(nodes, edges, height = "500px", width = "100%") %>% 
  visOptions(highlightNearest = TRUE) %>%
  visLayout(randomSeed = 123)


#---------------EDA-------------
library(googlesheets4)
vgi_nodes <- read_sheet("https://docs.google.com/spreadsheets/d/1YKOlbzdHXPljw3JWZXvSntIKXHV-HV_X5lbH_gHCNJ8/edit?usp=sharing") %>% 
  as.data.frame(id = id,
                shape = c("circle", "square"), 
                label = LETTERS[1:7])


vgi_edges <- data.frame(from = c(1,2,3,4,5,6,5), to = c(2,3,3,6,5,3,1))


visNetwork(vgi_nodes, vgi_edges, width = "100%")

