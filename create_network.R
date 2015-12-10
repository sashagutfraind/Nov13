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
- separate out the core attackers;  then show the extended links
Use Cypher query
== show the attack sites (:AttackSite)
== show links between attackers

- rename network nov13 as KBL

Wishlist:
- homes and citizenship of the attackers, particularly French residents
- write down "missions" like smuggling, driving;  then link people to missions

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
                  ,SC1="http://www.un.org/press/en/2014/sc11521.doc.htm"
                  ,NYT3="http://www.nytimes.com/2015/11/20/world/europe/paris-attacks.html"
                  ,CNN2="http://www.cnn.com/2015/11/21/world/paris-attacks/index.html"
                  ,CNN3="http://www.cnn.com/2015/11/22/world/paris-attacks/"
                  ,GRD1="http://www.theguardian.com/world/2015/nov/19/abdelhamid-abaaoud-dead-paris-terror-leader-leaves-behind-countless-what-ifs"
                  ,NYT4="http://www.nytimes.com/2015/11/23/world/europe/brussels-remains-on-highest-alert-level-as-manhunts-expand.html?_r=0"
                  ,WSJ2="http://www.wsj.com/articles/brussels-on-edge-as-lockdown-continues-1448280916"
                  ,ABC1="http://abcnews.go.com/International/paris-ringleader-planned-attack-major-business-district-days/story?id=35398532"
                  ,FOX1="http://www.foxnews.com/world/2015/11/25/french-authorities-say-paris-terror-mastermind-returned-to-attack-sites-that/"
                  ,DM2="http://www.dailymail.co.uk/news/article-3331781/Soldiers-stay-streets-Brussels-WEEK-schools-metro-remain-closed-terror-attack-fears-EU-staff-warned-stay-home.html"
                  ,LI1="http://www.linternaute.com/actualite/societe/1258168-abbdulakbak-b-ahmed-et-mohammed-almuhamed-un-terroriste-de-paris-infiltre-chez-les-migrants/"
                  ,FOX2="http://www.foxnews.com/world/2015/11/27/germany-arrests-man-reportedly-suspected-selling-guns-to-paris-attackers/"
                  ,NYT4="http://www.nytimes.com/2015/12/01/world/europe/how-the-paris-attackers-honed-their-assault-through-trial-and-error.html?partner=rss&emc=rss&_r=0"
                  ,AT1="http://atimes.com/2015/11/paris-made-in-libya-not-syria/"
                  ,F24a="http://www.france24.com/en/20151205-paris-attacks-spotlight-turns-britain"
                  ,ST1="http://www.straitstimes.com/world/europe/paris-attacks-belgium-charges-2-new-suspects"
                  ,TL1="http://www.thelocal.fr/20151205/belgium-seeks-two-new-dangerous-paris-attack-suspects"
                  ,IBT2="http://www.ibtimes.co.in/abdeslam-brothers-known-interpol-eus-security-database-before-paris-attacks-658236"
                  ,CBS1="http://www.cbsnews.com/news/paris-attacks-suspects-arrested-belgium-authorities/"
                  ,CNN4="http://www.cnn.com/2015/12/03/europe/salah-abdeslam-cold-trail-paris-attacks/"
                  ,GRD2="http://www.theguardian.com/world/2015/dec/09/paris-attacks-third-bataclan-attacker-identified-by-police"
                  ,TEL2="http://www.telegraph.co.uk/news/worldnews/europe/france/12041026/Third-Bataclan-attacker-identified-as-Foued-Mohamed-Aggad-who-visited-Syria-in-2013.html"
                  )

AbdeilahChouaa = createNode(nov13, "Person", name="Abdeilah Chouaa", gender="Male", status="arrested", ref1=references[["ST1"]])
AbuMuhammadAlAdnani = createNode(nov13, "Person", name="Abu Muhammad al-Adnani", age=38, gender="Male", status="wanted", ref1=references[["SC1"]])
AbuMuhammadAlShimali = createNode(nov13, "Person", name="Abu-Muhammad al-Shimali", gender="Male", status="wanted", ref1=references[["GRD1"]])

AbdelhamidAbaaoud = createNode(nov13, "Person", name="Abdelhamid Abaaoud", age=27, gender="Male", nickname="Abu Omar al-Belgiki", nickname2="Abou Omar al-Soussi",  ref1=references[["DM1"]], status="dead", ref2=references[["WP1"]],  ref3=references[["FT1"]])

