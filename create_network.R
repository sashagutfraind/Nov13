'
The file below creates the dataset using the neo4j Database

1. Download the Neo4j community edition

2. Unix/MacOSX or Windows, from the install dir run: 
./bin/neo4j start

3. Navigate to, and set up username: neo4j, password: 1
http://localhost:7474/browser/  (check)

4. From https://www.r-project.org/, 
install.packages("RNeo4j")

5. Run this file in R.  Output will be saved as CSV files under your home dir

6. After the file has been created, you can export it into GraphML (loaded into Gephi) using
./bin/neo4j-shell

and then:

export-graphml -o outputTest.graphml -t

'

library(RNeo4j)
nov13 = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  
clear(nov13, input=FALSE)

references = list(DM1="http://www.dailymail.co.uk/news/article-3321715/The-rented-home-ISIS-fanatics-plotted-nov13-massacre-Landlady-says-terrorists-plotted-atrocity-apartment-nice-proper-dressed-men-didn-t-beards.html"
                  ,WSJ1="http://www.wsj.com/articles/attacker-tried-to-enter-paris-stadium-but-was-turned-away-1447520571"
                  ,IN1="http://www.independent.co.uk/news/world/europe/france-attacks-mohamed-abdeslam-salah-abdeslam-fleeing-suspect-bataclan-a6736871.html"
                  ,BFM1="http://rmc.bfmtv.com/emission/attentats-de-paris-sur-les-traces-de-mohamed-amri-soupconne-d-etre-l-artificier-des-operations-930719.html"
                  ,IBT1="http://www.ibtimes.com/who-hamza-attou-mohammed-amri-everything-we-know-about-alleged-paris-terrorist-2188100"
                  )
#persons
AbdelhamidAbaaoud = createNode(nov13, "Person", name="Abdelhamid Abaaoud", age=27, gender="Male", ref1=references[["DM1"]])
AhmedAlmuhamed    = createNode(nov13, "Person", name="Ahmed Almuhamed",    age=25, gender="Male",    ref1=references[["DM1"]])
BilalHadfi        = createNode(nov13, "Person", name="Bilal Hadfi",        age=20, gender="Male",  ref1=references[["DM1"]])
HamzaAttou        = createNode(nov13, "Person", name="Hamza Attou",                gender="Male",  ref1=references[["IBT1"]])

IbrahimAbdeslam   = createNode(nov13, "Person", name="Ibrahim Abdeslam",    age=31, gender="Male", nickname="Brahim", ref1=references[["DM1"]])
MohammadAbdeslam  = createNode(nov13, "Person", name="Mohammad Abdeslam",   ref1=references[["DM1"]])
MohamedAmimour    = createNode(nov13, "Person", name="Mohamed Amimour",     age=67, gender="Male", ref1=references[["DM1"]])
MohamedAmri       = createNode(nov13, "Person", name="Mohamed Amri",         age=27, gender="Male", ref1=references[["DM1"]])
OmarMostefai      = createNode(nov13, "Person", name="Omar Ismaïl Mostefaï", age=29, gender="Male", ref1=references[["DM1"]])
SalahAbdeslam     = createNode(nov13, "Person", name="Salah Abdeslam",       age=26, gender="Male", ref1=references[["DM1"]])
SamyAmimour       = createNode(nov13, "Person", name="Samy Amimour",         age=28, gender="Male", ref1=references[["DM1"]])

UnknownAttacker1 = createNode(nov13, "Person", name="UnknownAttacker1",  age=20, gender="Male", citizenship="France", ref1=references[["DM1"]])
UnknownAttacker2 = createNode(nov13, "Person", name="UnknownAttacker2",  gender="Male", ref1=references[["DM1"]])  #possibly, Abbdulakbak B
UnknownAttacker3 = createNode(nov13, "Person", name="UnknownAttacker3",  gender="Male", ref1=references[["DM1"]])
UnknownAttacker4 = createNode(nov13, "Person", name="UnknownAttacker4",  gender="Male", ref1=references[["DM1"]])
UnknownAttacker5 = createNode(nov13, "Person", name="UnknownAttacker5",  gender="Female", ref1=references[["DM1"]])

UnknownMontenegran = createNode(nov13, "Person", name="UnknownMontenegran")

#+a 30-year-old man who was detained on his way back from Syria tiped
#http://www.dailymail.co.uk/news/article-3321715/The-rented-home-ISIS-fanatics-plotted-Paris-massacre-Landlady-says-terrorists-plotted-atrocity-apartment-nice-proper-dressed-men-didn-t-beards.html#ixzz3rpgneGvY 


#countries
Belgium = createNode(nov13, "Country", name="Belgium")
France = createNode(nov13, "Country", name="France")
Syria = createNode(nov13, "Country", name="Syria")
Turkey = createNode(nov13, "Country", name="Turkey")

#localities
Alfortsville  = createNode(nov13, "Locality", name="Alfortsville")
Bobigny       = createNode(nov13, "Locality", name="Bobigny")
Molenbeek     = createNode(nov13, "Locality", name="Molenbeek, Brussels")


#attack sites #TODO: added citations
Bataclan         = createNode(nov13, "AttackSite", name="Bataclan", killed=89, wounded=200)
ComptoirVoltaire = createNode(nov13, "AttackSite", name="Comptoir Voltaire", killed=0, wounded=3, ref1=references[["DM1"]])
LaBonneBiere     = createNode(nov13, "AttackSite", name="La Bonne Biere", killed=0, wounded=0)
LaCasaNostra     = createNode(nov13, "AttackSite", name="La Casa Nostra", killed=5)
LaBelleEquipe    = createNode(nov13, "AttackSite", name="La Belle Equipe", killed=19)
LeCarillonBarAndLePetitCambodge    = createNode(nov13, "AttackSite", name="Le Carillon Bar and Le Petit Cambodge", killed=15, injured=10)
#MacDonalds       = createNode(nov13, "AttackSite", name="MacDonalds Rue de la Coquerie")  #related to Stade attacks
StadeDeFrance    = createNode(nov13, "AttackSite", name="Stade de France", killed=1)


