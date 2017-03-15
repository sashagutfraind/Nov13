'
Export the database into various formats
'


library(RNeo4j)
library(data.table)

#name of the database
kblDB = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  

#requires neo4j database
#browse(nov13)

########################################################
#print("Export")
########################################################
nov13nodes = cypher(kblDB, query='MATCH (p) return p.name') 
write.csv(nov13nodes, file="~/repos/nov13/ise_nodes.csv")

nov13persons = cypher(kblDB, query='MATCH (p:Person) return p.name') 
write.csv(nov13persons, file="~/repos/nov13/ise_persons.csv")

nov13relationships = cypher(kblDB, query='MATCH (n1)-[r]->(n2) return n1.name, type(r), n2.name') 
write.csv(nov13relationships, file="~/repos/nov13/ise_relationships.csv" )

query = '  
MATCH (p:Person)-[:INVOLVED_IN]->(s:AttackSite)
RETURN p.name, s.name'
attackersAndSites = cypher(kblDB, query)
attackersAndSites = unique(attackersAndSites)
print(attackersAndSites)  
write.csv(attackersAndSites, file="~/repos/nov13/ise_attackersAndSites.csv" )



####################################################################################################
#Terror network of people is constructed using relationships to attackers or suspects, as follows
####################################################################################################
#all rows are sorted alphabetically
query = '  
MATCH (p1:Person)-[:INVOLVED_IN]->(l:AttackSite)<-[:INVOLVED_IN]-(p2:Person)
RETURN p1.name, p2.name'
commonAttack = cypher(kblDB, query)
commonAttack = data.table(commonAttack)[,.(n1=pmin(p1.name, p2.name),n2=pmax(p1.name, p2.name))]
commonAttack = unique(commonAttack)

query = '  
MATCH (p1:Person)-[:INVOLVED_IN]->(l:Activity)<-[:INVOLVED_IN]-(p2:Person)
RETURN p1.name, p2.name'
commonInvolvement = cypher(kblDB, query)
commonInvolvement = data.table(commonInvolvement)[,.(n1=pmin(p1.name, p2.name),n2=pmax(p1.name, p2.name))]
commonInvolvement = unique(commonInvolvement)


query = '  
MATCH (p:Person)-[:LINKED_TO]->(attacker1:Person)-[:INVOLVED_IN]->(l:AttackSite)
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
linkedToAttacker = cypher(kblDB, query)
linkedToAttacker = data.table(linkedToAttacker)[,.(n1=pmin(p.name, attacker1.name),n2=pmax(p.name, attacker1.name))]
linkedToAttacker = unique(linkedToAttacker)


query = '  
MATCH (p1:Person)-[:LINKED_TO]->(p2:Person)
RETURN p1.name, p2.name'
linkedToEachOther = cypher(kblDB, query)
linkedToEachOther = data.table(linkedToEachOther)[,.(n1=pmin(p1.name, p2.name),n2=pmax(p1.name, p2.name))]
linkedToEachOther = unique(linkedToEachOther)

query = '  
MATCH (p1:Person)-[:LINKED_TO]->(p2:Person)
WHERE (p1.status <> "free") AND (p2.status = "wanted" OR p2.status = "dead")
RETURN p1.name, p2.name'
linkedToWanted = cypher(kblDB, query)
linkedToWanted = data.table(linkedToWanted)[,.(n1=pmin(p1.name, p2.name),n2=pmax(p1.name, p2.name))]
linkedToWanted = unique(linkedToWanted)

query = '  
MATCH (p:Person)-[:PRESENT_IN]->(l:Site)<-[:PRESENT_IN]-(attacker1:Person)-[:INVOLVED_IN]->(:AttackSite)
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
sharedSiteWithAttacker = cypher(kblDB, query)
sharedSiteWithAttacker = data.table(sharedSiteWithAttacker)[,.(n1=pmin(p.name, attacker1.name),n2=pmax(p.name, attacker1.name))]
sharedSiteWithAttacker = unique(sharedSiteWithAttacker)

# query = '  
# MATCH (p:Person)-[:INVOLVED_IN]->(l:Activity)<-[:INVOLVED_IN]-(attacker1:Person)-[:INVOLVED_IN]->()
# WHERE p.status <> "free"
# RETURN p.name, attacker1.name'
# sharedAffiliationWithAttacker = cypher(kblDB, query)
# sort
# sharedAffiliationWithAttacker = unique(sharedAffiliationWithAttacker)
# 
# query = '  
# MATCH (p1:Person)-[:INVOLVED_IN]->(l:Activity)<-[:INVOLVED_IN]-(p2:Person)
# WHERE p1.status <> "free" AND p2.status <> "free"
# RETURN p1.name, p2.name'
# sharedAffiliationWithSuspect = cypher(kblDB, query)
# sort
# sharedAffiliationWithSuspect = unique(sharedAffiliationWithSuspect)

