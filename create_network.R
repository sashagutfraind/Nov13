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


library(RNeo4j)

#name of the database
kblDB = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  
clear(kblDB, input=FALSE)  

#test code
#t1 = createNode(kblDB, "testType", name="t1", dt=2015.1113, v1=2)
#t2 = createNode(kblDB, "testType", name="t2", dt=2015.1113)

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
                  ,NYT5="http://www.nytimes.com/2015/12/01/world/europe/how-the-paris-attackers-honed-their-assault-through-trial-and-error.html?partner=rss&emc=rss&_r=0"
                  #wishlist not cited.  distinguish with NYT4
                  ,NYT6=""
                  ,NYT7="http://www.nytimes.com/2015/12/25/world/europe/paris-attacks-belgium.html?_r=0"
                  ,AT1="http://atimes.com/2015/11/paris-made-in-libya-not-syria/"
                  ,F24a="http://www.france24.com/en/20151205-paris-attacks-spotlight-turns-britain"
                  ,ST1="http://www.straitstimes.com/world/europe/paris-attacks-belgium-charges-2-new-suspects"
                  ,TL1="http://www.thelocal.fr/20151205/belgium-seeks-two-new-dangerous-paris-attack-suspects"
                  ,IBT2="http://www.ibtimes.co.in/abdeslam-brothers-known-interpol-eus-security-database-before-paris-attacks-658236"
                  ,CBS1="http://www.cbsnews.com/news/paris-attacks-suspects-arrested-belgium-authorities/"
                  ,CNN4="http://www.cnn.com/2015/12/03/europe/salah-abdeslam-cold-trail-paris-attacks/"
                  ,GRD2="http://www.theguardian.com/world/2015/dec/09/paris-attacks-third-bataclan-attacker-identified-by-police"
                  ,TEL2="http://www.telegraph.co.uk/news/worldnews/europe/france/12041026/Third-Bataclan-attacker-identified-as-Foued-Mohamed-Aggad-who-visited-Syria-in-2013.html"
                  ,DM3="http://www.dailymail.co.uk/news/article-3355624/Europe-s-wanted-man-escaped-Africa-Police-Morroco-issue-arrest-warrants-Paris-gunman-Salah-Abdeslam-accomplice-tip-spies.html"
                  ,VOA1="http://www.voaafrique.com/content/la-justice-belge-prolonge-la-dentention-provisoire-de-deux-terroristes-presumes-/3099044.html"
                  ,BBC1="http://www.bbc.com/news/world-europe-34896521"
                  ,IND1="http://www.independent.co.uk/news/world/europe/france-attacks-is-this-the-face-of-paris-suicide-bomber-ahmed-almohammad-a6735216.html"
                  ,TRIB1="http://trib.com/news/national/europe/the-latest-germany-arms-dealer-didn-t-supply-paris-guns/article_5135cc41-4b3c-5921-9107-04049f9f5c0a.html"
                  
                  ,WSJ3="http://www.wsj.com/articles/abdelhamid-abaaoud-alleged-mastermind-of-paris-attacks-is-dead-french-prosecutor-says-1447937255"
                  ,LMD1="http://www.lemonde.fr/societe/article/2015/11/25/olivier-corel-le-mentor-de-djihadistes-francais-a-ete-place-en-garde-a-vue_4817063_3224.html"
                  ,LP2="http://www.leparisien.fr/faits-divers/l-ombre-d-abaaoud-derriere-les-attentats-de-paris-17-11-2015-5285037.php"
                  ,DM4="http://www.dailymail.co.uk/news/article-2912966/Belgium-jihadists-killed-anti-terror-officers-planning-kidnap-policeman-judge-decapitate-video.html"
                  ,TEL3="http://www.telegraph.co.uk/news/worldnews/europe/greece/11353214/Greek-police-detain-suspected-ringleader-of-Belgian-terror-cell-says-source.html"
                  ,NYT8="http://www.nytimes.com/2015/12/27/world/europe/schools-warnings-about-paris-attacker-were-not-passed-on.html"
                  ,REU1="http://www.reuters.com/article/us-mideast-crisis-islamicstate-strikes-idUSKBN0UC1B220151229"
                  ,LP3="http://www.leparisien.fr/faits-divers/attentats-du-13-novembre-l-ombre-d-un-jihadiste-francais-derriere-le-bataclan-21-12-2015-5391337.php"
                  ,WSJ5="http://www.wsj.com/articles/belgian-police-arrest-two-on-terrorism-charges-1451381052"
                  ,NYT7="http://www.nytimes.com/2015/12/31/world/europe/cellphone-contacts-in-paris-attacks-suggest-foreign-coordination.html"
                  ,LMD2="http://www.lemonde.fr/proche-orient/article/2015/12/30/abou-mohammed-al-adnani-voix-de-l-etat-islamique-et-cerveau-des-attentats-de-paris_4839809_3218.html"
                  ,LMD3="http://www.lemonde.fr/attaques-a-paris/article/2015/12/30/comment-les-attentats-du-13-novembre-ont-ete-coordonnes-depuis-la-belgique_4839400_4809495.html"
                  ,FIG2="http://www.lefigaro.fr/actualite-france/2015/12/31/01016-20151231ARTFIG00046-attentats-de-paris-un-proche-d-abdeslam-inculpe-a-bruxelles-pour-assassinats-terroristes.php"
                  ,SOI1="http://www.lesoir.be/1082419/article/actualite/belgique/2015-12-31/attentats-paris-qui-est-ayoub-bazarouj-interpelle-bruxelles-ce-mercredi"
                  ,ABC2="http://www.abc.net.au/news/2015-10-10/at-least-95-killed-scores-wounded-in-blasts-in-turkeys-capital/6844222"
                  ,DSB1="http://www.dailysabah.com/investigations/2016/01/02/turkish-court-orders-arrest-of-two-suspected-daesh-suicide-bomber-hopefuls"
                  ,GRD3="http://www.theguardian.com/world/2015/feb/12/islamic-state-magazine-interviews-hayat-boumeddiene"
                  ,TEL4="http://www.telegraph.co.uk/news/worldnews/europe/france/11929185/Paris-killer-Amedy-Coulibaly-acted-under-orders-email-reveals.html"
                  ,TEL5="http://www.telegraph.co.uk/news/worldnews/europe/france/11331902/Charlie-Hebdo-attack-Frances-worst-terrorist-attack-in-a-generation-leaves-12-dead.html"
                  ,CHT1="http://www.chicagotribune.com/news/nationworld/chi-france-attacks-20150111-story.html"
                  ,DM5="http://www.dailymail.co.uk/news/article-3392048/Casual-evil-Paris-killers-Chilling-new-film-mastermind-strolling-Bataclan-bloody-massacre-accomplice-saunters-cafe-seconds-detonating-suicide-vest.html"
                  ,LMD4="http://www.lemonde.fr/attaques-a-paris/article/2016/01/06/est-ce-que-tu-serais-pre-t-a-tirer-dans-la-foule_4842273_4809495.html"
                  ,IJR1="https://www.ijreview.com/2016/01/511381-second-deputy-to-isis-leader-abu-bakr-al-baghdadi-killed-in-iraqi-airstrike/"
                  ,NYT9="http://www.nytimes.com/2016/01/12/world/europe/top-suspect-in-paris-attacks-had-traveled-to-britain-officials-say.html?_r=0"
                  ,NYT10="http://www.nytimes.com/2016/01/14/world/europe/belgium-paris-attacks-safe-houses.html?_r=0"
                  )