AhmetDahmani = createNode(nov13, "Person", name="Ahmet Dahmani", age=26, gender="Male", role="Scout", ref1=references[["CNN2"]], status="arrested")
AhmetTahir = createNode(nov13, "Person", name="Ahmet Tahir", age=29, gender="Male", ref1=references[["CNN2"]], status="arrested")

MohammedVerd = createNode(nov13, "Person", name="Mohammed Verd", age=23, gender="Male", ref1=references[["CNN2"]], status="arrested")

AliOulkadi        = createNode(nov13, "Person", name="Ali Oulkadi",       age=29, gender="Male", ref1=references[["DM2"]], status="arrested")
BilalHadfi        = createNode(nov13, "Person", name="Bilal Hadfi",        age=20, gender="Male", ref1=references[["DM1"]], status="dead")
FabianClain       = createNode(nov13, "Person", name="Fabian Clain",      age=36, gender="Male", nickname="Omar", ref1=references[["LIR1"]], status="wanted")
FouedMohamedAggad = createNode(nov13, "Person", name="Foued Mohamed-Aggad",  age=23, gender="Male", ref1=references[["DM1"]], ref2=references[["GRD2"]], status="dead")
HamzaAttou        = createNode(nov13, "Person", name="Hamza Attou",         age=21,  gender="Male", ref1=references[["IBT1"]], status="arrested")
IbrahimAbdeslam   = createNode(nov13, "Person", name="Ibrahim Abdeslam",    age=31, gender="Male", nickname="Brahim", ref1=references[["DM1"]], status="dead")
AbraimiLazez      = createNode(nov13, "Person", name="Abraimi Lazez",    age=39, gender="Male", ref1=references[["NYT4"]], status="arrested")
JawadBenDow       = createNode(nov13, "Person", name="Jawad Ben Dow",      age=27, gender="Male", ref1=references[["LOB1"]], ref2=references[["CNN3"]], status="arrested")
MohammadAbdeslam  = createNode(nov13, "Person", name="Mohammad Abdeslam",          gender="Male",  ref1=references[["DM1"]], status="free")
MohamedAbrini     = createNode(nov13, "Person", name="Mohamed Abrini",       age=30, gender="Male", ref1=references[["ABC1"]], status="wanted")
MohamedAmimour    = createNode(nov13, "Person", name="Mohamed Amimour",     age=67, gender="Male", ref1=references[["DM1"]], status="free")
MohamedBakkali    = createNode(nov13, "Person", name="Mohamed Bakkali",       gender="Male", ref1=references[["ST1"]], status="wanted")
MohamedAmri       = createNode(nov13, "Person", name="Mohamed Amri",         age=27, gender="Male", ref1=references[["DM1"]], status="arrested")
MohamedKhoualed   = createNode(nov13, "Person", name="Mohamed Khoualed",     age=19, gender="Male", ref1=references[["TEL1"]], status="arrested")
OmarMostefai      = createNode(nov13, "Person", name="Omar Ismaïl Mostefaï", age=29, gender="Male", ref1=references[["DM1"]], status="dead")
SalahAbdeslam     = createNode(nov13, "Person", name="Salah Abdeslam",       age=26, gender="Male", ref1=references[["DM1"]], status="wanted")
SamyAmimour       = createNode(nov13, "Person", name="Samy Amimour",         age=28, gender="Male", ref1=references[["DM1"]], status="dead")

#the unknowns from Nov 13
#AbbdulakbakB     = createNode(nov13, "Person", name="AbbdulakbakB",  age=25, gender="Male", ref1=references[["DM1"]], ref2=references[["LI1"]], status="dead", note="possibly fake passport or avictim_s name")
StadeUnknown     = createNode(nov13, "Person", name="StadeUnknown",  age=20, gender="Male",  ref1=references[["DM1"]],  ref3=references[["FT1"]], status="dead")
AhmedAlmuhamed    = createNode(nov13, "Person", name="Fake ID as Ahmed Almuhamed",  gender="Male", ref1=references[["DM1"]], status="dead")
StDenisUnknown     = createNode(nov13, "Person", name="Unknown dead at St. Denis",   gender="Male", status="dead", ref1=references[["CNN3"]])

