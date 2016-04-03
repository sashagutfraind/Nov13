#Islamist militants in France/Belgium but not connected to KBL

#2/2012 seems like a separate network
ToulouseAndMontauban = createNode(otherNetwork, "AttackSite", name="Toulouse and Montauban shootings", killed=8, wounded=5)
MohammedMerah       = createNode(otherNetwork, "Person", name="Mohammed Merah",      age=23, gender="Male", ref1=references[["LIR1"]], status="arrested")  #http://www.lemonde.fr/societe/live/2012/03/19/direct-la-fusillade-a-toulouse_1671851_3224.html
createRel(MohammedMerah, "ATTACKED", ToulouseAndMontauban, attack_type="Shooting", ref1=references[["TODO"]])


#motivated by Al-Q not DAESH
CharlieHebdo = createNode(otherNetwork, "AttackSite", name="Charlie Hebdo", killed=12, wounded=11)

#CharlieHebdo -  al-Qaeda in the Arabian Peninsula not DAESH
ChérifKouachi   = createNode(otherNetwork, "Person", name="Chérif Kouachi",  gender="Male", status="dead")
SaïdKouachi     = createNode(otherNetwork, "Person", name="Saïd Kouachi",  gender="Male", status="dead")
#Djamel Begha - coordinator
#18-year-old brother-in-law of Chérif Kouachi

createRel(ChérifKouachi, "ATTACKED", CharlieHebdo, attack_type="Shooting", ref1=references[["TEL5"]])
createRel(SaïdKouachi, "ATTACKED", CharlieHebdo, attack_type="Shooting", ref1=references[["TEL5"]])
createRel(ChérifKouachi, "LINKED_TO", SaïdKouachi, note="brother", ref1=references[["TEL5"]])

createRel(ChérifKouachi, "BEEN_IN", Syria, date="summer 2014", ref1=references[["TEL5"]])
createRel(SaïdKouachi, "BEEN_IN", Syria, date="summer 2014", ref1=references[["TEL5"]])

AbderahmaneAmeroud  = createNode(kblDB, "Person", name="Abderahmane Ameroud", age=27, gender="Male", citizenship="Algers", ref1=references[["NYT14"]], status="arrested")
#assisted assassination of Massoud in 2005

#apparently a separate blog


#"Cannes-Torcy" group - an earlier plot from 2012
#CNN4
#Ibrahim Boudina, a 23-year-old French national born in Algiers
#...Boudina had set off for Syria in late September 2012 with a childhood friend -- 
#http://www.nytimes.com/2016/03/29/world/europe/isis-attacks-paris-brussels.html?_r=0

#Abdelkader Tliba, a French-Tunisian 
#Jeremie Louis-Sidney
#... On October 6, 2012, Louis-Sidney was killed in a shootout with police in Strasbourg after resisting arrest. 
#+police informant / friend 

#2014
#On June 22 of that year, a 24-year-old French citizen named 
Faiz Bouchrane
#, who had trained in Syria, was smuggled into neighboring Lebanon. 
#He was planning to blow himself up at a Shiite target, and during interrogation, he let slip the name of the man who had ordered him to carry out the operation: 
#Abu Muhammad al-Adnani.

#decapitation
#http://www.nytimes.com/2015/06/27/world/europe/french-factory-lyon-attack-isis.html

#police station attack
#http://www.nytimes.com/2014/12/24/world/europe/french-authorities-appeal-for-calm-after-string-of-attacks.html

#Auftragtaktik:
#http://foreignpolicy.com/2011/09/09/an-elusive-command-philosophy-and-a-different-command-culture/
#three types of attacks: large-scale, coordinated, inspired

#https://en.wikipedia.org/wiki/2011_Li%C3%A8ge_attack
#Nordine Amrani 

#related attack on Lee Rigby was killed in Woolwich in March 2013 by Michael Adebowale and Michael Adebolajo 

#Azeddine Kbir Bounekoub
#http://www.cnn.com/2015/01/19/europe/lister-antwerp-to-aleppo-jihad/
#An outlawed group called Sharia4Belgium is suspected of arranging the travel of some would-be jihadists. Nearly fifty of its members are currently on trial in Antwerp, but almost all are being tried in absentia.