AbdeilahChouaa = createNode(kblDB, "Person", name="Abdeilah Chouaa", gender="Male", citizenship="Belgian-Moroccan",  status="arrested", ref1=references[["ST1"]])
AbuMuhammadAlAdnani = createNode(kblDB, "Person", name="Abu Muhammad al-Adnani", age=38, gender="Male", status="wanted", ref1=references[["SC1"]])
AbuMuhammadAlShimali = createNode(kblDB, "Person", name="Abu Muhammad al-Shimali", gender="Male", status="wanted", ref1=references[["GRD1"]])

AbdelhamidAbaaoud = createNode(kblDB, "Person", name="Abdelhamid Abaaoud", age=27, gender="Male", nickname="Abu Omar al-Belgiki", nickname2="Abou Omar al-Soussi",  ref1=references[["DM1"]], status="dead", ref2=references[["WP1"]],  ref3=references[["FT1"]])
AbdoullahC    = createNode(kblDB, "Person", name="Abdoullah C", age=30, gender="Male", citinzeship="Belgium", ref1=references[["NYT7"]], status="arrested")
AhmetDahmani = createNode(kblDB, "Person", name="Ahmet Dahmani", age=26, gender="Male", role="Scout", ref1=references[["CNN2"]], status="arrested")
AhmetTahir = createNode(kblDB, "Person", name="Ahmet Tahir", age=29, gender="Male", ref1=references[["CNN2"]], status="arrested")

MohammedVerd = createNode(kblDB, "Person", name="Mohammed Verd", age=23, gender="Male", ref1=references[["CNN2"]], status="arrested")

AyoubBazarouj     = createNode(kblDB, "Person", name="Ayoub Bazarouj",    age=22, gender="Male", citizenship="Belgium", ref1=references[["SOI1"]], status="arrested")
YoussefBazarouj   = createNode(kblDB, "Person", name="Youssef Bazarouj",  gender="Male", citizenship="Belgium", ref1=references[["SOI1"]], status="arrested")
AliOulkadi        = createNode(kblDB, "Person", name="Salah Ali Oulkadi",       age=29, gender="Male", ref1=references[["DM2"]], status="arrested")
BilalHadfi        = createNode(kblDB, "Person", name="Bilal Hadfi",        age=20, gender="Male", ref1=references[["DM1"]], status="dead")
FabianClain       = createNode(kblDB, "Person", name="Fabian Clain",      age=36, gender="Male", nickname="Omar", ref1=references[["LIR1"]], status="wanted")
FouedMohamedAggad = createNode(kblDB, "Person", name="Foued Mohamed-Aggad",  age=23, gender="Male", ref1=references[["DM1"]], ref2=references[["GRD2"]], status="dead")
HamzaAttou        = createNode(kblDB, "Person", name="Hamza Attou",         age=21,  gender="Male", ref1=references[["IBT1"]], status="arrested")
IbrahimAbdeslam   = createNode(kblDB, "Person", name="Ibrahim Abdeslam",    age=31, gender="Male", nickname="Brahim", ref1=references[["DM1"]], status="dead")
AbraimiLazez      = createNode(kblDB, "Person", name="Abraimi Lazez",    age=39, gender="Male", ref1=references[["NYT4"]], status="arrested")
JawadBendaoud       = createNode(kblDB, "Person", name="Jawad Bendaoud",      age=27, gender="Male", ref1=references[["LOB1"]], ref2=references[["CNN3"]], status="arrested")
#MohammadAbdeslam  = createNode(kblDB, "Person", name="Mohammad Abdeslam",          gender="Male",  ref1=references[["DM1"]], status="free")
MohamedAbrini     = createNode(kblDB, "Person", name="Mohamed Abrini",       age=30, gender="Male", ref1=references[["ABC1"]], status="wanted")
MohamedAmimour    = createNode(kblDB, "Person", name="Mohamed Amimour",     age=67, gender="Male", ref1=references[["DM1"]], status="free")
MohamedBakkali    = createNode(kblDB, "Person", name="Mohamed Bakkali",       gender="Male", ref1=references[["ST1"]], status="wanted")
MohamedAmri       = createNode(kblDB, "Person", name="Mohamed Amri",         age=27, gender="Male", ref1=references[["DM1"]], status="arrested")
MohamedKhoualed   = createNode(kblDB, "Person", name="Mohamed Khoualed",     age=19, gender="Male", ref1=references[["TEL1"]], status="arrested")
OmarMostefai      = createNode(kblDB, "Person", name="Omar Ismaïl Mostefaï", age=29, gender="Male", ref1=references[["DM1"]], status="dead")
SalahAbdeslam     = createNode(kblDB, "Person", name="Salah Abdeslam",       age=26, gender="Male", ref1=references[["DM1"]], status="wanted")
SamyAmimour       = createNode(kblDB, "Person", name="Samy Amimour",         age=28, gender="Male", ref1=references[["DM1"]], status="dead")

#the unknowns from Nov 13
#AbbdulakbakB     = createNode(kblDB, "Person", name="AbbdulakbakB",  age=25, gender="Male", ref1=references[["DM1"]], ref2=references[["LI1"]], status="dead", note="possibly fake passport or a victim_s name")
MohammedAlmahmod  = createNode(kblDB, "Person", name="Mohammed al-Mahmud",  gender="Male",  ref1=references[["BBC1"]], status="dead")
AhmedAlmuhamed    = createNode(kblDB, "Person", name="Ahmed Almuhamed",      gender="Male", ref1=references[["DM1"]], status="dead")
StDenisUnknown    = createNode(kblDB, "Person", name="Unknown dead at St. Denis",   gender="Male", status="dead", ref1=references[["CNN3"]])

Montenegrin      = createNode(kblDB, "Person", name="Montenegrin",  age=51, ref1=references[["FT1"]], status="arrested")
#two individuals: 
#Sasha V., who was detained in Magstadt
#Vladan Vuchelichem (51 y.o.) from Podgorica
#The car navigator endpoint was a public (city) car park in Paris, and in V.Vuchelich's possession were several French operators' phone cards and addresses in France.
#http://peacekeeper.ru/en/?module=news&action=view&id=28525

#BrusselsUnknown  = createNode(kblDB, "Person", name="BrusselsUnknown", ref1=references[["WSJ2"]], status="arrested")
#possibly one of the people below

