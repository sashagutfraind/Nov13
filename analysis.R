library(igraph)
library(networkD3)
library(RNeo4j)
nov13 = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  
clear(nov13, input=FALSE)

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

terrorNetworkUndirected <- read.csv("~/nov13_terrorNetwork.csv")
TN <- graph_from_edgelist(as.matrix(terrorNetworkUndirected))
TN <- as.undirected(TN, mode="collapse")
terrorMembers <- unique(c(terrorNetworkUndirected[["n1"]], terrorNetworkUndirected[["n2"]]))  #for safety

print(summary(TN))

simpleNetwork(terrorNetworkUndirected)

query = '  
MATCH (p:Person)-[:CITIZEN_OF]->(c:Country)
WHERE p.name IN {terrorMembers}
RETURN p.name, c.name'
nameCitizenship = cypher(nov13, query, terrorMembers=terrorMembers)
print((table(nameCitizenship$c.name)))


degrees <- degree(TN, mode="out")
degrees <- sort(degrees)
barchart(degrees, col="blue")
quartz.save(paste0("output/TN_degrees.png"), width=4, height=8, dpi=300)


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

