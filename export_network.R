'
Export the database into various formats
'


library(RNeo4j)

#name of the database
kblDB = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  

#requires neo4j database
#browse(nov13)

########################################################
#print("Export")
########################################################
nov13nodes = cypher(kblDB, query='MATCH (p) return p.name') 
write.csv(nov13nodes, file="~/nov13/ise_nodes.csv")

nov13persons = cypher(kblDB, query='MATCH (p:Person) return p.name') 
write.csv(nov13persons, file="~/nov13/ise_persons.csv")

nov13relationships = cypher(kblDB, query='MATCH (n1)-[r]->(n2) return n1.name, type(r), n2.name') 
write.csv(nov13relationships, file="~/nov13/ise_relationships.csv" )

query = '  
MATCH (p:Person)-[:INVOLVED_IN]->(s:AttackSite)
RETURN p.name, s.name'
attackersAndSites = cypher(kblDB, query)
attackersAndSites = unique(attackersAndSites)
print(attackersAndSites)  
write.csv(attackersAndSites, file="~/nov13/ise_attackersAndSites.csv" )


####################################################################################################
#Terror network of people is constructed using relationships to attackers or suspects, as follows
####################################################################################################
query = 'MATCH (n)-[r]->(m) where NOT (n:Locality) AND NOT (n:Country) AND NOT (m:Locality) AND NOT (m:Country) RETURN n.name,labels(n),type(r),m.name,labels(m) '
minimalNetwork = cypher(kblDB, query)
write.csv(minimalNetwork, file="~/nov13/ise_minimalNetwork.csv", row.names=F)


query = '  
MATCH (a1:Person)-[:INVOLVED_IN]->(l:AttackSite)<-[:INVOLVED_IN]-(a2:Person)
RETURN a1.name, a2.name'
commonAttack = cypher(kblDB, query)
commonAttack = unique(commonAttack)

query = '  
MATCH (a1:Person)-[:INVOLVED_IN]->(l:Activity)<-[:INVOLVED_IN]-(a2:Person)
RETURN a1.name, a2.name'
commonInvolvement = cypher(kblDB, query)
commonInvolvement = unique(commonInvolvement)


query = '  
MATCH (p:Person)-[:LINKED_TO]->(attacker1:Person)-[:INVOLVED_IN]->(l:AttackSite)
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
linkedToAttacker = cypher(kblDB, query)
linkedToAttacker = unique(linkedToAttacker)

query = '  
MATCH (p1:Person)-[:LINKED_TO]->(p2:Person)
WHERE (p1.status <> "free") AND (p2.status = "wanted" OR p2.status = "dead")
RETURN p1.name, p2.name'
linkedToWanted = cypher(kblDB, query)
linkedToWanted = unique(linkedToWanted)

query = '  
MATCH (p:Person)-[:PRESENT_IN]->(l:Site)<-[:PRESENT_IN]-(attacker1:Person)-[:INVOLVED_IN]->(:AttackSite)
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
sharedSpaceWithAttacker = cypher(kblDB, query)
sharedSpaceWithAttacker = unique(sharedSpaceWithAttacker)

# query = '  
# MATCH (p:Person)-[:INVOLVED_IN]->(l:Activity)<-[:INVOLVED_IN]-(attacker1:Person)-[:INVOLVED_IN]->()
# WHERE p.status <> "free"
# RETURN p.name, attacker1.name'
# sharedAffiliationWithAttacker = cypher(kblDB, query)
# sharedAffiliationWithAttacker = unique(sharedAffiliationWithAttacker)
# 
# query = '  
# MATCH (p1:Person)-[:INVOLVED_IN]->(l:Activity)<-[:INVOLVED_IN]-(p2:Person)
# WHERE p1.status <> "free" AND p2.status <> "free"
# RETURN p1.name, p2.name'
# sharedAffiliationWithSuspect = cypher(kblDB, query)
# sharedAffiliationWithSuspect = unique(sharedAffiliationWithSuspect)

query = '  
MATCH (p1:Person)-[r1]->(l:Site)<-[r2]-(p2:Person)
WHERE (p1.status <> "free") AND (p2.status <> "free")
RETURN p1.name, p2.name'
sharedSiteWithSuspect = cypher(kblDB, query)
sharedSiteWithSuspect = unique(sharedSiteWithSuspect)

query = '  
MATCH (p1:Person)-[:PRESENT_IN]->(l:Locality)<-[:PRESENT_IN]-(p2:Person)
WHERE (p1.status <> "free") AND (p2.status <> "free")
RETURN p1.name, p2.name'
sharedLocalityWithSuspect = cypher(kblDB, query)
sharedLocalityWithSuspect = unique(sharedLocalityWithSuspect)