MohamedS         = createNode(kblDB, "Person", name="MohamedS", age=25, gender="Male", role="petty criminal assisted with finding safe house", ref1=references[["F24a"]], status="arrested")
#apparently not the BrusselsUnknown

SoufianeKayal    = createNode(kblDB, "Person", name="False ID as Soufiane Kayal", gender="Male", ref1=references[["TL1"]], status="wanted")
SamirBouzid      = createNode(kblDB, "Person", name="False ID as Samir Bouzid", gender="Male",  ref1=references[["TL1"]], status="wanted")


HasnaAitboulahcen  = createNode(kblDB, "Person", name="Hasna Aitboulahcen",         age=26,   gender="Female",  status="dead", ref1=references[["LOB1"]], ref2=references[["NP1"]], ref3=references[["CNN3"]])


AmedyCoulibaly     = createNode(kblDB, "Person", name="Amedy Coulibaly",  preNov13=TRUE, gender="Male", nickname="Abou Bassir Abdallah al-Ifriqi", ref1=references[["GRD2"]], status="dead")
HayatBoumeddiene   = createNode(kblDB, "Person", name="Hayat Boumeddiene", preNov13=TRUE, age=26, gender="Female", ref1=references[["GRD2"]], status="wanted")


#+explosion in Charleville-Mezieres
#http://www.cnn.com/2015/11/19/europe/paris-attacks-at-a-glance/

#ArmsDealer = createNode(kblDB, "Person", name="German Arms Dealer", age=35, gender="Male", ref1=references[["FOX2"]])
#not involved: TRIB1
#unclear buyer "Arab in Paris" on Nov 7

#linked to Bilal
SamirZ = createNode(kblDB, "Person", age=20, name="Samir Z", gender="Male", citizenship="France", ref1=references[["IBT2"]], ref2=references[["ST1"]], ref3=references[["CBS2"]],  status="arrested")
PierreN = createNode(kblDB, "Person", age=28, name="Pierre N", gender="Male", citizenship="Belgium", ref1=references[["IBT2"]], ref2=references[["ST1"]], status="arrested")

#Abaood was linked to unknown people in the UK
#http://www.arabtimesonline.com/news/paris-attacker-visited-london-report-belgium-seeks-2-new-dangerous-attack-suspects/

#suspects in Austria posing as refugees
#http://www.wsj.com/articles/austrian-police-arrest-two-men-in-connection-with-paris-terror-attacks-1450275648

#Nov 18 attack in Sarajevo
#http://www.timesofisrael.com/probable-islamist-kills-two-bosnian-soldiers-in-suicide-attack/
#http://www.huffingtonpost.com/matt-olchawa/from-brussels-to-sarajevo_b_8640296.html
#https://www.rt.com/news/326825-bosnia-isis-raid-arrests/
#34-year-old man reported to be a member of an Islamist group,

#Arrests in Orleans, possibly linked to KBL
#http://www.cnn.com/2015/12/22/europe/france-terror-arrests/

#more IS members arrested - not linked
#http://www.express.co.uk/news/world/629975/terrorism-belgium-suspects-new-year-s-eve-attacks-security-europe

#Leaders of DAESH involved in plots (REU1)
#LP3
#Abdul Qader Hakim, who facilitated the militants' external operations. He was killed in the northern Iraqi city of Mosul on Dec. 26.
#A coalition air strike on Dec. 24 in Syria killed Charaffe al Mouadan, a Syria-based Islamic State member with a direct link to Abdelhamid Abaaoud
#nickname: Souleymane
#linked to 
CharaffeAlMouadan  = createNode(kblDB, "Person", name="Charaffe al Mouadan",  nickname="Souleymane", age=27, gender="Male",  status="dead", ref1=references[["LP3"]])

#more arrests on ISIS-affiliated plot in Belgium
#WSJ5

#large ISIS-linked bombing in Turkey - possibly connected and relevant
#ABC2
#follow-up plot in NYE
#DSB1

#Abrini had a brother in ISIS
#LMD3
###################
# PAST PLOTS BY KBL
###################
#by some accounts, the operation was done by ENMI rather than KBTL
#LP2, http://www.francetvinfo.fr/monde/proche-orient/offensive-jihadiste-en-irak/un-jihadiste-incarcere-en-france-detaille-comment-l-etat-islamique-deploie-son-reseau-d-espionnage_1055939.html

#Sabri Essid
#http://www.marianne.net/sabri-essid-heritier-du-clan-merah-syrie-100232578.html
#half-brother to Mohamed Merah http://www.weeklystandard.com/keyword/Sabri-Essid

#https://en.wikipedia.org/wiki/2015_anti-terrorism_operations_in_Belgium
RedouaneHagaoui  = createNode(kblDB, "Person", preNov13=TRUE, name="Redouane Hagaoui",      gender="Male", ref1=references[["TEL3"]], status="dead")
TarikJadaoun     = createNode(kblDB, "Person", preNov13=TRUE, name="Tarik Jadaoun",            gender="Male", ref1=references[["TEL3"]], status="dead")
YounesAbaaoud     = createNode(kblDB, "Person", preNov13=TRUE, name="Younes Abaaoud",      age=13,      gender="Male", ref1=references[["GRD1"]], status="wanted")
YassineAbaaoud     = createNode(kblDB, "Person", preNov13=TRUE, name="Yassine Abaaoud",        gender="Male", ref1=references[["WSJ3"]], status="wanted")
#father: OmarAbaaoud, http://www.theatlantic.com/international/archive/2015/11/who-was-abdelhamid-abaaoud-isis-paris/416739/

AugUnknown = createNode(kblDB, "Person", preNov13=TRUE, name="August Recruit", gender="Male", citizenship="Belgium", note="traveled with RedaHame in connection to the concert plot",  ref1=references[["NYT4"]], ref2=references[["LP2"]], refr=references[["LMD5"]], status="arrested", dateOfArrest=2015.0615)
RedaHame   = createNode(kblDB, "Person", preNov13=TRUE, name="Reda Hame", gender="Male", citizenship="France", age=30, ref1=references[["NYT4"]], ref2=references[["LP2"]], ref4=references[["LMD4"]], status="arrested")

#plots in Belgium
MehdiNemmouche       = createNode(kblDB, "Person", preNov13=TRUE, name="Mehdi Nemmouche",      gender="Male", ref1=references[["LOB1"]], status="arrested")
AyoubElKhazzani       = createNode(kblDB, "Person", preNov13=TRUE, name="Ayoub El Khazzani",  age=25,    gender="Male", ref1=references[["LOB1"]], status="arrested")  #http://www.cnn.com/2015/08/24/europe/france-train-attack-what-we-know-about-suspect/


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

#Nov 12 arrest of a large network
#http://www.expressandstar.com/news/uk-news/2015/11/12/four-men-held-in-uk-in-italian-led-counter-terror-operation/

#http://www.thesun.co.uk/sol/homepage/news/6823177/Paris-attacks-mastermind-met-UK-jihadis-before-atrocity.html
#Birmingham extrimists (unnamed, but linked to Abaoud and Brahim Abdeslam)

