'
Additional Islamist terror networks
- linked to nov 13 attackers
'

references = list(
  NYT2="http://www.nytimes.com/interactive/2015/11/15/world/europe/manhunt-for-paris-attackers.html"
  ,LIR1="http://www.lesinrocks.com/2015/11/18/actualite/qui-est-fabien-clain-la-voix-de-daesh-11788443/"
)


#Abdelhamid Abaaoud -> Katibat al-Battar al Libi


#https://en.wikipedia.org/wiki/2015_anti-terrorism_operations_in_Belgium
RedouaneHagaoui     = createNode(nov13, "Person", name="Redouane Hagaoui",      gender="Male", ref1=references[["NYT2"]], status="dead")
TarikJadaoun     = createNode(nov13, "Person", name="Tarik Jadaoun",            gender="Male", ref1=references[["NYT2"]], status="dead")

AmedyCoulibaly     = createNode(nov13, "Person", name="Amedy Coulibaly",      gender="Male", ref1=references[["NYT2"]], status="dead")
MehdiNemmouche       = createNode(nov13, "Person", name="Mehdi Nemmouche",      gender="Male", ref1=references[["LOB1"]], status="arrested")
AyoubElKhazzani       = createNode(nov13, "Person", name="Ayoub El Khazzani",  age=25,    gender="Male", ref1=references[["LOB1"]], status="arrested")  #http://www.cnn.com/2015/08/24/europe/france-train-attack-what-we-know-about-suspect/
MohammedMerah       = createNode(nov13, "Person", name="Mohammed Merah",      age=23, gender="Male", ref1=references[["LIR1"]], status="arrested")  #http://www.lemonde.fr/societe/live/2012/03/19/direct-la-fusillade-a-toulouse_1671851_3224.html

createRel(MehdiNemmouche, "CITIZEN_OF", France, ref1=references[["NYT2"]])
createRel(AyoubElKhazzani, "CITIZEN_OF", Morocco, ref1=references[["NYT2"]])

BrusselsMuseum = createNode(nov13, "AttackSite", name="Brussels Museum")
BrusselsParisTrain = createNode(nov13, "AttackSite", name="Brussels Paris Train attempt", killed=0, wounded=2)
CharlieHebdo = createNode(nov13, "AttackSite", name="Charlie Hebdo", killed=0, wounded=2)
SuperCocher = createNode(nov13, "AttackSite", name="Super Cocher")
VerviersPlot = createNode(nov13, "AttackSite", name="Verviers Plot", killed=0, wounded=0, ref1=references[["DM1"]])

createRel(AmedyCoulibaly, "ATTACKED", CharlieHebdo, attack_type="Shooting", ref1=references[["NYT2"]])
createRel(MehdiNemmouche, "ATTACKED", BrusselsMuseum, attack_type="Shooting", ref1=references[["NYT2"]])
createRel(AyoubElKhazzani, "ATTACKED", BrusselsParisTrain, attack_type="Shooting", ref1=references[["NYT2"]])

createRel(AmedyCoulibaly,  "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])
createRel(MehdiNemmouche,  "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])
createRel(AyoubElKhazzani,  "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])

createRel(AbdelhamidAbaaoud,  "LINKED_TO", OmarMostefai, note="uncharacterized", ref1=references[["NYT2"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", OmarMostefai, note="uncharacterized", ref1=references[["NYT2"]])

#+additional Hebdo attackers

#http://www.rawstory.com/2015/11/the-voice-of-paris-terror-revealed-to-be-seasoned-french-jihadist-fabien-clain/
#Jean-Michel Clain
#Sid Ahmed Ghlam
#Olivier Corel

#Tirad al-Jarba, known by the nom de guerre Abu Muhammad al-Shimali,
#http://www.telegraph.co.uk/news/worldnews/europe/france/12004667/Paris-attacks-Isil-Mastermind-Abdelhamid-Abaaoud-killed-in-police-raid-on-Saint-Denis-flat-live.html?frame=3503511


#other attackers associated with Molenbeek: Ayoub El-Khazzani, Mehdi Nemmouche, Amedy Coulibaly
#Ref: NBC2, NYT1

# #arrests
# createRel(MohammadAbdeslam, "ARRESTED_IN", Belgium, date="2015-11-16", ref1=references[["IN1"]])
# createRel(MohamedAmri, "ARRESTED_IN", Belgium, date="2015-11-17", ref1=references[["DM1"]])
# createRel(HamzaAttou, "ARRESTED_IN", Belgium, date="2015-11-17", ref1=references[["IBT1"]])