query = '  
MATCH (p1:Person)-[r1]->(l:Site)<-[r2]-(p2:Person)
WHERE (p1.status <> "free") AND (p2.status <> "free")
RETURN p1.name, p2.name'
sharedSiteWithSuspect = cypher(kblDB, query)
sharedSiteWithSuspect = data.table(sharedSiteWithSuspect)[,.(n1=pmin(p1.name, p2.name),n2=pmax(p1.name, p2.name))]
sharedSiteWithSuspect = unique(sharedSiteWithSuspect)

query = '  
MATCH (p1:Person)-[:PRESENT_IN]->(l:Locality)<-[:PRESENT_IN]-(p2:Person)
WHERE (p1.status <> "free") AND (p2.status <> "free")
RETURN p1.name, p2.name'
sharedLocalityWithSuspect = cypher(kblDB, query)
sharedLocalityWithSuspect = data.table(sharedLocalityWithSuspect)[,.(n1=pmin(p1.name, p2.name),n2=pmax(p1.name, p2.name))]
sharedLocalityWithSuspect = unique(sharedLocalityWithSuspect)

terrorNetworkAllTies <- rbind(commonAttack, linkedToAttacker,  linkedToWanted, commonInvolvement,  sharedSiteWithAttacker, sharedSiteWithSuspect, sharedLocalityWithSuspect) 
#, sharedAffiliationWithAttacker, sharedAffiliationWithSuspect)
terrorNetworkAllTies <- unique(terrorNetworkAllTies)
findPair <- function(p1, p2, edges){any((p1 == edges$n1)&(p2 == edges$n2))}
totalTies <- nrow(terrorNetworkAllTies)
terrorNetworkAllTies[,commonAttack:=findPair(n1,n2,commonAttack), by=1:totalTies]
terrorNetworkAllTies[,linkedToAttacker:=findPair(n1,n2,linkedToAttacker), by=1:totalTies]
terrorNetworkAllTies[,linkedToEachOther:=findPair(n1,n2,linkedToEachOther), by=1:totalTies]  #special - not a terror tie, necessarily
terrorNetworkAllTies[,linkedToWanted:=findPair(n1,n2,linkedToWanted), by=1:totalTies]
terrorNetworkAllTies[,commonInvolvement:=findPair(n1,n2,commonInvolvement), by=1:totalTies]
terrorNetworkAllTies[,sharedSiteWithAttacker:=findPair(n1,n2,sharedSiteWithAttacker), by=1:totalTies]
terrorNetworkAllTies[,sharedSiteWithSuspect:=findPair(n1,n2,sharedSiteWithSuspect), by=1:totalTies]
terrorNetworkAllTies[,sharedLocalityWithSuspect:=findPair(n1,n2,sharedLocalityWithSuspect), by=1:totalTies]
write.csv(terrorNetworkAllTies, file="~/repos/nov13/ise_networkTieDetails.csv", row.names=F)


####################################################################################################
#Terror network members
####################################################################################################
#all rows are sorted alphabetically
query = '  
MATCH (p1:Person)-[:INVOLVED_IN]->(l:AttackSite)
RETURN p1.name'
attackerNodes = cypher(kblDB, query)
attackerNodes = data.table(attackerNodes)[,.(node=p1.name)]
attackerNodes = unique(attackerNodes)

query = '  
MATCH (p1:Person)-[:INVOLVED_IN]->(l:Activity)
RETURN p1.name'
involvedInActivityNodes = cypher(kblDB, query)
involvedInActivityNodes = data.table(involvedInActivityNodes)[,.(node=p1.name)]
involvedInActivityNodes = unique(involvedInActivityNodes)

query = '  
MATCH (p:Person)-[:LINKED_TO]->(attacker1:Person)-[:INVOLVED_IN]->(l:AttackSite)
WHERE p.status <> "free"
RETURN p.name'
linkedToAttackerNodes = cypher(kblDB, query)
linkedToAttackerNodes = data.table(linkedToAttackerNodes)[,.(node=p.name)]
linkedToAttackerNodes = unique(linkedToAttackerNodes)