#NYT7: http://www.nytimes.com/2015/12/31/world/europe/cellphone-contacts-in-paris-attacks-suggest-foreign-coordination.html
#Unknown Mastermind coordinated by phone from Belgium?
#Unknown Leader in IS territory

#LMD2
#Al-Adnani knew from prison Abou Bakr Al-Baghdadi
#IJR1
#Adnani was leutenant of Al-Obeidi, who was the leutenant of Baghdadi

#TODO: record Safehouses 
#LMD3

#SOI1:
#multiple family members of Ayoub Bazarouj are in Syria

######
# Nodes
######

#countries
#Belgium = createNode(kblDB, "Country", name="Belgium")
#Egypt  = createNode(kblDB, "Country", name="Egypt")
Greece  = createNode(kblDB, "Country", name="Greece")
#France = createNode(kblDB, "Country", name="France")
Morocco = createNode(kblDB, "Country", name="Morocco")
Syria = createNode(kblDB, "Country", name="Syria")
Turkey = createNode(kblDB, "Country", name="Turkey")
UK = createNode(kblDB, "Country", name="United Kingdon")

#foci
BazaroujFamily  = createNode(kblDB, "Focus", name="Bazarouj family")

#localities / sites
AlfortsvilleApt  = createNode(kblDB, "Site", name="Alfortsville apartment")
AuvelaisHouse = createNode(kblDB, "Site", name="Auvelias", note="rented in October", role="suspected planning site and bomb making")
Bobigny       = createNode(kblDB, "Site", name="Bobigny apartment")
CharleroiApt  = createNode(kblDB, "Site", name="Charleroi apartment", note="Rue du Fort. Rented in September", ref1=references[["NYT10"]])
Molenbeek     = createNode(kblDB, "Locality", name="Molenbeek", location="various")
NederOverHeembeek   = createNode(kblDB, "Locality", name="Neder-over-Heembeek", location="various")
StDenis       = createNode(kblDB, "Site", name="St.Denis", address="8 rue du Carillon and rue Carnot", ref1=references[["NBC1"]])
SchaerbeekApt = createNode(kblDB, "Site", name="Schaerbeek bomb factory", address="Rue Henri Berge", ref1=references[["DM5"]])
#wishlist: second location in St.Denis

#attack sites.  dates are approximate, if the attack was interdicted.
#TODO: date is not recorded correctly in the DB
#but this records it correctly: Arrondisement18  = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="Aborted Arrond. 18", outcome="aborted") #killed=0, wounded=0
Arrondisement18  = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="Aborted Arrond. 18", outcome="aborted", killed=0, wounded=0)

Bataclan         = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="Bataclan", killed=89, wounded=200)
ComptoirVoltaire = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="Comptoir Voltaire", killed=0, wounded=3, ref1=references[["DM1"]])
LaBonneBiere     = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="La Bonne Biere", killed=0, wounded=0)
LaBelleEquipe    = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="La Belle Equipe", killed=19, wounded=9)
LaCasaNostra     = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="La Casa Nostra", killed=5, wounded=8)
LaDefense        = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="Aborted La Defense", outcome="aborted", ref1=references[["ABC1"]])
LeCarillonBarAndLePetitCambodge    = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="Le Carillon Bar and Le Petit Cambodge", killed=15, injured=10)
StadeDeFrance    = createNode(kblDB, "AttackSite", attackDate=2015.1113, name="Stade de France", killed=1, wounded=0)

#TODO: 

#Known Syria connections
createRel(AbuMuhammadAlAdnani,  "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(FabianClain,          "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(FouedMohamedAggad,    "BEEN_IN", Syria, ref1=references[["GRD2"]])
createRel(AbuMuhammadAlShimali, "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(BilalHadfi,         "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(OmarMostefai,       "BEEN_IN", Syria, date="2013", ref1=references[["DM1"]])
createRel(SamyAmimour,        "BEEN_IN", Syria, ref1=references[["NEW2"]])
createRel(AhmedAlmuhamed,     "BEEN_IN", Syria, ref1=references[["IND1"]])
createRel(MohammedAlmahmod,   "BEEN_IN", Syria, ref1=references[["IND1"]])
createRel(MohammedVerd,     "BEEN_IN", Syria, ref1=references[["CNN2"]])
createRel(AhmetTahir,       "BEEN_IN", Syria, ref1=references[["CNN2"]])
createRel(AugUnknown, "BEEN_IN", Syria, ref1=references[["NYT4"]])
createRel(RedaHame,   "BEEN_IN", Syria, ref1=references[["NYT4"]])
createRel(BilalHadfi,         "BEEN_IN", Syria, ref1=references[["DM1"]])
createRel(OmarMostefai,       "BEEN_IN", Turkey, date="2010", ref1=references[["DM1"]])
createRel(OmarMostefai,       "BEEN_IN", Syria, date="2013", ref1=references[["DM1"]])

#Known Turkey connections
createRel(OmarMostefai,       "BEEN_IN", Turkey, date="2010", ref1=references[["DM1"]])
createRel(MohammedVerd,     "BEEN_IN", Turkey, ref1=references[["CNN2"]])
createRel(AhmetDahmani,     "BEEN_IN", Turkey, ref1=references[["CNN2"]])
createRel(AhmetTahir,       "BEEN_IN", Turkey, ref1=references[["CNN2"]])

#UK travel
createRel(MohamedAbrini,       "BEEN_IN", UK, date=2015.07,  ref1=references[["NYT9"]])
createRel(AbdelhamidAbaaoud,   "BEEN_IN", UK, date="unknown", ref1=references[["NYT9"]])

#TODO: standardize date field

#Greece transits
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Greece, ref1=references[["EXP1"]])
createRel(AhmedAlmuhamed,     "BEEN_IN", Greece, ref1=references[["EXP1"]])
createRel(MohammedAlmahmod,     "BEEN_IN", Greece, ref1=references[["IND1"]])

#TODO: link to specific attacker
#createRel(AhmetDahmani,     "BEEN_IN", France, ref1=references[["CNN2"]])

#known Molenbeek or others
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Molenbeek, ref1=references[["DM1"]])
createRel(IbrahimAbdeslam,    "BEEN_IN", Syria, ref1=references[["LMD3"]])
createRel(IbrahimAbdeslam,    "BEEN_IN", Molenbeek, ref1=references[["NBC2"]])
createRel(AbdoullahC,         "BEEN_IN", Molenbeek, ref1=references[["NYT7"]])
createRel(SamirZ,             "BEEN_IN", Molenbeek, ref1=references[["ST1"]])
createRel(PierreN,            "BEEN_IN", Molenbeek, ref1=references[["ST1"]])
createRel(SalahAbdeslam,      "BEEN_IN", Molenbeek, ref1=references[["NBC2"]])
createRel(BilalHadfi,         "BEEN_IN", NederOverHeembeek, ref1=references[["NYT8"]])
createRel(AyoubBazarouj,      "BEEN_IN", Molenbeek, ref1=references[["SOI1"]])
createRel(YoussefBazarouj,    "BEEN_IN", Molenbeek, ref1=references[["SOI1"]])