Montenegrin      = createNode(nov13, "Person", name="Montenegrin",  age=51, ref1=references[["FT1"]], status="arrested")
#two individuals: 
#Sasha V., who was detained in Magstadt
#Vladan Vuchelichem (51 y.o.) from Podgorica
#The car navigator endpoint was a public (city) car park in Paris, and in V.Vuchelich's possession were several French operators' phone cards and addresses in France.
#http://peacekeeper.ru/en/?module=news&action=view&id=28525

BrusselsUnknown  = createNode(nov13, "Person", name="BrusselsUnknown", ref1=references[["WSJ2"]], status="arrested")
#TODO possibly one of the people below

MohamedS         = createNode(nov13, "Person", name="MohamedS", age=25, gender="Male", role="petty criminal assisted with finding safe house", ref1=references[["F24a"]], status="arrested")
#apparently not the BrusselsUnknown

SoufianeKayal    = createNode(nov13, "Person", name="False ID as Soufiane Kayal", gender="Male", role="helped Abaaoud travel to Hungary", ref1=references[["TL1"]], status="wanted")
SamirBouzid      = createNode(nov13, "Person", name="False ID as Samir Bouzid", gender="Male",    role="helped Abaaoud travel to Hungary", ref1=references[["TL1"]], status="wanted")


HasnaAitboulahcen  = createNode(nov13, "Person", name="Hasna Aitboulahcen",         age=26,   gender="Female",  status="dead", ref1=references[["LOB1"]], ref2=references[["NP1"]], ref3=references[["CNN3"]])

#+explosion in Charleville-Mezieres
#http://www.cnn.com/2015/11/19/europe/paris-attacks-at-a-glance/

ArmsDealer = createNode(nov13, "Person", name="German Arms Dealer", age=35, gender="Male", ref1=references[["FOX2"]])
#unclear buyer "Arab in Paris" on Nov 7

#linked to Bilal
SamirZ = createNode(nov13, "Person", age=20, name="Samir Z", gender="Male", ref1=references[["IBT2"]], ref2=references[["ST1"]], ref3=references[["CBS2"]],  status="arrested")
PierreN = createNode(nov13, "Person", age=28, name="Pierre N", gender="Male", ref1=references[["IBT2"]], ref2=references[["ST1"]], status="arrested")

#Abaood was linked to unknown people in the UK
#http://www.arabtimesonline.com/news/paris-attacker-visited-london-report-belgium-seeks-2-new-dangerous-attack-suspects/

################
#ADDITION NOTES
################
#+a 30-year-old man who was detained on his way back from Syria tiped
#http://www.dailymail.co.uk/news/article-3321715/The-rented-home-ISIS-fanatics-plotted-Paris-massacre-Landlady-says-terrorists-plotted-atrocity-apartment-nice-proper-dressed-men-didn-t-beards.html

#Mr. Hadfi, who is a French citizen, lived in the Neder-over-Heembeek district of Brussels with his mother and three other siblings.
#http://www.nytimes.com/2015/11/20/world/europe/paris-attacks.html

#+addition connections to Reunion/Toulouse group and Mohamed Merah
#http://www.lesinrocks.com/2015/11/18/actualite/qui-est-fabien-clain-la-voix-de-daesh-11788443/

#+father and brother of Ismaeël
#http://pamelageller.com/2015/11/french-muslim-ismael-omar-mostefai-and-abbdulakbak-b-suicide-bombers-named-in-paris-terror-attack.html/

#http://www.dailymail.co.uk/news/article-3331781/Soldiers-stay-streets-Brussels-WEEK-schools-metro-remain-closed-terror-attack-fears-EU-staff-warned-stay-home.html
#ramming attack

#arrests with seizures
#http://www.ibtimes.com/paris-terror-attacks-france-knew-attacks-were-being-planned-pm-says-police-arrest-2185625

#Katibat al-Battar, or Battar Brigade, an elite squad made up of French-speaking fighters
#NYT4

#Aine Lesley Davis, a British ISIS operative
#http://www.cnn.com/2015/12/03/europe/salah-abdeslam-cold-trail-paris-attacks/

#Abood is not the overall mastermind
#http://www.cnn.com/2015/12/03/europe/salah-abdeslam-cold-trail-paris-attacks/

#female walk-in
#http://www.cnn.com/2015/12/03/europe/salah-abdeslam-cold-trail-paris-attacks/

