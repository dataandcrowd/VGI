library(jsonlite)

filenames <- list.files("Contributors_raw/", pattern="*.json", full.names=TRUE) # this should give you a character vector, with each file name represented by an entry


#############
notes <- data.frame()
for(k in 1:30){
  temp <- jsonlite::fromJSON(filenames[k])
  df <- temp$notes[[3]] == 0
  notes <- rbind(notes,df)
}
notes[notes==FALSE]
which(notes$FALSE. == T)

filenames[21]



discussions <- data.frame()
for(k in 1:30){
  temp <- jsonlite::fromJSON(filenames[k])
  df <- temp$discussion[[3]] == 0
  discussions <- rbind(discussions,df)
}
discussions[discussions==FALSE]
which(discussions$FALSE. == T)


############
#for(x in 1:4){
#  print(temp$notes[[x]] == 0)
#}

#for(y in 1:4){
#  print(temp$discussion[[y]] == 0)
#}

###########

for(i in 1:30){
  temp <- jsonlite::fromJSON(filenames[i])

  for(i in 1:4){
    #if(temp$notes[[i]] == 0){
    #  temp$notes[[i]] <- "0"
    #} 
    
    
    if(temp$discussion[[i]] == 0){
      temp$discussion[[i]] <- "0"
    }
  }
  
  jsonlite::toJSON(filenames[i])
  
  
}



temp <- jsonlite::fromJSON(filenames[3])
temp$notes



