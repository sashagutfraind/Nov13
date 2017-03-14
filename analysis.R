#'
#' Analysis of data
#' 
list.of.packages <- c('igraph', 'networkD3', 'RNeo4j', 'lattice')
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages, require, character.only = TRUE)

baseDir <- '~/repos/Nov13'

kblDB = tryCatch(startGraph("http://localhost:7474/db/data/", username="neo4j", password="1"), error = function(e){NULL})  
if(is.null(kblDB)) {
  print('Database error!')
} else {
  print("DATABASE statistics:")
  query = '  
  MATCH (n)
  RETURN count(n)'
  netStatsN = cypher(kblDB, query)
  print(netStatsN)
  
  query = '  
  MATCH ()-[r]->()
  RETURN count(r)'
  netStatsE = cypher(kblDB, query)
  print(netStatsE)
  query = '  
MATCH (p:Person)-[:CITIZEN_OF]->(c:Country)
  WHERE p.name IN {terrorMembers}
  RETURN p.name, c.name'
  nameCitizenship = cypher(kblDB, query, terrorMembers=terrorMembers)
  print((table(nameCitizenship$c.name)))
  
  query = '  
MATCH (p:Person)
  WHERE p.name IN {terrorMembers}
  RETURN p.name, p.age, p.gender, p.citizenship'
  nameAgeGenderCitizenship = cypher(kblDB, query, terrorMembers=terrorMembers)
  
  print(mean(nameAgeGenderCitizenship$p.age, na.rm=T))
  print(summary(nameAgeGenderCitizenship$p.age))
  
  print(table(nameAgeGenderCitizenship$p.gender))
  print(prop.table(table(nameAgeGenderCitizenship$p.gender)))
  
  print((table(nameAgeGenderCitizenship$p.citizenship)))
  print(prop.table(table(nameAgeGenderCitizenship$p.citizenship)))
}

systemName <- Sys.info()['sysname']


print("Social network statistics:")

#terrorNetworkUndirected <- read.csv(file.path(baseDir, "/nov13_terrorNetwork.csv"))
TN <- read_graph(file.path(baseDir, "ise_terrorNetwork.gml"), format="gml")
terrorMembers <- get.vertex.attribute(TN, "name")

print(summary(TN))

#NetworkD3: nice plot
terrorNetworkUndirected <- get.data.frame(TN, what="edges")
networkJS <- simpleNetwork(terrorNetworkUndirected)
#wishlist: add nodes which might be missing from terrorNetworkUndirected
show(networkJS)
saveNetwork(networkJS, file.path(baseDir, "ise_interactive_network.html"), selfcontained=TRUE)


degrees <- degree(TN, mode="out")
degrees <- sort(degrees)
bc<-barchart(degrees, col="blue")
print(bc)
if(systemName == 'macOS') {
  quartz.save(file.path(baseDir, "TN_degrees.tiff"), dpi=300, width=9, height=16)
} else{
  tiff(file.path(baseDir, "TN_degrees.tiff"))
}

betweennessTN <- betweenness(TN, directed=FALSE, normalized=T)
betweennessTN <- sort(betweennessTN)
bc<-barchart(betweennessTN, col="blue", xlab="betweenness")
print(bc)
if(systemName == 'macOS') {
  quartz.save(file.path(baseDir, "TN_betweenness.tiff"), dpi=300, width=9, height=16)
} else{
  tiff(file.path(baseDir, "TN_betweenness.tiff"))
}



