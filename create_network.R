'
The file below creates the dataset using the neo4j Database

1. Download the Neo4j community edition

2. Unix/MacOSX or Windows, from the install dir run: 
./bin/neo4j start

3. Navigate to, and set up username: neo4j, password: 1
http://localhost:7474/browser/  (check)

4. From https://www.r-project.org/, 
Download and install R, then install
install.packages("RNeo4j")

5. Run this file in R.  Output will be saved as CSV files under your home dir

6. After the file has been created, you can export it into GraphML (loaded into Gephi) using
./bin/neo4j-shell

and then something like (https://github.com/jexp/neo4j-shell-tools):

export-graphml -o nov13.graphml -t

You can also get the JSON file from the neo4j display
'


' 
TODO: 
- homes and citizenship of the attackers, particularly French residents
'
library(RNeo4j)
nov13 = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  
clear(nov13, input=FALSE)

references = list(DM1="http://www.dailymail.co.uk/news/article-3321715/The-rented-home-ISIS-fanatics-plotted-nov13-massacre-Landlady-says-terrorists-plotted-atrocity-apartment-nice-proper-dressed-men-didn-t-beards.html"
                  ,WSJ1="http://www.wsj.com/articles/attacker-tried-to-enter-paris-stadium-but-was-turned-away-1447520571"
                  ,IN1="http://www.independent.co.uk/news/world/europe/france-attacks-mohamed-abdeslam-salah-abdeslam-fleeing-suspect-bataclan-a6736871.html"
                  ,BFM1="http://rmc.bfmtv.com/emission/attentats-de-paris-sur-les-traces-de-mohamed-amri-soupconne-d-etre-l-artificier-des-operations-930719.html"
                  ,IBT1="http://www.ibtimes.com/who-hamza-attou-mohammed-amri-everything-we-know-about-alleged-paris-terrorist-2188100"
                  ,NBC1="http://www.nbcnews.com/storyline/paris-terror-attacks/paris-attacks-2-dead-7-arrested-during-saint-denis-raid-n465331"
                  ,NBC2="http://www.nbcnews.com/storyline/paris-terror-attacks/paris-attacks-probe-centers-brussels-suburb-molenbeek-n464741"
                  ,NYT1="http://www.nytimes.com/2015/11/17/world/europe/in-suspects-brussels-neighborhood-a-history-of-petty-crimes-and-missed-chances.html"
                  ,LIR1="http://www.lesinrocks.com/2015/11/18/actualite/qui-est-fabien-clain-la-voix-de-daesh-11788443/"
                  ,LOB1="http://tempsreel.nouvelobs.com/attentats-terroristes-a-paris/20151118.OBS9764/assaut-de-saint-denis-jawad-le-chef-de-la-rue-qui-a-heberge-les-terroristes.html"
                  ,IBT2="http://www.ibtimes.co.uk/paris-attacks-belgian-jihadist-abdelhamid-abbaoud-may-be-entrenched-saint-denis-flat-1529265"
                  ,FIG1="http://www.lefigaro.fr/actualite-france/2015/11/18/01016-20151118ARTFIG00320-assaut-a-saint-denis-l-intervention-du-raid-heure-par-heure.php?redirect_premium"
                  ,NP1="http://news.nationalpost.com/news/woman-detonates-her-suicide-vest-as-police-storm-paris-suburb-in-hunt-for-mastermind"
                  ,NEW1="http://www.news.com.au/world/europe/paris-terror-attacks-france-russia-ramp-up-bombing-campaign-against-islamic-state-in-syria/news-story/76f0da5eebf5ffe7a1f90bb37f695ff7"
                  ,WP1="https://www.washingtonpost.com/world/2-attack-suspects-in-dead-after-french-police-raid-north-of-paris/2015/11/18/a2b6d52e-8d6a-11e5-934c-a369c80822c2_story.html"
                  ,FT1="http://www.ft.com/cms/s/0/84aeb7dc-8d32-11e5-8be4-3506bf20cc2b.html#axzz3ruJPljRy"
                  ,NEW2="http://www.9news.com.au/world/2015/11/18/15/25/residents-wake-up-to-gunfire-in-paris"
                  ,CNN1="http://www.cnn.com/2015/11/18/europe/paris-attacks-at-a-glance/"
                  ,WP2="https://www.washingtonpost.com/graphics/world/paris-attacks/"
                  ,NYT2="http://www.nytimes.com/interactive/2015/11/15/world/europe/manhunt-for-paris-attackers.html"
                  ,EXP1="http://www.expatica.com/fr/news/country-news/Big-questions-remain-over-Paris-attacks_540890.html"
                  ,TEL1="http://www.telegraph.co.uk/news/worldnews/europe/france/12004756/Paris-attacks-Abdelhamid-Abaaoud-police-France-terrorist-Islamic-State-flight-live.html#update-20151120-1528"
                  )


AbdelhamidAbaaoud = createNode(nov13, "Person", name="Abdelhamid Abaaoud", age=27, gender="Male", nickname="Abu Omar al-Belgiki", ref1=references[["DM1"]], status="dead", ref2=references[["WP1"]],  ref3=references[["FT1"]])
AhmedAlmuhamed    = createNode(nov13, "Person", name="Ahmed Almuhamed",    age=25, gender="Male", ref1=references[["DM1"]], status="dead")
BilalHadfi        = createNode(nov13, "Person", name="Bilal Hadfi",        age=20, gender="Male", ref1=references[["DM1"]], status="dead")
FabianClain       = createNode(nov13, "Person", name="Fabian Clain",      age=36, gender="Male", nickname="Omar", ref1=references[["LIR1"]], status="wanted")
HamzaAttou        = createNode(nov13, "Person", name="Hamza Attou",                gender="Male", ref1=references[["IBT1"]], status="assested")
IbrahimAbdeslam   = createNode(nov13, "Person", name="Ibrahim Abdeslam",    age=31, gender="Male", nickname="Brahim", ref1=references[["DM1"]], status="dead")
JawadBenDow       = createNode(nov13, "Person", name="Jawad Ben Dow",      age=27, gender="Male", ref1=references[["LOB1"]], status="arrested")
MohammadAbdeslam  = createNode(nov13, "Person", name="Mohammad Abdeslam",          gender="Male",  ref1=references[["DM1"]], status="free")
MohamedAmimour    = createNode(nov13, "Person", name="Mohamed Amimour",     age=67, gender="Male", ref1=references[["DM1"]], status="free")
MohamedAmri       = createNode(nov13, "Person", name="Mohamed Amri",         age=27, gender="Male", ref1=references[["DM1"]], status="arrested")
MohamedKhoualed   = createNode(nov13, "Person", name="Mohamed Khoualed",         age=19, gender="Male", ref1=references[["TEL1"]], status="arrested")
OmarMostefai      = createNode(nov13, "Person", name="Omar Ismaïl Mostefaï", age=29, gender="Male", ref1=references[["DM1"]], status="dead")
SalahAbdeslam     = createNode(nov13, "Person", name="Salah Abdeslam",       age=26, gender="Male", ref1=references[["DM1"]], status="wanted")
SamyAmimour       = createNode(nov13, "Person", name="Samy Amimour",         age=28, gender="Male", ref1=references[["DM1"]], status="dead")

AbbdulakbakB     = createNode(nov13, "Person", name="AbbdulakbakB",      gender="Male", ref1=references[["DM1"]], status="dead")  #identity reports and role are sketchy
UnknownStade     = createNode(nov13, "Person", name="UnknownStade",  age=20, gender="Male", nickname="Ahmad al Mohammad",  ref1=references[["DM1"]],  ref3=references[["FT1"]], status="dead")
CafeAttacker3    = createNode(nov13, "Person", name="CafeAttacker3",  ref1=references[["DM1"]], status="wanted")
UnknownBat       = createNode(nov13, "Person", name="UnknownBat",  gender="Female", ref1=references[["DM1"]], status="dead")

UnknownMontenegran = createNode(nov13, "Person", name="UnknownMontenegran",  age=51, ref1=references[["FT1"]])

#http://www.lemonde.fr/attaques-a-paris/article/2015/11/18/un-assaut-policier-en-cours-a-saint-denis-dans-le-cadre-de-l-enquete-sur-les-attentats-du-13-novembre_4812248_4809495.html
#http://www.lefigaro.fr/actualites/2015/11/18/01001-20151118LIVWWW00266-en-direct-attentats-de-paris-assaut-saint-denis-terrorisme.php
#3 at the beginning of the intervention, 3 on the street (incl. Jawad), 2 in the rubble
#StDennis group Rue de Cabrillon
HasnaAitboulahcen  = createNode(nov13, "Person", name="Hasna Aitboulahcen",  age=26,   gender="Female", ref1=references[["LOB1"]], ref2=references[["NP1"]], status="dead", ref2=references[["EXP1"]])

#StDennis group Boul. Carnot?
StDEgyptianA       = createNode(nov13, "Person", name="StDEgyptianA",      gender="Male", ref1=references[["LOB1"]], status="arrested")
StDEgyptianB       = createNode(nov13, "Person", name="StDEgyptianB",      gender="Male", ref1=references[["LOB1"]], status="arrested")

StDArrested3       = createNode(nov13, "Person", name="StDArrested3",      gender="Male", ref1=references[["LOB1"]], status="arrested")

#likely unrelated: FIG1
StDArrested4       = createNode(nov13, "Person", name="StDArrested4",      gender="Male", ref1=references[["LOB1"]], status="arrested")
StDArrested5       = createNode(nov13, "Person", name="StDArrested5",      gender="Male", ref1=references[["LOB1"]], status="arrested")
StDArrested6       = createNode(nov13, "Person", name="StDArrested6",      gender="Male", ref1=references[["LOB1"]], status="arrested")
StDArrested7       = createNode(nov13, "Person", name="StDArrested7",      gender="Male", ref1=references[["LOB1"]], status="arrested")

#+explosion in Charleville-Mezieres
#http://www.cnn.com/2015/11/19/europe/paris-attacks-at-a-glance/

#+a 30-year-old man who was detained on his way back from Syria tiped
#http://www.dailymail.co.uk/news/article-3321715/The-rented-home-ISIS-fanatics-plotted-Paris-massacre-Landlady-says-terrorists-plotted-atrocity-apartment-nice-proper-dressed-men-didn-t-beards.html

#TOI1: 9 linked to Bilal
#http://www.timesofisrael.com/nine-arrested-in-brussels-linked-to-paris-attacks/
#Mr. Hadfi, who is a French citizen, lived in the Neder-over-Heembeek district of Brussels with his mother and three other siblings.
#http://www.nytimes.com/2015/11/20/world/europe/paris-attacks.html

#+addition connections to Reunion/Toulouse group and Mohamed Merah
#http://www.lesinrocks.com/2015/11/18/actualite/qui-est-fabien-clain-la-voix-de-daesh-11788443/

#+father and brother of Ismaeël
#http://pamelageller.com/2015/11/french-muslim-ismael-omar-mostefai-and-abbdulakbak-b-suicide-bombers-named-in-paris-terror-attack.html/

#countries
Belgium = createNode(nov13, "Country", name="Belgium")
Egypt  = createNode(nov13, "Country", name="Egypt")
Greece  = createNode(nov13, "Country", name="Greece")
France = createNode(nov13, "Country", name="France")
Morocco = createNode(nov13, "Country", name="Morocco")
Syria = createNode(nov13, "Country", name="Syria")
Turkey = createNode(nov13, "Country", name="Turkey")

#localities / sites
Alfortsville  = createNode(nov13, "Locality", name="Alfortsville")
Bobigny       = createNode(nov13, "Locality", name="Bobigny")
Molenbeek     = createNode(nov13, "Locality", name="Molenbeek", location="various")
StDenis       = createNode(nov13, "Locality", name="St.Denis", location="8 rue du Carillon and rue Carnot", ref1=references[["NBC1"]])
#wishlist: second location in St.Denis

#attack sites.  for casualties see WP2
Arrondisement18  = createNode(nov13, "AttackSite", name="Unknown in Arrondisement 18", killed=0, wounded=0, outcome="aborted")
Bataclan         = createNode(nov13, "AttackSite", name="Bataclan", killed=89, wounded=200)
ComptoirVoltaire = createNode(nov13, "AttackSite", name="Comptoir Voltaire", killed=0, wounded=3, ref1=references[["DM1"]])
LaBonneBiere     = createNode(nov13, "AttackSite", name="La Bonne Biere", killed=0, wounded=0)
LaCasaNostra     = createNode(nov13, "AttackSite", name="La Casa Nostra", killed=5, wounded=8)
LaBelleEquipe    = createNode(nov13, "AttackSite", name="La Belle Equipe", killed=19, wounded=9)
LeCarillonBarAndLePetitCambodge    = createNode(nov13, "AttackSite", name="Le Carillon Bar and Le Petit Cambodge", killed=15, injured=10)
#MacDonalds       = createNode(nov13, "AttackSite", name="MacDonalds Rue de la Coquerie")  #related to Stade attacks
StadeDeFrance    = createNode(nov13, "AttackSite", name="Stade de France", killed=1, wounded=0)

#locations where the network might have formed
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Molenbeek, ref1=references[["DM1"]])
createRel(IbrahimAbdeslam,    "BEEN_IN", Molenbeek, ref1=references[["NBC2"]])
createRel(BilalHadfi,         "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(OmarMostefai,       "BEEN_IN", Turkey, date="2010", ref1=references[["DM1"]])
createRel(OmarMostefai,       "BEEN_IN", Syria, date="2013", ref1=references[["DM1"]])
createRel(SalahAbdeslam,      "BEEN_IN", Molenbeek, ref1=references[["NBC2"]])
createRel(SamyAmimour,        "BEEN_IN", Syria, ref1=references[["NEW2"]])

#StDennis
createRel(AbdelhamidAbaaoud,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(HasnaAitboulahcen,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])

createRel(JawadBenDow,        "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDEgyptianA,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDEgyptianB,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDArrested3,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDArrested4,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDArrested5,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDArrested6,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDArrested7,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])

#staging for attack
createRel(SalahAbdeslam, "BEEN_IN", Alfortsville, ref1=references[["DM1"]])
createRel(IbrahimAbdeslam, "BEEN_IN", Bobigny, ref1=references[["DM1"]])
createRel(SalahAbdeslam, "BEEN_IN", Bobigny, ref1=references[["DM1"]])
createRel(SamyAmimour, "BEEN_IN", Bobigny, ref1=references[["DM1"]])

#lesser sites
#createRel(HasnaAitboulahcen,  "BEEN_IN", AulnaySousBois, ref1=references[["CNN2"]]) #http://www.cnn.com/2015/11/19/europe/paris-attacks-at-a-glance/
#createRel(MohamedKhoualed,  "BEEN_IN", Roubaix, ref1=references[["TEL1"]])

#residence by country
createRel(AbdelhamidAbaaoud,  "LIVED_IN", Belgium, ref1=references[["LOB1"]])
createRel(BilalHadfi, "LIVED_IN", Belgium, ref1=references[["NYT2"]])
createRel(IbrahimAbdeslam, "LIVED_IN", Belgium, ref1=references[["NYT2"]])
createRel(MohamedKhoualed, "LIVED_IN", Belgium, ref1=references[["TEL1"]])
createRel(OmarMostefai, "LIVED_IN", France, ref1=references[["NYT2"]])
createRel(SalahAbdeslam, "LIVED_IN", Belgium, ref1=references[["NYT2"]])
createRel(SamyAmimour, "LIVED_IN", France, ref1=references[["NYT2"]])

#transit countries
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Greece, ref1=references[["EXP1"]])
createRel(AhmedAlmuhamed,     "BEEN_IN", Greece, ref1=references[["EXP1"]])


#friend and familiar affiliations
createRel(SalahAbdeslam,     "LINKED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(SalahAbdeslam,     "LINKED_TO", MohammadAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(MohammadAbdeslam , "LINKED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(MohamedAmimour,    "LINKED_TO", SamyAmimour, note="father_of", ref1=references[["DM1"]])
createRel(HasnaAitboulahcen, "LINKED_TO", AbdelhamidAbaaoud, note="cousin", ref1=references[["IBT2"]])
createRel(SalahAbdeslam,     "LINKED_TO", AbdelhamidAbaaoud, note="friends", ref1=references[["CNN1"]])

createRel(AbdelhamidAbaaoud,  "LINKED_TO", OmarMostefai, note="uncharacterized", ref1=references[["NYT2"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", BilalHadfi, note="led in Syria", ref1=references[["NYT2"]])

#

#citizenship.  we allow multiple citizenships.  weak indicator of affinity between individuals
createRel(AbdelhamidAbaaoud, "CITIZEN_OF", Belgium, ref1=references[["DM1"]])
createRel(AbdelhamidAbaaoud, "CITIZEN_OF", Morocco, ref1=references[["NEW1"]])
createRel(BilalHadfi,        "CITIZEN_OF", France, ref1=references[["DM1"]])
createRel(StDEgyptianA,      "CITIZEN_OF", Egypt, ref1=references[["DM1"]])
createRel(StDEgyptianB,      "CITIZEN_OF", Egypt, ref1=references[["DM1"]])
createRel(IbrahimAbdeslam,   "CITIZEN_OF", France, ref1=references[["DM1"]])
createRel(MohamedAmri,       "CITIZEN_OF", France, ref1=references[["DM1"]])
createRel(OmarMostefai,      "CITIZEN_OF", France, ref1=references[["DM1"]])
createRel(SalahAbdeslam,     "CITIZEN_OF", France, ref1=references[["NYT2"]])
createRel(SamyAmimour,       "CITIZEN_OF", France, ref1=references[["DM1"]])


#probable involvement in the plot
createRel(MohamedAmri, "ASSISTED", SalahAbdeslam, note="drove", ref1=references[["DM1"]])
createRel(HamzaAttou,  "ASSISTED", SalahAbdeslam, note="drove", ref1=references[["DM1"]])

createRel(FabianClain,  "ASSISTED", AbdelhamidAbaaoud, note="publicized", ref1=references[["DM1"]])

createRel(MohamedKhoualed,  "ASSISTED", SalahAbdeslam, note="explosives", ref1=references[["TEL1"]])

#attacks
createRel(IbrahimAbdeslam, "ATTACKED", ComptoirVoltaire, attack_type="Suicide", ref1=references[["DM1"]])
createRel(OmarMostefai,    "ATTACKED",  Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
createRel(SamyAmimour,     "ATTACKED", Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
createRel(AbbdulakbakB,     "ATTACKED",  Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
createRel(UnknownBat, "ATTACKED", Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
#only 3 detonated.  several (all?) shot.  Volkswagen Polo abandoned at site

createRel(AhmedAlmuhamed, "ATTACKED", StadeDeFrance, attack_type="Suicide", ref1=references[["DM1"]])
createRel(BilalHadfi,     "ATTACKED", StadeDeFrance, attack_type="Suicide", ref1=references[["DM1"]])  
createRel(UnknownStade, "ATTACKED", StadeDeFrance, attack_type="Suicide", note="detonated at nearby MacDonalds",  ref1=references[["DM1"]], ref2=references[["WSJ1"]])  

#gunmen in a black Seat Leon.  possibly Abdeslam brothers + unknown
#http://www.lefigaro.fr/actualite-france/2015/11/18/01016-20151118ARTFIG00346-ce-que-l-on-sait-du-commando-qui-a-seme-la-terreur-a-paris.php
createRel(IbrahimAbdeslam, "ATTACKED", LeCarillonBarAndLePetitCambodge, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LeCarillonBarAndLePetitCambodge, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(CafeAttacker3, "ATTACKED", LeCarillonBarAndLePetitCambodge, attack_type="Shooting", ref1=references[["NEW2"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaCasaNostra, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LaCasaNostra, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(CafeAttacker3, "ATTACKED", LaCasaNostra, attack_type="Shooting", ref1=references[["NEW2"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaBonneBiere, attack_type="Shooting", ref1=references[["NEW2"]])  
createRel(SalahAbdeslam, "ATTACKED", LaBonneBiere, attack_type="Shooting", ref1=references[["NEW2"]])  
createRel(CafeAttacker3, "ATTACKED", LaBonneBiere, attack_type="Shooting", ref1=references[["NEW2"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaBelleEquipe, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LaBelleEquipe, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(CafeAttacker3, "ATTACKED", LaBelleEquipe, attack_type="Shooting", ref1=references[["DM1"]])  

#suspected attack
createRel(SalahAbdeslam, "ATTACKED", Arrondisement18, attack_type="Unknown", ref1=references[["DM1"]])

#suspected attack 2?
#+8 arrested in Saint Dennis with force 2015-11-18, http://www.nydailynews.com/news/world/paris-raid-killed-2-terror-suspects-time-article-1.2438743
#TARGETED Airport, Shopping Mall

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

query = '  
MATCH (p:Person)-[:ATTACKED]->(s:AttackSite)
RETURN p.name, s.name'
attackersAndSites = cypher(nov13, query)
attackersAndSites = unique(attackersAndSites)
print(attackersAndSites)  
write.csv(attackersAndSites, file="~/nov13_attackersAndSites.csv" )


####################################################################################################
#Terror network of people is constructed using relationships to attackers or suspects, as follows
####################################################################################################

query = '  
MATCH (attacker1:Person)-[:ATTACKED]->(l:AttackSite)<-[:ATTACKED]-(attacker2:Person)
RETURN attacker1.name, attacker2.name'
commonAttack = cypher(nov13, query)
commonAttack = unique(commonAttack)

query = '  
MATCH (p:Person)-[:LINKED_TO]->(attacker1:Person)-[:ATTACKED]->(l:AttackSite)
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
linkedToAttacker = cypher(nov13, query)
linkedToAttacker = unique(linkedToAttacker)

query = '  
MATCH (p1:Person)-[:LINKED_TO]->(p2:Person)
WHERE (p1.status <> "free") AND (p2.status = "wanted" OR p2.status = "dead")
RETURN p1.name, p2.name'
linkedToWanted = cypher(nov13, query)
linkedToWanted = unique(linkedToWanted)

query = '  
MATCH (p:Person)-[:ASSISTED]->(attacker1:Person)-[:ATTACKED]->(l:AttackSite)
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
assistedAttacker = cypher(nov13, query)
assistedAttacker = unique(assistedAttacker)

query = '  
MATCH (p1:Person)-[:ASSISTED]->(p2:Person)
WHERE (p1.status <> "free") AND (p2.status <> "free")
RETURN p1.name, p2.name'
assistedSuspect = cypher(nov13, query)
assistedSuspect = unique(assistedSuspect)

query = '  
MATCH (p:Person)-[:BEEN_IN]->(l:Locality)<-[:BEEN_IN]-(attacker1:Person)-[:ATTACKED]->()
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
sharedSpaceWithAttacker = cypher(nov13, query)
sharedSpaceWithAttacker = unique(sharedSpaceWithAttacker)

query = '  
MATCH (p1:Person)-[:BEEN_IN]->(l:Locality)<-[:BEEN_IN]-(p2:Person)
WHERE (p1.status <> "free") AND (p2.status <> "free")
RETURN p1.name, p2.name'
sharedSpaceWithSuspect = cypher(nov13, query)
sharedSpaceWithSuspect = unique(sharedSpaceWithSuspect)

#prepare to merge
names(commonAttack) <- c("n1", "n2")
names(linkedToAttacker) <- c("n1", "n2")
names(linkedToWanted) <- c("n1", "n2")
names(assistedAttacker) <- c("n1", "n2")
names(assistedSuspect) <- c("n1", "n2")
names(sharedSpaceWithAttacker) <- c("n1", "n2")
names(sharedSpaceWithSuspect) <- c("n1", "n2")

terrorNetwork <- rbind(commonAttack, linkedToAttacker, linkedToWanted, assistedAttacker, assistedSuspect, sharedSpaceWithAttacker, sharedSpaceWithSuspect)
terrorNetworkUndirected <- rbind(terrorNetwork, data.frame(n1=terrorNetwork[["n2"]], n2=terrorNetwork[["n1"]])) 
terrorNetworkUndirected <- unique(terrorNetworkUndirected)

print(terrorNetworkUndirected) 
write.csv(terrorNetworkUndirected, file="~/nov13/nov13_terrorNetwork.csv", row.names=F)

#browse(nov13)