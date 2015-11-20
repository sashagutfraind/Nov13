library(igraph)
library(networkD3)
library(RNeo4j)
library(lattice)
nov13 = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  

query = '  
MATCH (n)
RETURN count(n)'
netStatsN = cypher(nov13, query)
print(netStatsN)

query = '  
MATCH ()-[r]->()
RETURN count(r)'
netStatsE = cypher(nov13, query)
print(netStatsE)

terrorNetworkUndirected <- read.csv("~/nov13/nov13_terrorNetwork.csv")
TN <- graph_from_edgelist(as.matrix(terrorNetworkUndirected))
TN <- as.undirected(TN, mode="collapse")
terrorMembers <- unique(c(terrorNetworkUndirected[["n1"]], terrorNetworkUndirected[["n2"]]))  #for safety

print(summary(TN))

#nice plot
networkJS <- simpleNetwork(terrorNetworkUndirected)
saveNetwork(networkJS, "~/nov13/nov13_interactive_network.html", selfcontained=TRUE)

query = '  
MATCH (p:Person)-[:CITIZEN_OF]->(c:Country)
WHERE p.name IN {terrorMembers}
RETURN p.name, c.name'
nameCitizenship = cypher(nov13, query, terrorMembers=terrorMembers)
print((table(nameCitizenship$c.name)))


degrees <- degree(TN, mode="out")
degrees <- sort(degrees)
barchart(degrees, col="blue")
quartz.save(paste0("~/nov13/TN_degrees.png"), dpi=300)


query = '  
MATCH (p:Person)
WHERE p.name IN {terrorMembers}
RETURN p.name, p.age, p.gender'
nameAgeGender = cypher(nov13, query, terrorMembers=terrorMembers)

print(mean(nameAgeGender$p.age, na.rm=T))
summary(nameAgeGender$p.age)

print(table(nameAgeGender$p.gender))
print(prop.table(table(nameAgeGender$p.gender)))

print((table(nameAgeGender$p.gender)))
print(prop.table(table(nameAgeGender$p.gender)))
barplot(prop.table(table(nameAgeGender$p.gender)))