terrorNetworkMembers <- rbind(attackerNodes, involvedInActivityNodes, linkedToAttackerNodes)
numMembers <- nrow(terrorNetworkMembers)
findNode <- function(p1, dt){(p1 %in% dt$node)}

terrorNetworkMembers[,attackerNodes:=findNode(node, attackerNodes), by=1:numMembers]
terrorNetworkMembers[,involvedInActivityNodes:=findNode(node, involvedInActivityNodes), by=1:numMembers]
terrorNetworkMembers[,linkedToAttackerNodes:=findNode(node, linkedToAttackerNodes), by=1:numMembers]
write.csv(terrorNetworkMembers, file="~/repos/nov13/ise_networkNodeDetails.csv", row.names=F)

####################################################################################################
#Network extracts
####################################################################################################
#IS-E
terrorNetwork <- rbind(commonAttack, linkedToAttacker, linkedToWanted, commonInvolvement, sharedSiteWithAttacker, sharedSiteWithSuspect)
terrorNetwork <- unique(terrorNetwork)
print(terrorNetwork) 
write.csv(terrorNetwork, file="~/repos/nov13/ise_terrorNetwork.csv", row.names=F)

#IS-E restricted
terrorNetworkLimited <- rbind(commonAttack, linkedToAttacker, linkedToWanted, commonInvolvement)
terrorNetworkLimited <- unique(terrorNetworkLimited)
print(terrorNetworkLimited) 
write.csv(terrorNetworkLimited, file="~/repos/nov13/ise_terrorNetworkLimited.csv", row.names=F)

#IS-E extended
terrorNetworkExtended <- terrorNetworkAllTies[,.(n1,n2)]
print(terrorNetworkExtended) 
write.csv(terrorNetworkExtended, file="~/repos/nov13/ise_terrorNetworkExtended.csv", row.names=F)


#Snapshot of the database, focusing on the most important structure...
query = 'MATCH (n)-[r]->(m) where NOT (n:Locality) AND NOT (n:Country) AND NOT (m:Locality) AND NOT (m:Country) RETURN n.name,labels(n),type(r),m.name,labels(m) '
minimalNetwork = cypher(kblDB, query)
write.csv(minimalNetwork, file="~/repos/nov13/ise_minimalDB.csv", row.names=F)

query = '  
MATCH (n:Person) WHERE (n.notInNov13=TRUE) RETURN n.name'
notInNov13agents = cypher(kblDB, query)
names(notInNov13agents)<-c("name")
write.csv(notInNov13agents, file="~/repos/nov13/ise_notInNov13agents.csv", row.names=F)


query = '  
MATCH (p:Person) RETURN p.name, p.age, p.citizenship, p.status, p.role, p.ref1, p.ref2'
allPersons = data.table(cypher(kblDB, query))
#names(allPersons)<-c("name", "ageIn2015", "gender", "citizenship", "status")
write.csv(allPersons, file="~/repos/nov13/ise_allPersons.csv", row.names=F)


print("Full report")
query = '  
MATCH (p:Person) RETURN p.name, p.age, p.citizenship, p.status, p.role, p.ref1, p.ref2'
personsList = cypher(kblDB, query)
write.csv(personsList, file="~/repos/nov13/ise_personDetails.csv")

print("Write a GML...")
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
stopifnot(!any(terrorPersons$p.name == ""))

TN <- write_gml(Vs=terrorPersons, Es=terrorNetwork,   fpath="~/repos/nov13/ise_terrorNetwork.gml")
write_gml(Vs=terrorPersons, Es=terrorNetworkLimited,  fpath="~/repos/nov13/ise_terrorNetworkLimited.gml")
write_gml(Vs=terrorPersons, Es=terrorNetworkExtended, fpath="~/repos/nov13/ise_terrorNetworkExtended.gml")


#browse(kblDB)

#querying the DB
#===============
#MATCH (n) RETURN n
#MATCH (n),(s) WHERE (n)-[:INVOLVED_IN]->(s) RETURN n,s
#MATCH (n) WHERE NOT (n:Locality) AND NOT (n:Country) RETURN n

#extract all the data necessary for minimal network
#MATCH (n)-[r]->(m) where NOT (n:Locality) AND NOT (n:Country) AND NOT (m:Locality) AND NOT (m:Country) RETURN n.name,labels(n),type(r),m.name,labels(m)

#extract all nodes of the nov13 network
#MATCH (n) WHERE (n.notInNov13 IS NULL) RETURN n