#Auvelias - planning site
createRel(MohamedBakkali,  "PRESENT_IN", AuvelaisHouse, ref1=references[["ST1"]], ref2=references[["NTY10"]])
createRel(SoufianeKayal,   "PRESENT_IN", AuvelaisHouse, ref1=references[["DM3"]])

#Charleroi: hideout?
createRel(AbdelhamidAbaaoud,   "PRESENT_IN", CharleroiApt, ref1=references[["NYT10"]])
createRel(BilalHadfi,   "PRESENT_IN", CharleroiApt, ref1=references[["NYT10"]])


createRel(SalahAbdeslam,  "BEEN_IN", Morocco, ref1=references[["DM3"]])
createRel(SalahAbdeslam,  "PRESENT_IN", SchaerbeekApt, date=2015.1314, ref1=references[["DM5"]])


#StDennis
createRel(AbdelhamidAbaaoud,  "PRESENT_IN", StDenis, ref1=references[["LOB1"]])
createRel(HasnaAitboulahcen,  "PRESENT_IN", StDenis, ref1=references[["LOB1"]])
createRel(StDenisUnknown,     "PRESENT_IN", StDenis, ref1=references[["CNN3"]])
createRel(JawadBendaoud,      "PRESENT_IN", StDenis, ref1=references[["LOB1"]])

#staging for attack
createRel(SalahAbdeslam, "PRESENT_IN", AlfortsvilleApt, ref1=references[["DM1"]])
#TODO: others were there too.  LM
createRel(IbrahimAbdeslam, "PRESENT_IN", Bobigny, ref1=references[["DM1"]])
createRel(SalahAbdeslam, "PRESENT_IN", Bobigny, ref1=references[["DM1"]])
createRel(SamyAmimour, "PRESENT_IN", Bobigny, ref1=references[["DM1"]])

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

#HyperCacher and related shootings
FontenayAuxRoses = createNode(kblDB, "AttackSite", attackDate=2015.0107, attackType="Shooting", name="Fontenay Aux Roses Shooting", killed=0, wounded=1, ref1=references[["CHT1"]])
Montrouge = createNode(kblDB, "AttackSite", attackDate=2015.0108, attackType="Shooting", name="Montrouge Shooting", killed=1, wounded=0, ref1=references[["TEL4"]])
HyperCacher = createNode(kblDB, "AttackSite", attackDate=2015.0109,  attackType="Shooting", name="HyperCacher Shooting", killed=4, ref1=references[["TEL4"]])

