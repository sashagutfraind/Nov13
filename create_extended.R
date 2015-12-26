#Islamist militants in France/Belgium but not connected to KBL

#2/2012 seems like a separate network
ToulouseAndMontauban = createNode(otherNetwork, "AttackSite", name="Toulouse and Montauban shootings", killed=8, wounded=5)
MohammedMerah       = createNode(otherNetwork, "Person", name="Mohammed Merah",      age=23, gender="Male", ref1=references[["LIR1"]], status="arrested")  #http://www.lemonde.fr/societe/live/2012/03/19/direct-la-fusillade-a-toulouse_1671851_3224.html
createRel(MohammedMerah, "ATTACKED", ToulouseAndMontauban, attack_type="Shooting", ref1=references[["TODO"]])


#motivated by Al-Q not DAESH
FontenayAuxRoses = createNode(otherNetwork, "AttackSite", name="FontenayAuxRoses Shooting")
HyperCacher = createNode(otherNetwork, "AttackSite", name="HyperCacher Shooting")
Montrouge = createNode(otherNetwork, "AttackSite", name="Montrouge Shooting")
CharlieHebdo = createNode(otherNetwork, "AttackSite", name="Charlie Hebdo", killed=12, wounded=11)

#HyperCacher and related shootings
AmedyCoulibaly     = createNode(otherNetwork, "Person", name="Amedy Coulibaly",  gender="Male", nickname="Abou Bassir Abdallah al-Ifriqi", ref1=references[["NYT2"]], status="dead")
createRel(AmedyCoulibaly,  "ATTACKED", FontenayAuxRoses, ref1=references[["TODO"]])
createRel(AmedyCoulibaly,  "ATTACKED", Montrouge, ref1=references[["TODO"]])
createRel(AmedyCoulibaly,  "ATTACKED", HyperCacher, ref1=references[["TODO"]])
createRel(AmedyCoulibaly,  "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])

#CharlieHebdo -  al-Qaeda in the Arabian Peninsula not DAESH
ChérifKouachi   = createNode(otherNetwork, "Person", name="Chérif Kouachi",  gender="Male", status="dead")
SaïdKouachi     = createNode(otherNetwork, "Person", name="Saïd Kouachi",  gender="Male", status="dead")
#Djamel Begha - coordinator
#18-year-old brother-in-law of Chérif Kouachi

createRel(ChérifKouachi, "ATTACKED", CharlieHebdo, attack_type="Shooting", ref1=references[["TODO"]])
createRel(SaïdKouachi, "ATTACKED", CharlieHebdo, attack_type="Shooting", ref1=references[["TODO"]])





#https://en.wikipedia.org/wiki/2011_Li%C3%A8ge_attack
#Nordine Amrani 

#related attack on Lee Rigby was killed in Woolwich in March 2013 by Michael Adebowale and Michael Adebolajo 

#Azeddine Kbir Bounekoub
#http://www.cnn.com/2015/01/19/europe/lister-antwerp-to-aleppo-jihad/
#An outlawed group called Sharia4Belgium is suspected of arranging the travel of some would-be jihadists. Nearly fifty of its members are currently on trial in Antwerp, but almost all are being tried in absentia.