#transited
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Molenbeek, ref1=references[["DM1"]])
createRel(BilalHadfi,   "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(OmarMostefai, "BEEN_IN", Turkey, date="2010", ref1=references[["DM1"]])
createRel(OmarMostefai, "BEEN_IN", Syria, date="2013", ref1=references[["DM1"]])
createRel(AbdelhamidAbaaoud, "BEEN_IN", Syria, ref1=references[["DM1"]])
#TODO: expand

#staging for attack
createRel(SalahAbdeslam, "STAGED_IN", Alfortsville, ref1=references[["DM1"]])

createRel(IbrahimAbdeslam, "STAGED_IN", Bobigny, ref1=references[["DM1"]])
createRel(SalahAbdeslam, "STAGED_IN", Bobigny, ref1=references[["DM1"]])
createRel(SamyAmimour, "STAGED_IN", Bobigny, ref1=references[["DM1"]])


#relationships
createRel(SalahAbdeslam, "RELATED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(SalahAbdeslam, "RELATED_TO", MohammadAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(MohammadAbdeslam, "RELATED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])

createRel(MohamedAmimour, "RELATED_TO", SamyAmimour, note="father_of", ref1=references[["DM1"]])

createRel(MohamedAmri, "ASSISTED", SalahAbdeslam, note="drove", ref1=references[["DM1"]])
createRel(HamzaAttou,  "ASSISTED", SalahAbdeslam, note="drove", ref1=references[["DM1"]])

createRel(AbdelhamidAbaaoud, "CITIZEN_OF", Belgium, ref1=references[["DM1"]])
createRel(AhmedAlmuhamed,    "CITIZEN_OF", Belgium, ref1=references[["DM1"]])
createRel(BilalHadfi,        "CITIZEN_OF", Belgium, ref1=references[["DM1"]])
createRel(IbrahimAbdeslam,   "CITIZEN_OF", France, ref1=references[["DM1"]])
createRel(MohamedAmri,       "CITIZEN_OF", France, ref1=references[["DM1"]])
createRel(OmarMostefai,      "CITIZEN_OF", France, ref1=references[["DM1"]])
createRel(SalahAbdeslam,     "CITIZEN_OF", Belgium, ref1=references[["DM1"]])
createRel(SamyAmimour,       "CITIZEN_OF", France, ref1=references[["DM1"]])


#attacks
createRel(IbrahimAbdeslam, "ATTACKED", ComptoirVoltaire, attack_type="Suicide", ref1=references[["DM1"]])

createRel(OmarMostefai,    "ATTACKED",  Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
createRel(SamyAmimour,     "ATTACKED", Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
createRel(UnknownAttacker4, "ATTACKED",  Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
createRel(UnknownAttacker5, "ATTACKED", Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
#only 3 detonated
createRel(OmarMostefai,    "ATTACKED",  Bataclan, attack_type="Shooting", ref1=references[["DM1"]])
createRel(SamyAmimour,     "ATTACKED", Bataclan, attack_type="Shooting", ref1=references[["DM1"]])
createRel(UnknownAttacker4, "ATTACKED",  Bataclan, attack_type="Shooting", ref1=references[["DM1"]])
createRel(UnknownAttacker5, "ATTACKED", Bataclan, attack_type="Shooting", ref1=references[["DM1"]])

createRel(AhmedAlmuhamed, "ATTACKED", StadeDeFrance, attack_type="Suicide", ref1=references[["DM1"]])
createRel(BilalHadfi,     "ATTACKED", StadeDeFrance, attack_type="Suicide", ref1=references[["DM1"]])  
createRel(UnknownAttacker1, "ATTACKED", StadeDeFrance, attack_type="Suicide", note="detonated at nearby MacDonalds",  ref1=references[["DM1"]], ref2=references[["WSJ1"]])  

createRel(UnknownAttacker2, "ATTACKED", LeCarillonBarAndLePetitCambodge, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(UnknownAttacker3, "ATTACKED", LeCarillonBarAndLePetitCambodge, attack_type="Shooting", ref1=references[["DM1"]])  


#arrests
createRel(MohammadAbdeslam, "ARRESTED_IN", Belgium, date="2015-11-16", ref1=references[["IN1"]])
createRel(MohamedAmri, "ARRESTED_IN", Belgium, date="2015-11-17", ref1=references[["DM1"]])
createRel(HamzaAttou, "ARRESTED_IN", Belgium, date="2015-11-17", ref1=references[["IBT1"]])


########################################################
#print("Export")
########################################################
nov13nodes = cypher(nov13, query='MATCH (p) return p.name') 
write.csv(nov13nodes, file="~/nov13_nodes.csv")

nov13persons = cypher(nov13, query='MATCH (p:Person) return p.name') 
write.csv(nov13persons, file="~/nov13_persons.csv")

nov13relationships = cypher(nov13, query='MATCH (n1)-[r]->(n2) return n1.name, type(r), n2.name') 
write.csv(nov13relationships, file="~/nov13_relationships.csv" )

#requires neo4j database
#browse(nov13)

# query = "
# MATCH (p:Person)-[:ATTACKED]->()
# WHERE (p)-[:CITIZEN_OF]->(c:Country)
# WHERE c.name="France"
# RETURN p.name"
# 
# nameOfAttackersFromFrance = cypher(graph, query)

#detailed export: https://github.com/jexp/neo4j-shell-tools