createRel(AmedyCoulibaly,  "ATTACKED", FontenayAuxRoses, ref1=references[["CHT1"]])
createRel(AmedyCoulibaly,  "ATTACKED", Montrouge, ref1=references[["GRD3"]])
createRel(AmedyCoulibaly,  "ATTACKED", HyperCacher, ref1=references[["GRD3"]])
createRel(AmedyCoulibaly,  "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])
createRel(HayatBoumeddiene,  "BEEN_IN", Syria, date="2015/01/08", ref1=references[["GRD3"]])

createRel(AmedyCoulibaly, "LINKED_TO", HayatBoumeddiene, note="common-law wife", ref1=references[["GRD3"]])

#AmedyCoulibaly had an unknown "Zigoto" controller.  Possibly link to Charlie Hebdo, despite their claim to belong to Al-Qaida
#http://www.telegraph.co.uk/news/worldnews/europe/france/11929185/Paris-killer-Amedy-Coulibaly-acted-under-orders-email-reveals.html

#HayatBoumeddiene talked to a companion of the Kouachi brothers #CHT1


#other KBL fighters
#https://pietervanostaeyen.wordpress.com/2015/01/21/katibat-al-battar-and-the-belgian-fighters-in-syria/

# #transit countries
createRel(AbdelhamidAbaaoud,  "BEEN_IN", Greece, ref1=references[["EXP1"]])
createRel(AhmedAlmuhamed,     "BEEN_IN", Greece, ref1=references[["EXP1"]])

createRel(AhmetDahmani,     "BEEN_IN", Turkey, ref1=references[["CNN2"]])
createRel(AhmetDahmani,     "BEEN_IN", Syria, ref1=references[["CNN2"]])
#createRel(AhmetDahmani,     "BEEN_IN", France, ref1=references[["CNN2"]])


#friend and familiar affiliations
createRel(SalahAbdeslam,     "LINKED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
#createRel(SalahAbdeslam,     "LINKED_TO", MohammadAbdeslam, note="brother", ref1=references[["DM1"]])
#createRel(MohammadAbdeslam , "LINKED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(YoussefBazarouj,     "LINKED_TO", AyoubBazarouj, note="brother", ref1=references[["SOI1"]])

createRel(MohamedAmimour,    "LINKED_TO", SamyAmimour, note="father_of", ref1=references[["DM1"]])
createRel(HasnaAitboulahcen, "LINKED_TO", AbdelhamidAbaaoud, note="cousin", ref1=references[["IBT2"]])
createRel(SalahAbdeslam,     "LINKED_TO", AbdelhamidAbaaoud, note="friends", ref1=references[["CNN1"]])
createRel(IbrahimAbdeslam,     "LINKED_TO", AbdelhamidAbaaoud, note="friends", ref1=references[["NYT5"]])

#AbdelhamidAbaaoud family
createRel(AbdelhamidAbaaoud,  "LINKED_TO", YounesAbaaoud,    note="brother, recruited", ref1=references[["GRD1"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", YassineAbaaoud,    note="brother, recruited", ref1=references[["GRD1"]])
createRel(RedaHame,           "LINKED_TO", YassineAbaaoud,    note="recruited", ref1=references[["GRD1"]])

createRel(AhmedAlmuhamed, "LINKED_TO", MohammedAlmahmod, note="traveled together or may be related",  ref1=references[["IND1"]])

createRel(AbdelhamidAbaaoud,  "LINKED_TO", OmarMostefai, note="uncharacterized", ref1=references[["NYT2"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", BilalHadfi, note="led in Syria", ref1=references[["NYT2"]])

createRel(SamirZ,  "LINKED_TO", BilalHadfi, ref1=references[["IBT2"]])
createRel(PierreN, "LINKED_TO", BilalHadfi, ref1=references[["IBT2"]])

createRel(AhmetDahmani,     "LINKED_TO", SalahAbdeslam, ref1=references[["CNN4"]])

createRel(AbdeilahChouaa,    "LINKED_TO",  SalahAbdeslam, note="knew family", ref1=references[["VOA1"]])
createRel(AbdeilahChouaa,    "LINKED_TO",  MohamedAbrini, note="particularly close", ref1=references[["VOA1"]])

#foci
createRel(SalahAbdeslam,     "AFFILIATED_WITH", BazaroujFamily, note="family friend", ref1=references[["SOI1"]])
createRel(AyoubBazarouj,     "AFFILIATED_WITH", BazaroujFamily, note="member", ref1=references[["SOI1"]])
createRel(YoussefBazarouj,   "AFFILIATED_WITH", BazaroujFamily, note="member", ref1=references[["SOI1"]])


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

#Ride1 to Bobigny in Renault Clio
DriveToBobigny = createNode(kblDB, "Activity", data=2015.1112, name="Drive to Bobigny (Clio)")
createRel(SalahAbdeslam,   "INVOLVED_IN",  DriveToBobigny,  ref1=references[["DM5"]])
createRel(IbrahimAbdeslam, "INVOLVED_IN",  DriveToBobigny,  ref1=references[["DM5"]])
createRel(MohamedAbrini,   "INVOLVED_IN",  DriveToBobigny,  ref1=references[["DM5"]])

#TODO:
#Clip stop at Airport
#LMD3

#TODO:
#stop at Charloi
#LMD3

#LM3: Teams from Stade and Cafe (Belgian) are in Bobigny
#Stade ride
DriveToStade = createNode(kblDB, "Activity", name="Drive to Stade")
createRel(SalahAbdeslam, "INVOLVED_IN",  DriveToStade,  ref1=references[["FOX1"]])
createRel(AhmedAlmuhamed, "INVOLVED_IN", DriveToStade,  ref1=references[["FOX1"]])
createRel(BilalHadfi, "INVOLVED_IN",     DriveToStade,  ref1=references[["FOX1"]])  

#probable involvement in the plot
EscapeFromParis = createNode(kblDB, "Activity", name="Escape from Paris")
createRel(MohamedAmri,    "INVOLVED_IN", EscapeFromParis, ref1=references[["DM1"]])
createRel(HamzaAttou,     "INVOLVED_IN", EscapeFromParis,  ref1=references[["DM1"]])
createRel(SalahAbdeslam,  "INVOLVED_IN", EscapeFromParis,  ref1=references[["DM1"]])

#Daesh core
OverallOrganization = createNode(kblDB, "Activity", name="Attack Organization")
createRel(FabianClain,          "INVOLVED_IN", OverallOrganization, ref1=references[["DM1"]])
createRel(AbuMuhammadAlAdnani,  "INVOLVED_IN", OverallOrganization, ref1=references[["NYT3"]], ref2=references[["NYT4"]])
createRel(AbuMuhammadAlShimali, "INVOLVED_IN", OverallOrganization, ref1=references[["GRD1"]])
createRel(AbdelhamidAbaaoud,    "INVOLVED_IN", OverallOrganization, ref1=references[["GRD1"]])
createRel(CharaffeAlMouadan,  "INVOLVED_IN", OverallOrganization, ref1=references[["LP3"]])
#TODO: all are based in Syria

MakingExplosives = createNode(kblDB, "Activity", name="Making Explosives")
createRel(MohamedKhoualed,  "INVOLVED_IN", MakingExplosives, ref1=references[["TEL1"]])
createRel(SalahAbdeslam,    "INVOLVED_IN", MakingExplosives, ref1=references[["TEL1"]])

ExfilitrationThroughBelgium = createNode(kblDB, "Activity", name="Exfilitration Through Belgium")
createRel(SalahAbdeslam, "INVOLVED_IN", ExfilitrationThroughBelgium, ref1=references[["NYT4"]])
createRel(AbraimiLazez,  "INVOLVED_IN", ExfilitrationThroughBelgium, ref1=references[["NYT4"]])
createRel(MohamedAbrini, "INVOLVED_IN",  ExfilitrationThroughBelgium, ref1=references[["ABC1"]])
createRel(AliOulkadi,    "INVOLVED_IN",  ExfilitrationThroughBelgium, ref1=references[["DM2"]], ref2=references[["TL1"]])
createRel(AbdeilahChouaa,    "INVOLVED_IN",  ExfilitrationThroughBelgium, ref1=references[["VOA1"]])

ExfiltrationToSyria = createNode(kblDB, "Activity", name="Exfiltration To Syria")
createRel(MohammedVerd,  "INVOLVED_IN", ExfiltrationToSyria, ref1=references[["TEL1"]])
createRel(AhmetTahir,    "INVOLVED_IN", ExfiltrationToSyria, ref1=references[["TEL1"]])
createRel(AhmetDahmani,  "INVOLVED_IN", ExfiltrationToSyria, ref1=references[["TEL1"]])

MissionInHungary = createNode(kblDB, "Activity", name="Mission in Hungary")
createRel(SoufianeKayal,     "INVOLVED_IN", MissionInHungary, ref1=references[["TL1"]])
createRel(SamirBouzid,       "INVOLVED_IN", MissionInHungary, ref1=references[["TL1"]])
createRel(AbdelhamidAbaaoud, "INVOLVED_IN", MissionInHungary, ref1=references[["TL1"]])

#StDenis safe house.  apparently pre-existing ties, rather than a joint mission
createRel(SamirBouzid,       "LINKED_TO", HasnaAitboulahcen,   note="transfer money after the attack", ref1=references[["TL1"]])
createRel(AbdoullahC,        "LINKED_TO", HasnaAitboulahcen,   note="unclear role. been in contact after attacks", ref1=references[["NYT7"]], ref2=references[["FIG2"]])
createRel(HasnaAitboulahcen, "LINKED_TO", MohamedS, note="knew", ref1=references[["F24a"]])
createRel(MohamedS,          "LINKED_TO", JawadBendaoud, note="knew", ref1=references[["F24a"]])

#planner
createRel(CharaffeAlMouadan,  "LINKED_TO", SamyAmimour, ref1=references[["LP3"]])
createRel(CharaffeAlMouadan,  "LINKED_TO", AbdelhamidAbaaoud, ref1=references[["LP3"]])


#attacks
createRel(IbrahimAbdeslam, "ATTACKED", ComptoirVoltaire, attackType="SuicideBombing", ref1=references[["DM1"]])

createRel(OmarMostefai,    "ATTACKED",  Bataclan, attackType="SuicideBombing", ref1=references[["DM1"]])
createRel(SamyAmimour,     "ATTACKED", Bataclan, attackType="Suicide", ref1=references[["DM1"]])
createRel(FouedMohamedAggad, "ATTACKED", Bataclan, attackType="Suicide", ref1=references[["DM1"]])
#only 3 detonated.  several (all?) shot.  Volkswagen Polo abandoned at site
#some early reports from Bataclan report a 4th Female attacker/shooter and also AbbdulakbakB.  No evidence in later reports.

createRel(AhmedAlmuhamed, "ATTACKED", StadeDeFrance, attackType="SuicideBombing", ref1=references[["DM1"]])
createRel(BilalHadfi,     "ATTACKED", StadeDeFrance, attackType="SuicideBombing", ref1=references[["DM1"]])  
createRel(MohammedAlmahmod, "ATTACKED", StadeDeFrance, attackType="SuicideBombing", note="detonated at nearby MacDonalds",  ref1=references[["DM1"]], ref2=references[["WSJ1"]])  

#gunmen in a black Seat Leon.  possibly Abdeslam brothers + unknown (YoussefBazarouj?  SOI1)
#http://www.lefigaro.fr/actualite-france/2015/11/18/01016-20151118ARTFIG00346-ce-que-l-on-sait-du-commando-qui-a-seme-la-terreur-a-paris.php
createRel(IbrahimAbdeslam, "ATTACKED", LeCarillonBarAndLePetitCambodge, attackType="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LeCarillonBarAndLePetitCambodge, attackType="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "ATTACKED", LeCarillonBarAndLePetitCambodge, attackType="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaCasaNostra, attackType="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LaCasaNostra, attackType="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "ATTACKED", LaCasaNostra, attackType="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaBonneBiere, attackType="Shooting", ref1=references[["NEW2"]])  
createRel(SalahAbdeslam, "ATTACKED", LaBonneBiere, attackType="Shooting", ref1=references[["NEW2"]])  
createRel(AbdelhamidAbaaoud, "ATTACKED", LaBonneBiere, attackType="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "ATTACKED", LaBelleEquipe, attackType="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "ATTACKED", LaBelleEquipe, attackType="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "ATTACKED", LaBelleEquipe, attackType="Shooting", ref1=references[["FOX1"]])  

#suspected attack 1
createRel(SalahAbdeslam, "ATTACKED", Arrondisement18, attackType="Unknown", ref1=references[["DM1"]])

#suspected attack 2
createRel(AbdelhamidAbaaoud, "ATTACKED", LaDefense, attackType="SuicideBombing", ref1=references[["ABC1"]])
createRel(StDenisUnknown,    "ATTACKED", LaDefense, attackType="SuicideBombing", ref1=references[["ABC1"]])

#suspected attack 3?
#+8 arrested in Saint Dennis with force 2015-11-18, http://www.nydailynews.com/news/world/paris-raid-killed-2-terror-suspects-time-article-1.2438743
#TARGETED Airport, Shopping Mall

######################
#PREVIOUS PLOTS BY KBL
######################

# createRel(MehdiNemmouche, "CITIZEN_OF", France, ref1=references[["NYT2"]])
# createRel(AyoubElKhazzani, "CITIZEN_OF", Morocco, ref1=references[["NYT2"]])

AugustConcert      = createNode(kblDB, "AttackSite", attackDate=2015.0811, name="Aborted concert hall plot in August", attackType="Unknown", ref1=references[["LP2"]], killed=0, wounded=0)
JewishMuseum       = createNode(kblDB, "AttackSite", attackDate=2014.0524, name="Jewish Museum of Belgium", attackType="Shooting", killed=4, wounded=0)
BrusselsParisTrain = createNode(kblDB, "AttackSite", attackDate=2015.0821, name="Brussels Paris Train attempt", attackType="Shooting", killed=0, wounded=2)
VerviersPlot       = createNode(kblDB, "AttackSite", attackDate=2015.0115, name="Police attack plot in Verviers", attackType="Shooting", killed=0, wounded=0, ref1=references[["DM1"]], ref2=references[["GRD1"]])

#BrusselsParisTrain
createRel(AyoubElKhazzani, "ATTACKED", BrusselsParisTrain, attackType="Shooting", ref1=references[["NYT2"]])
createRel(AyoubElKhazzani, "LINKED_TO", AbdelhamidAbaaoud, ref1=references[["NYT4"]])
createRel(AyoubElKhazzani, "BEEN_IN", Molenbeek, ref1=references[["NYT1"]])

#VerviersPlot
createRel(RedouaneHagaoui,  "ATTACKED", VerviersPlot, ref1=references[["TEL3"]])
createRel(TarikJadaoun,     "ATTACKED", VerviersPlot, ref1=references[["TEL3"]])
createRel(AbdelhamidAbaaoud,  "ATTACKED", VerviersPlot, ref1=references[["TEL3"]])

createRel(RedouaneHagaoui,  "BEEN_IN", Molenbeek, ref1=references[["NYT3"]])
createRel(TarikJadaoun,     "BEEN_IN", Molenbeek, ref1=references[["NYT3"]])

#Brussels Jewish Museum
createRel(MehdiNemmouche, "ATTACKED", JewishMuseum, attackType="Shooting", ref1=references[["NYT2"]])
createRel(MehdiNemmouche, "LINKED_TO", AbdelhamidAbaaoud, note="liaised", ref1=references[["NYT2"]])
createRel(MehdiNemmouche, "BEEN_IN", Molenbeek, ref1=references[["NYT2"]])


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
#real name: Abdel-Al Ilat Dandachi
#ref: LMD1

#Thomas Barnouin
#http://www.marianne.net/sabri-essid-heritier-du-clan-merah-syrie-100232578.html

#Tirad al-Jarba, known by the nom de guerre Abu Muhammad al-Shimali,
#http://www.telegraph.co.uk/news/worldnews/europe/france/12004667/Paris-attacks-Isil-Mastermind-Abdelhamid-Abaaoud-killed-in-police-raid-on-Saint-Denis-flat-live.html?frame=3503511



########################################################
#print("Export")
########################################################
nov13nodes = cypher(kblDB, query='MATCH (p) return p.name') 
write.csv(nov13nodes, file="~/nov13/nov13_nodes.csv")

nov13persons = cypher(kblDB, query='MATCH (p:Person) return p.name') 
write.csv(nov13persons, file="~/nov13/nov13_persons.csv")

nov13relationships = cypher(kblDB, query='MATCH (n1)-[r]->(n2) return n1.name, type(r), n2.name') 
write.csv(nov13relationships, file="~/nov13/nov13_relationships.csv" )

#requires neo4j database
#browse(nov13)

query = '  
MATCH (p:Person)-[:ATTACKED]->(s:AttackSite)
RETURN p.name, s.name'
attackersAndSites = cypher(kblDB, query)
attackersAndSites = unique(attackersAndSites)
print(attackersAndSites)  
write.csv(attackersAndSites, file="~/nov13/nov13_attackersAndSites.csv" )


####################################################################################################
#Terror network of people is constructed using relationships to attackers or suspects, as follows
####################################################################################################
query = 'MATCH n-[r]->m where NOT (n:Locality) AND NOT (n:Country) AND NOT (m:Locality) AND NOT (m:Country) RETURN n.name,labels(n),type(r),m.name,labels(m) '
minimalNetwork = cypher(kblDB, query)
write.csv(minimalNetwork, file="~/nov13/nov13_minimalNetwork.csv", row.names=F)


query = '  
MATCH (attacker1:Person)-[:ATTACKED]->(l:AttackSite)<-[:ATTACKED]-(attacker2:Person)
RETURN attacker1.name, attacker2.name'
commonAttack = cypher(kblDB, query)
commonAttack = unique(commonAttack)

query = '  
MATCH (p1:Person)-[:INVOLVED_IN]->(l:Activity)<-[:INVOLVED_IN]-(p2:Person)
RETURN p1.name, p2.name'
commonInvolvement = cypher(kblDB, query)
commonInvolvement = unique(commonInvolvement)


query = '  
MATCH (p:Person)-[:LINKED_TO]->(attacker1:Person)-[:ATTACKED]->(l:AttackSite)
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

# query = '  
# MATCH (p1:Person)-[:ASSISTED]-(p2:Person)
# WHERE (p1.status <> "free") AND (p2.status <> "free")
# RETURN p1.name, p2.name'
# assistedSuspect = cypher(kblDB, query)
# assistedSuspect = unique(assistedSuspect)

query = '  
MATCH (p:Person)-[r1]->(l:Site)<-[r2]-(attacker1:Person)-[:ATTACKED]->()
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
sharedSpaceWithAttacker = cypher(kblDB, query)
sharedSpaceWithAttacker = unique(sharedSpaceWithAttacker)

query = '  
MATCH (p:Person)-[:AFFILIATED_WITH]->(l:Focus)<-[:AFFILIATED_WITH]-(attacker1:Person)-[:ATTACKED]->()
WHERE p.status <> "free"
RETURN p.name, attacker1.name'
sharedAffiliationWithAttacker = cypher(kblDB, query)
sharedAffiliationWithAttacker = unique(sharedAffiliationWithAttacker)

query = '  
MATCH (p1:Person)-[:AFFILIATED_WITH]->(l:Focus)<-[:AFFILIATED_WITH]-(p2:Person)
WHERE p1.status <> "free" AND p2.status <> "free"
RETURN p1.name, p2.name'
sharedAffiliationWithSuspect = cypher(kblDB, query)
sharedAffiliationWithSuspect = unique(sharedAffiliationWithSuspect)

query = '  
MATCH (p1:Person)-[r1]->(l:Site)<-[r2]-(p2:Person)
WHERE (p1.status <> "free") AND (p2.status <> "free")
RETURN p1.name, p2.name'
sharedSiteWithSuspect = cypher(kblDB, query)
sharedSiteWithSuspect = unique(sharedSiteWithSuspect)

query = '  
MATCH (p1:Person)-[:BEEN_IN]->(l:Locality)<-[:BEEN_IN]-(p2:Person)
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
names(sharedAffiliationWithAttacker) <- c("n1", "n2")
names(sharedAffiliationWithSuspect) <- c("n1", "n2")
names(sharedSpaceWithAttacker) <- c("n1", "n2")
names(sharedSiteWithSuspect) <- c("n1", "n2")
names(sharedLocalityWithSuspect) <- c("n1", "n2")

terrorNetwork <-                   rbind(commonAttack, linkedToAttacker, linkedToWanted, commonInvolvement, sharedSpaceWithAttacker, sharedSiteWithSuspect)
terrorNetworkUndirected <- rbind(terrorNetwork, data.frame(n1=terrorNetwork[["n2"]], n2=terrorNetwork[["n1"]])) 
terrorNetworkUndirected <- unique(terrorNetworkUndirected)
print(terrorNetworkUndirected) 
write.csv(terrorNetworkUndirected, file="~/nov13/nov13_terrorNetwork.csv", row.names=F)


terrorNetworkExtended           <- rbind(commonAttack, linkedToAttacker, linkedToWanted, commonInvolvement, sharedSpaceWithAttacker, sharedSiteWithSuspect, sharedLocalityWithSuspect, sharedAffiliationWithAttacker, sharedAffiliationWithSuspect)
terrorNetworkExtendedUndirected <- rbind(terrorNetworkExtended, data.frame(n1=terrorNetworkExtended[["n2"]], n2=terrorNetworkExtended[["n1"]])) 
terrorNetworkExtendedUndirected <- unique(terrorNetworkExtendedUndirected)
print(terrorNetworkExtendedUndirected) 
write.csv(terrorNetworkExtendedUndirected, file="~/nov13/nov13_terrorNetworkExtended.csv", row.names=F)


terrorNetworkLimited           <- rbind(commonAttack, linkedToAttacker, linkedToWanted, commonInvolvement)
terrorNetworkLimitedUndirected <- rbind(terrorNetworkLimited, data.frame(n1=terrorNetworkLimited[["n2"]], n2=terrorNetworkLimited[["n1"]])) 
terrorNetworkLimitedUndirected <- unique(terrorNetworkLimitedUndirected)
print(terrorNetworkLimitedUndirected) 
write.csv(terrorNetworkLimitedUndirected, file="~/nov13/nov13_terrorNetworkLimited.csv", row.names=F)

query = '  
MATCH (n:Person) WHERE (n.preNov13=TRUE) RETURN n.name'
preNov13agents = cypher(kblDB, query)
names(preNov13agents)<-c("name")
write.csv(preNov13agents, file="~/nov13/preNov13agents.csv", row.names=F)


query = '  
MATCH (n:Person) RETURN n.name, n.age, n.gender, n.citizenship, n.status'
allPersons = data.table(cypher(kblDB, query))
names(allPersons)<-c("name", "ageIn2015", "gender", "citizenship", "status")
write.csv(allPersons, file="~/nov13/allPersons.csv", row.names=F)


require(igraph)
write_gml <- function(Vs, Es, fpath) {
  stopifnot("name" %in% names(Vs))
  stopifnot(names(Es)==c("n1", "n2"))
  isols <- setdiff(setdiff(Vs$name, Es$n1), Es$n2)
  G <- make_graph(edges=as.vector(t(Es)), directed=F, isolates=isols)
  G <- simplify(G)
  #wishlist: set other attribs
  write_graph(G, file=fpath, format="gml")
  return(G)
}

terrorPersons <- allPersons[status!="free"]
TN <- write_gml(Vs=terrorPersons, Es=terrorNetworkUndirected,   fpath="~/nov13/ise_terrorNetwork.gml")
write_gml(Vs=terrorPersons, Es=terrorNetworkLimitedUndirected,  fpath="~/nov13/ise_terrorNetworkLimited.gml")
write_gml(Vs=terrorPersons, Es=terrorNetworkExtendedUndirected, fpath="~/nov13/ise_terrorNetworkExtended.gml")

#browse(kblDB)

#querying the DB
#===============
#MATCH (n) RETURN n
#MATCH n,s WHERE (n)-[:ATTACKED]->(s) RETURN n,s
#MATCH n WHERE NOT (n:Locality) AND NOT (n:Country) RETURN n

#extract all the data necessary for minimal network
#MATCH n-[r]->m where NOT (n:Locality) AND NOT (n:Country) AND NOT (m:Locality) AND NOT (m:Country) RETURN n.name,labels(n),type(r),m.name,labels(m)

#extract all nodes of the nov13 network
#MATCH n WHERE (n.preNov13 IS NULL) RETURN n