#prepare to merge
names(commonAttack) <- c("n1", "n2")
names(linkedToAttacker) <- c("n1", "n2")
names(commonInvolvement) <- c("n1", "n2")
names(linkedToWanted) <- c("n1", "n2")
# names(assistedAttacker) <- c("n1", "n2")
# names(assistedSuspect) <- c("n1", "n2")
# names(sharedAffiliationWithAttacker) <- c("n1", "n2")
# names(sharedAffiliationWithSuspect) <- c("n1", "n2")
names(sharedSpaceWithAttacker) <- c("n1", "n2")
names(sharedSiteWithSuspect) <- c("n1", "n2")
names(sharedLocalityWithSuspect) <- c("n1", "n2")

terrorNetwork <-                   rbind(commonAttack, linkedToAttacker, linkedToWanted, commonInvolvement, sharedSpaceWithAttacker, sharedSiteWithSuspect)
terrorNetworkUndirected <- rbind(terrorNetwork, data.frame(n1=terrorNetwork[["n2"]], n2=terrorNetwork[["n1"]])) 
terrorNetworkUndirected <- unique(terrorNetworkUndirected)
print(terrorNetworkUndirected) 
write.csv(terrorNetworkUndirected, file="~/nov13/ise_terrorNetwork.csv", row.names=F)


terrorNetworkExtended           <- rbind(commonAttack, linkedToAttacker, linkedToWanted, commonInvolvement, sharedSpaceWithAttacker, sharedSiteWithSuspect, sharedLocalityWithSuspect) #, sharedAffiliationWithAttacker, sharedAffiliationWithSuspect)
terrorNetworkExtendedUndirected <- rbind(terrorNetworkExtended, data.frame(n1=terrorNetworkExtended[["n2"]], n2=terrorNetworkExtended[["n1"]])) 
terrorNetworkExtendedUndirected <- unique(terrorNetworkExtendedUndirected)
print(terrorNetworkExtendedUndirected) 
write.csv(terrorNetworkExtendedUndirected, file="~/nov13/ise_terrorNetworkExtended.csv", row.names=F)


terrorNetworkLimited           <- rbind(commonAttack, linkedToAttacker, linkedToWanted, commonInvolvement)
terrorNetworkLimitedUndirected <- rbind(terrorNetworkLimited, data.frame(n1=terrorNetworkLimited[["n2"]], n2=terrorNetworkLimited[["n1"]])) 
terrorNetworkLimitedUndirected <- unique(terrorNetworkLimitedUndirected)
print(terrorNetworkLimitedUndirected) 
write.csv(terrorNetworkLimitedUndirected, file="~/nov13/ise_terrorNetworkLimited.csv", row.names=F)

query = '  
MATCH (n:Person) WHERE (n.preNov13=TRUE) RETURN n.name'
preNov13agents = cypher(kblDB, query)
names(preNov13agents)<-c("name")
write.csv(preNov13agents, file="~/nov13/ise_preNov13agents.csv", row.names=F)


require(data.table)
query = '  
MATCH (p:Person) RETURN p.name, p.age, p.citizenship, p.status, p.role, p.ref1, p.ref2'
allPersons = data.table(cypher(kblDB, query))
#names(allPersons)<-c("name", "ageIn2015", "gender", "citizenship", "status")
write.csv(allPersons, file="~/nov13/ise_allPersons.csv", row.names=F)


require(igraph)
write_gml <- function(Vs, Es, fpath) {
  stopifnot("p.name" %in% names(Vs))
  stopifnot(names(Es)==c("n1", "n2"))
  isols <- setdiff(setdiff(Vs$p.name, Es$n1), Es$n2)
  G <- make_graph(edges=as.vector(t(Es)), directed=F, isolates=isols)
  G <- simplify(G)
  #wishlist: set other attribs
  write_graph(G, file=fpath, format="gml")
  return(G)
}

terrorPersons <- allPersons[p.status!="free"]
TN <- write_gml(Vs=terrorPersons, Es=terrorNetworkUndirected,   fpath="~/nov13/ise_terrorNetwork.gml")
write_gml(Vs=terrorPersons, Es=terrorNetworkLimitedUndirected,  fpath="~/nov13/ise_terrorNetworkLimited.gml")
write_gml(Vs=terrorPersons, Es=terrorNetworkExtendedUndirected, fpath="~/nov13/ise_terrorNetworkExtended.gml")


print("Full report")
query = '  
MATCH (p:Person) RETURN p.name, p.age, p.citizenship, p.status, p.role, p.ref1, p.ref2'
personsList = cypher(kblDB, query)
write.csv(personsList, file="~/nov13/ise_personDetails.csv")


#browse(kblDB)

#querying the DB
#===============
#MATCH (n) RETURN n
#MATCH n,s WHERE (n)-[:INVOLVED_IN]->(s) RETURN n,s
#MATCH n WHERE NOT (n:Locality) AND NOT (n:Country) RETURN n

#extract all the data necessary for minimal network
#MATCH n-[r]->m where NOT (n:Locality) AND NOT (n:Country) AND NOT (m:Locality) AND NOT (m:Country) RETURN n.name,labels(n),type(r),m.name,labels(m)

#extract all nodes of the nov13 network
#MATCH n WHERE (n.preNov13 IS NULL) RETURN n
