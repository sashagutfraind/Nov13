'
Additional Islamist terror networks
- linked to nov 13 attackers
'

references = list(
  NYT2="http://www.nytimes.com/interactive/2015/11/15/world/europe/manhunt-for-paris-attackers.html"
  ,LIR1="http://www.lesinrocks.com/2015/11/18/actualite/qui-est-fabien-clain-la-voix-de-daesh-11788443/"
  ,GRD1="http://www.theguardian.com/world/2015/nov/19/abdelhamid-abaaoud-dead-paris-terror-leader-leaves-behind-countless-what-ifs"
  ,WSJ3="http://www.wsj.com/articles/abdelhamid-abaaoud-alleged-mastermind-of-paris-attacks-is-dead-french-prosecutor-says-1447937255"
)

#NYT2
#Abdelhamid Abaaoud -> Katibat al-Battar al Libi



#https://en.wikipedia.org/wiki/2015_anti-terrorism_operations_in_Belgium
RedouaneHagaoui  = createNode(nov13, "Person", name="Redouane Hagaoui",      gender="Male", ref1=references[["NYT2"]], status="dead")
TarikJadaoun     = createNode(nov13, "Person", name="Tarik Jadaoun",            gender="Male", ref1=references[["NYT2"]], status="dead")
YounesAbaaoud     = createNode(nov13, "Person", name="Younes Abaaoud",      age=13,      gender="Male", ref1=references[["GRD1"]], status="wanted")
YassineAbaaoud     = createNode(nov13, "Person", name="Yassine Abaaoud",        gender="Male", ref1=references[["WSJ3"]], status="wanted")
RedaH     = createNode(nov13, "Person", name="RedaH",        ref1=references[["Reda H "]], status="wanted")

#father: OmarAbaaoud, http://www.theatlantic.com/international/archive/2015/11/who-was-abdelhamid-abaaoud-isis-paris/416739/

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
VerviersPlot = createNode(nov13, "AttackSite", name="Police attack plot in Verviers", killed=0, wounded=0, ref1=references[["DM1"]], ref2=references[["GRD1"]])

createRel(AmedyCoulibaly, "ATTACKED", CharlieHebdo, attack_type="Shooting", ref1=references[["NYT2"]])
createRel(MehdiNemmouche, "ATTACKED", BrusselsMuseum, attack_type="Shooting", ref1=references[["NYT2"]])
createRel(AyoubElKhazzani, "ATTACKED", BrusselsParisTrain, attack_type="Shooting", ref1=references[["NYT2"]])

createRel(AmedyCoulibaly,  "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])
createRel(MehdiNemmouche,  "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])
createRel(AyoubElKhazzani,  "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])

createRel(AbdelhamidAbaaoud,  "LINKED_TO", RedouaneHagaoui, note="recruited", ref1=references[["NYT2"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", TarikJadaoun,    note="recruited", ref1=references[["NYT2"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", MehdiNemmouche,    note="recruited", ref1=references[["GRD1"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", YounesAbaaoud,    note="recruited", ref1=references[["GRD1"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", YassineAbaaoud,    note="recruited", ref1=references[["GRD1"]])
createRel(RedaH,  "LINKED_TO", YassineAbaaoud,    note="recruited", ref1=references[["GRD1"]])

" He said that Abaaoud worked in Isis’s internal security unit, known as EMNI, which has the task of sending European jihadis back to their homelands to carry out terrorist attacks. The unit is run by two Tunisians, he said.
Abaaoud is said to have told the young Frenchman that he had managed to find 25kg of explosives in Belgium, but that it was too difficult for him to return to his home country himself. He was in charge of selecting candidates, who could be paid as much as €50,000 for carrying out attacks, but it was the two unnamed Tunisians who had the final decision on who would be sent."
#GRD1
#+different names?

#http://www.nytimes.com/2015/01/25/world/europe/belgium-confronts-the-jihadist-danger-within.html
#The Belgian prosecutor’s office on Wednesday partially identified the dead men for the first time, 
#naming them as Sofiane A., a Belgian and Moroccan citizen born in 1988, and Khalid B., a Belgian national born in 1991.

#Verviers was the safeway house.  the origin was in Molenbeek
#http://www.nytimes.com/2015/01/25/world/europe/belgium-confronts-the-jihadist-danger-within.html

#+additional Hebdo attackers
#Hebdo attackers apparently AlQ in Yemen (http://www.nytimes.com/2015/11/20/world/europe/paris-attacks.html)
#SuperCosher are more self-radicalized (http://www.nytimes.com/2015/11/20/world/europe/paris-attacks.html)

#ChurchPlot jointly with AbdelhamidAbaaoud
#http://abcnews.go.com/International/plots-tied-abdelhamid-abaaoud-alleged-mastermind-paris-attacks/story?id=35307009
#That incident involved Sid Ahmed Glham, a 24-year-old Algerian who moved to France in 2009. Glham is believed to have killed a French woman in her car, but then did not continue the rest of his alleged plan after he contacted authorities to call for an ambulance because he had injured himself.

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

