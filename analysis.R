library(igraph)
library(networkD3)
library(RNeo4j)
library(lattice)
kblDB = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  

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

print("Operators network statistics:")

#terrorNetworkUndirected <- read.csv("~/nov13/nov13_terrorNetwork.csv")
TN <- read_graph("~/nov13/ise_terrorNetwork.gml", format="gml")
terrorMembers <- get.vertex.attribute(TN, "name")

print(summary(TN))

#NetworkD3: nice plot
terrorNetworkUndirected <- get.data.frame(TN, what="edges")
networkJS <- simpleNetwork(terrorNetworkUndirected)
#wishlist: add nodes which might be missing from terrorNetworkUndirected
show(networkJS)
saveNetwork(networkJS, "~/nov13/ise_interactive_network.html", selfcontained=TRUE)

query = '  
MATCH (p:Person)-[:CITIZEN_OF]->(c:Country)
WHERE p.name IN {terrorMembers}
RETURN p.name, c.name'
nameCitizenship = cypher(kblDB, query, terrorMembers=terrorMembers)
print((table(nameCitizenship$c.name)))


degrees <- degree(TN, mode="out")
degrees <- sort(degrees)
bc<-barchart(degrees, col="blue")
print(bc)
quartz.save(paste0("~/nov13/TN_degrees.tiff"), dpi=300, width=9, height=16)

betweennessTN <- betweenness(TN, directed=FALSE, normalized=T)
betweennessTN <- sort(betweennessTN)
bc<-barchart(betweennessTN, col="blue", xlab="betweenness")
print(bc)
quartz.save(paste0("~/nov13/TN_betweenness.tiff"), dpi=300, width=9, height=16)


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