#GRD2: cousin and recruiter of FouedMohamedAggad
#Mourad Fares arrested (recuiter)
#Karim Aggad
#French media say two of the Strasbourg group, brothers Mourad and Yassine Boudjellal, were killed at a checkpoint early last year.
#http://www.bbc.com/news/world-europe-35055304
#A cell of 9 people: 7 were arrested in Strassbourg
#http://www.telegraph.co.uk/news/worldnews/europe/france/12041026/Third-Bataclan-attacker-identified-as-Foued-Mohamed-Aggad-who-visited-Syria-in-2013.html
#(TEL2)

#countries
#Belgium = createNode(nov13, "Country", name="Belgium")
#Egypt  = createNode(nov13, "Country", name="Egypt")
Greece  = createNode(nov13, "Country", name="Greece")
#France = createNode(nov13, "Country", name="France")
#Morocco = createNode(nov13, "Country", name="Morocco")
Syria = createNode(nov13, "Country", name="Syria")
Turkey = createNode(nov13, "Country", name="Turkey")

#localities / sites
Alfortsville  = createNode(nov13, "Locality", name="Alfortsville")
Auvelais      = createNode(nov13, "Locality", name="Auvelias", role="suspected planning site and bomb making")
Bobigny       = createNode(nov13, "Locality", name="Bobigny")
Molenbeek     = createNode(nov13, "Locality", name="Molenbeek", location="various")
StDenis       = createNode(nov13, "Locality", name="St.Denis", location="8 rue du Carillon and rue Carnot", ref1=references[["NBC1"]])
#wishlist: second location in St.Denis

#attack sites.  for casualties see WP2
Arrondisement18  = createNode(nov13, "AttackSite", name="Unknown in Arrondisement 18", killed=0, wounded=0, outcome="aborted")
Bataclan         = createNode(nov13, "AttackSite", name="Bataclan", killed=89, wounded=200)
ComptoirVoltaire = createNode(nov13, "AttackSite", name="Comptoir Voltaire", killed=0, wounded=3, ref1=references[["DM1"]])
LaBonneBiere     = createNode(nov13, "AttackSite", name="La Bonne Biere", killed=0, wounded=0)
LaBelleEquipe    = createNode(nov13, "AttackSite", name="La Belle Equipe", killed=19, wounded=9)
LaCasaNostra     = createNode(nov13, "AttackSite", name="La Casa Nostra", killed=5, wounded=8)
LaDefense        = createNode(nov13, "AttackSite", name="Unknown in La Defense", outcome="aborted", ref=references[["ABC1"]])
LeCarillonBarAndLePetitCambodge    = createNode(nov13, "AttackSite", name="Le Carillon Bar and Le Petit Cambodge", killed=15, injured=10)
StadeDeFrance    = createNode(nov13, "AttackSite", name="Stade de France", killed=1, wounded=0)

#locations where the network might have formed
createRel(AbuMuhammadAlAdnani,  "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(FabianClain,          "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(FouedMohamedAggad,          "BEEN_IN", Syria, ref1=references[["GRD2"]])
createRel(AbuMuhammadAlShimali, "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Molenbeek, ref1=references[["DM1"]])
createRel(IbrahimAbdeslam,    "BEEN_IN", Molenbeek, ref1=references[["NBC2"]])
createRel(SamirZ,    "BEEN_IN", Molenbeek, ref1=references[["ST1"]])
createRel(PierreN,    "BEEN_IN", Molenbeek, ref1=references[["ST1"]])
createRel(MohamedBakkali,     "BEEN_IN", Auvelais, ref1=references[["ST1"]])
createRel(BilalHadfi,         "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(OmarMostefai,       "BEEN_IN", Turkey, date="2010", ref1=references[["DM1"]])
createRel(OmarMostefai,       "BEEN_IN", Syria, date="2013", ref1=references[["DM1"]])
createRel(SalahAbdeslam,      "BEEN_IN", Molenbeek, ref1=references[["NBC2"]])
createRel(SamyAmimour,        "BEEN_IN", Syria, ref1=references[["NEW2"]])

#StDennis
createRel(AbdelhamidAbaaoud,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(HasnaAitboulahcen,  "BEEN_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDenisUnknown,     "BEEN_IN", StDenis, ref1=references[["CNN3"]])
createRel(JawadBenDow,        "BEEN_IN", StDenis, ref1=references[["LOB1"]])

#staging for attack
createRel(SalahAbdeslam, "BEEN_IN", Alfortsville, ref1=references[["DM1"]])
createRel(IbrahimAbdeslam, "BEEN_IN", Bobigny, ref1=references[["DM1"]])
createRel(SalahAbdeslam, "BEEN_IN", Bobigny, ref1=references[["DM1"]])
createRel(SamyAmimour, "BEEN_IN", Bobigny, ref1=references[["DM1"]])

#lesser sites
#createRel(HasnaAitboulahcen,  "BEEN_IN", AulnaySousBois, ref1=references[["CNN2"]]) #http://www.cnn.com/2015/11/19/europe/paris-attacks-at-a-glance/
#createRel(MohamedKhoualed,  "BEEN_IN", Roubaix, ref1=references[["TEL1"]])

## complicates plotting a bit.  FIXME: make it an attribute
# #residence by country
# createRel(AbdelhamidAbaaoud,  "LIVED_IN", Belgium, ref1=references[["LOB1"]])
# createRel(BilalHadfi, "LIVED_IN", Belgium, ref1=references[["NYT2"]])
# createRel(IbrahimAbdeslam, "LIVED_IN", Belgium, ref1=references[["NYT2"]])
# createRel(MohamedKhoualed, "LIVED_IN", Belgium, ref1=references[["TEL1"]])
# createRel(OmarMostefai, "LIVED_IN", France, ref1=references[["NYT2"]], note="Courcouronnes, near Paris", ref2=references[["NYT4"]])
# createRel(SalahAbdeslam, "LIVED_IN", Belgium, ref1=references[["NYT2"]])
# createRel(SamyAmimour, "LIVED_IN", France, ref1=references[["NYT2"]], note="Drancy, near Paris", ref2=references[["NYT4"]])
# 

#other KBL fighters
#https://pietervanostaeyen.wordpress.com/2015/01/21/katibat-al-battar-and-the-belgian-fighters-in-syria/

# #transit countries
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Greece, ref1=references[["EXP1"]])
createRel(AhmedAlmuhamed,     "BEEN_IN", Greece, ref1=references[["EXP1"]])

#TODO: link to specific attacker
createRel(AhmetDahmani,     "BEEN_IN", Turkey, ref1=references[["CNN2"]])
createRel(AhmetDahmani,     "BEEN_IN", Syria, ref1=references[["CNN2"]])
#createRel(AhmetDahmani,     "BEEN_IN", France, ref1=references[["CNN2"]])

createRel(MohammedVerd,     "BEEN_IN", Turkey, ref1=references[["CNN2"]])
createRel(MohammedVerd,     "BEEN_IN", Syria, ref1=references[["CNN2"]])
createRel(AhmetTahir,       "BEEN_IN", Turkey, ref1=references[["CNN2"]])
createRel(AhmetTahir,       "BEEN_IN", Syria, ref1=references[["CNN2"]])

#friend and familiar affiliations
createRel(SalahAbdeslam,     "LINKED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(SalahAbdeslam,     "LINKED_TO", MohammadAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(MohammadAbdeslam , "LINKED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(MohamedAmimour,    "LINKED_TO", SamyAmimour, note="father_of", ref1=references[["DM1"]])
createRel(HasnaAitboulahcen, "LINKED_TO", AbdelhamidAbaaoud, note="cousin", ref1=references[["IBT2"]])
createRel(SalahAbdeslam,     "LINKED_TO", AbdelhamidAbaaoud, note="friends", ref1=references[["CNN1"]])

createRel(AbdelhamidAbaaoud,  "LINKED_TO", OmarMostefai, note="uncharacterized", ref1=references[["NYT2"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", BilalHadfi, note="led in Syria", ref1=references[["NYT2"]])

createRel(SamirZ,  "LINKED_TO", BilalHadfi, ref1=references[["IBT2"]])
createRel(PierreN, "LINKED_TO", BilalHadfi, ref1=references[["IBT2"]])


createRel(AhmetDahmani,     "LINKED_TO", SalahAbdeslam, ref1=references[["CNN4"]])

## complicates plotting a bit.  because it's relatively stable, use as attribute.
# #citizenship.  we allow multiple citizenships.  weak indicator of affinity between individuals
# createRel(AbdelhamidAbaaoud, "CITIZEN_OF", Belgium, ref1=references[["DM1"]])
# createRel(AbdelhamidAbaaoud, "CITIZEN_OF", Morocco, ref1=references[["NEW1"]])
# createRel(BilalHadfi,        "CITIZEN_OF", France, ref1=references[["DM1"]])
# createRel(StDEgyptianA,      "CITIZEN_OF", Egypt, ref1=references[["DM1"]])
# createRel(StDEgyptianB,      "CITIZEN_OF", Egypt, ref1=references[["DM1"]])
# createRel(IbrahimAbdeslam,   "CITIZEN_OF", France, ref1=references[["DM1"]])
# createRel(MohamedAmri,       "CITIZEN_OF", France, ref1=references[["DM1"]])
# createRel(OmarMostefai,      "CITIZEN_OF", France, ref1=references[["DM1"]])
# createRel(SalahAbdeslam,     "CITIZEN_OF", France, ref1=references[["NYT2"]])
# createRel(SamyAmimour,       "CITIZEN_OF", France, ref1=references[["DM1"]])
# createRel(AbraimiLazez,       "CITIZEN_OF", Belgium, ref1=references[["NYT4"]])
# createRel(FouedMohamedAggad,       "CITIZEN_OF", Belgium, ref1=references[["GRD2"]])
# 

# createRel(AhmetDahmani,       "CITIZEN_OF", Belgium, ref1=references[["CNN2"]])
# createRel(AhmetDahmani,       "CITIZEN_OF", Morocco, ref1=references[["CNN2"]])
# createRel(AhmetTahir,         "CITIZEN_OF", Syria, ref1=references[["CNN2"]])
# createRel(MohammedVerd,       "CITIZEN_OF", Syria, ref1=references[["CNN2"]])

#probable involvement in the plot
createRel(MohamedAmri, "ASSISTED", SalahAbdeslam, note="drove", ref1=references[["DM1"]])
createRel(HamzaAttou,  "ASSISTED", SalahAbdeslam, note="drove", ref1=references[["DM1"]])
createRel(HamzaAttou,  "ASSISTED", MohamedAmri,   note="drove", ref1=references[["DM1"]])

#Stade ride
createRel(SalahAbdeslam, "ASSISTED", AhmedAlmuhamed,  note="drove", ref1=references[["FOX1"]])
createRel(SalahAbdeslam, "ASSISTED", BilalHadfi,  note="drove", ref1=references[["FOX1"]])  
createRel(SalahAbdeslam, "ASSISTED", StadeUnknown,  note="drove", ref1=references[["FOX1"]])  

#Daesh core
createRel(FabianClain,  "ASSISTED", AbdelhamidAbaaoud, note="publicized", ref1=references[["DM1"]])
createRel(AbuMuhammadAlAdnani, "ASSISTED", FabianClain, note="directed", ref1=references[["NYT3"]], ref2=references[["NYT4"]])
createRel(AbuMuhammadAlShimali, "ASSISTED", AbdelhamidAbaaoud, note="directed", ref1=references[["GRD1"]])

#in Belgium
createRel(MohamedKhoualed,  "ASSISTED", SalahAbdeslam, note="explosives", ref1=references[["TEL1"]])
createRel(AbraimiLazez,     "ASSISTED", SalahAbdeslam, note="unspecified assistence", ref1=references[["NYT4"]])
createRel(MohamedAbrini,    "ASSISTED",  SalahAbdeslam, note="drove", ref1=references[["ABC1"]])
createRel(AliOulkadi,       "ASSISTED",  SalahAbdeslam, note="drove Salah Abdeslam", ref1=references[["DM2"]], ref2=references[["TL1"]])

createRel(MohammedVerd,  "ASSISTED", AhmetDahmani, note="smuggling", ref1=references[["TEL1"]])
createRel(AhmetTahir,    "ASSISTED", AhmetDahmani, note="smuggling", ref1=references[["TEL1"]])
createRel(AhmetTahir,    "ASSISTED", MohammedVerd, note="smuggling", ref1=references[["TEL1"]])

#mission in Hungary
createRel(SoufianeKayal, "ASSISTED", AbdelhamidAbaaoud, note="assisted in Hungary", ref1=references[["TL1"]])
createRel(SamirBouzid, "ASSISTED", AbdelhamidAbaaoud,   note="assisted in Hungary", ref1=references[["TL1"]])
createRel(SamirBouzid, "ASSISTED", SoufianeKayal,       note="assisted in Hungary", ref1=references[["TL1"]])

#mission in Hungary
createRel(SamirBouzid, "ASSISTED", HasnaAitboulahcen,   note="transfer money after the attack", ref1=references[["TL1"]])

#Auvelias - planning site
createRel(SamirBouzid, "BEEN_IN", Auvelais,   note="suspected hideout", ref1=references[["TL1"]])
#according to some source, it was SoufianeKayal http://en.europeonline-magazine.eu/belgium-searching-for-two-new-suspects-linked-to-paris-attacks_427737.html



#attacks
createRel(IbrahimAbdeslam, "ATTACKED", ComptoirVoltaire, attack_type="Suicide", ref1=references[["DM1"]])
createRel(OmarMostefai,    "ATTACKED",  Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
createRel(SamyAmimour,     "ATTACKED", Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
#createRel(AbbdulakbakB,     "ATTACKED",  Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
createRel(FouedMohamedAggad, "ATTACKED", Bataclan, attack_type="Suicide", ref1=references[["DM1"]])
#only 3 detonated.  several (all?) shot.  Volkswagen Polo abandoned at site

createRel(AhmedAlmuhamed, "ATTACKED", StadeDeFrance, attack_type="Suicide", ref1=references[["DM1"]])
createRel(BilalHadfi,     "ATTACKED", StadeDeFrance, attack_type="Suicide", ref1=references[["DM1"]])  
createRel(StadeUnknown,   "ATTACKED", StadeDeFrance, attack_type="Suicide", note="detonated at nearby MacDonalds",  ref1=references[["DM1"]], ref2=references[["WSJ1"]])  

#gunmen in a black Seat Leon.  possibly Abdeslam brothers + unknown
#http://www.lefigaro.fr/actualite-france/2015/11/18/01016-20151118ARTFIG00346-ce-que-l-on-sait-du-commando-qui-a-seme-la-terreur-a-paris.php
createRel(IbrahimAbdeslam, "ATTACKED", LeCarillonBarAndLePetitCambodge, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LeCarillonBarAndLePetitCambodge, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "ATTACKED", LeCarillonBarAndLePetitCambodge, attack_type="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaCasaNostra, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LaCasaNostra, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "ATTACKED", LaCasaNostra, attack_type="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaBonneBiere, attack_type="Shooting", ref1=references[["NEW2"]])  
createRel(SalahAbdeslam, "ATTACKED", LaBonneBiere, attack_type="Shooting", ref1=references[["NEW2"]])  
createRel(AbdelhamidAbaaoud, "ATTACKED", LaBonneBiere, attack_type="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaBelleEquipe, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LaBelleEquipe, attack_type="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "ATTACKED", LaBelleEquipe, attack_type="Shooting", ref1=references[["FOX1"]])  

#suspected attack 1
createRel(SalahAbdeslam, "ATTACKED", Arrondisement18, attack_type="Unknown", ref1=references[["DM1"]])

#suspected attack 2
createRel(AbdelhamidAbaaoud, "ATTACKED", LaDefense, attack_type="Suicide", ref1=references[["ABC1"]])
createRel(StDenisUnknown,    "ATTACKED", LaDefense, attack_type="Suicide", ref1=references[["ABC1"]])

#suspected attack 2?
#+8 arrested in Saint Dennis with force 2015-11-18, http://www.nydailynews.com/news/world/paris-raid-killed-2-terror-suspects-time-article-1.2438743
#TARGETED Airport, Shopping Mall

#StDenis safe house
createRel(HasnaAitboulahcen, "LINKED_TO", MohamedS, note="knew", ref1=references[["DM1"]])
createRel(MohamedS,          "LINKED_TO", JawadBenDow, note="knew", ref1=references[["DM1"]])



########################################################
#print("Export")
########################################################
nov13nodes = cypher(nov13, query='MATCH (p) return p.name') 
write.csv(nov13nodes, file="~/nov13/nov13_nodes.csv")

nov13persons = cypher(nov13, query='MATCH (p:Person) return p.name') 
write.csv(nov13persons, file="~/nov13/nov13_persons.csv")

nov13relationships = cypher(nov13, query='MATCH (n1)-[r]->(n2) return n1.name, type(r), n2.name') 
write.csv(nov13relationships, file="~/nov13/nov13_relationships.csv" )

#requires neo4j database
#browse(nov13)

query = '  
MATCH (p:Person)-[:ATTACKED]->(s:AttackSite)
RETURN p.name, s.name'
attackersAndSites = cypher(nov13, query)
attackersAndSites = unique(attackersAndSites)
print(attackersAndSites)  
write.csv(attackersAndSites, file="~/nov13/nov13_attackersAndSites.csv" )


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
MATCH (p1:Person)-[:ASSISTED]-(p2:Person)
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