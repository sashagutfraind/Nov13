#Islamist militants in France/Belgium but not connected to KBL

#2/2012 seems like a separate network
ToulouseAndMontauban = createNode(kblDB, "AttackSite", name="Toulouse and Montauban shootings", killed=8, wounded=5)
MohammedMerah       = createNode(kblDB, "Person", name="Mohammed Merah",      age=23, gender="Male", ref1=references[["LIR1"]], status="arrested")  #http://www.lemonde.fr/societe/live/2012/03/19/direct-la-fusillade-a-toulouse_1671851_3224.html
createRel(MohammedMerah, "INVOLVED_IN", ToulouseAndMontauban, attack_type="Shooting", ref1=references[["TODO"]])


#motivated by Al-Q not DAESH
CharlieHebdo = createNode(kblDB, "AttackSite", name="Charlie Hebdo", killed=12, wounded=11)

#CharlieHebdo -  al-Qaeda in the Arabian Peninsula not DAESH
ChérifKouachi   = createNode(kblDB, "Person", name="Chérif Kouachi",  gender="Male", status="dead")
SaïdKouachi     = createNode(kblDB, "Person", name="Saïd Kouachi",  gender="Male", status="dead")
#Djamel Begha - coordinator
#18-year-old brother-in-law of Chérif Kouachi

createRel(ChérifKouachi, "INVOLVED_IN", CharlieHebdo, attack_type="Shooting", ref1=references[["TEL5"]])
createRel(SaïdKouachi, "INVOLVED_IN", CharlieHebdo, attack_type="Shooting", ref1=references[["TEL5"]])
createRel(ChérifKouachi, "LINKED_TO", SaïdKouachi, note="brother", ref1=references[["TEL5"]])

createRel(ChérifKouachi, "LINKED_TO", AmedyCoulibaly, note="friend", ref1=references[["LMD7"]])
createRel(SaïdKouachi, "LINKED_TO", AmedyCoulibaly, note="friend", ref1=references[["LMD7"]])
#http://www.theguardian.com/world/2015/jan/11/paris-gunman-amedy-coulibaly-allegiance-isis
#al-Qaeda recruiter Djamel Beghal,

#arms supplier
#http://abcnews.go.com/International/wireStory/spain-police-arrest-suspect-tied-jan-2015-paris-38360132

createRel(ChérifKouachi, "PRESENT_IN", Syria, date="summer 2014", ref1=references[["TEL5"]])
createRel(SaïdKouachi, "PRESENT_IN", Syria, date="summer 2014", ref1=references[["TEL5"]])

AbderahmaneAmeroud  = createNode(kblDB, "Person", name="Abderahmane Ameroud", age=27, gender="Male", citizenship="Algers", ref1=references[["NYT14"]], status="arrested")
#assisted assassination of Massoud in 2005

#apparently a separate blog


#"Cannes-Torcy" group - an earlier plot from 2012
#CNN4, NYT17
#One of the first clues that the Islamic State was getting into the business of international terrorism came at 12:10 p.m. on Jan. 3, 2014, when the Greek police pulled over a taxi in the town of Orestiada, less than four miles from the Turkish border. Inside was a 23-year-old French citizen named Ibrahim Boudina, 
#Ibrahim Boudina, a 23-year-old French national born in Algiers
#...Boudina had set off for Syria in late September 2012 with a childhood friend -- 
#http://www.nytimes.com/2016/03/29/world/europe/isis-attacks-paris-brussels.html?_r=0

#NYT17
#It was in the summer of 2014 that the link to the terrorist organization’s hierarchy became explicit.
#On June 22 of that year, a 24-year-old French citizen named Faiz Bouchrane, who had trained in Syria, was smuggled into neighboring Lebanon. He was planning to blow himself up at a Shiite target, and during interrogation, he let slip the name of the man who had ordered him to carry out the operation: Abu Muhammad al-Adnani.

#Abdelkader Tliba, a French-Tunisian 
#Jeremie Louis-Sidney
#... On October 6, 2012, Louis-Sidney was killed in a shootout with police in Strasbourg after resisting arrest. 
#+police informant / friend 

#2014
#On June 22 of that year, a 24-year-old French citizen named 
#Faiz Bouchrane
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

#Neetin Karasular, a suspected Belgian trafficker in weapons who met with Coulibaly's widow, Hayat Boumeddiene, is in custody, Karasular's attorney, Michel Bouchat, told CNN.
#http://edition.cnn.com/2015/01/16/europe/europe-terrorism-threat/

#another weapons smuggler?
#Montenegrin      = createNode(kblDB, "Person", name="Montenegrin",  age=51, ref1=references[["FT1"]], status="arrested")

#two individuals: 
#Sasha V., who was detained in Magstadt
#Vladan Vuchelichem (51 y.o.) from Podgorica
#The car navigator endpoint was a public (city) car park in Paris, and in V.Vuchelich's possession were several French operators' phone cards and addresses in France.
#http://peacekeeper.ru/en/?module=news&action=view&id=28525

#., born in 1986, and Moroccan national Mustafa E., born in 1981, were taken into custody during house searches carried out by the Belgian police.
#released: http://www.irishtimes.com/news/world/europe/paris-attacks-suspect-released-from-custody-by-belgian-court-1.2506936

#PEU1 - self radicalized but unlinked
#Saïd Souati, 30, and Mohamed Karay, 27, belong to the Kamikaze Riders and lived in Anderlecht
#http://www.lalibre.be/actu/belgique/said-souati-l-homme-qui-voulait-commettre-un-attentat-a-bruxelles-5683041a3570ed3894d57cca



#Mafia-Terrorist nexus
#Aziz Ehsan, a 46-year-old Iraqi, was arrested near Naples 
#http://www.thedailybeast.com/articles/2016/03/24/inside-the-mafia-isis-connection.html

#+explosion in Charleville-Mezieres
#http://www.cnn.com/2015/11/19/europe/paris-attacks-at-a-glance/

#ArmsDealer = createNode(kblDB, "Person", name="German Arms Dealer", age=35, gender="Male", ref1=references[["FOX2"]])
#not involved: TRIB1
#unclear buyer "Arab in Paris" on Nov 7


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


#more arrests on ISIS-affiliated plot in Belgium
#WSJ4

#large ISIS-linked bombing in Turkey - possibly connected and relevant
#ABC2
#follow-up plot in NYE
#DSB1

#Abrini had a brother in ISIS
#LMD3

#possible associates of the attackers
#JT1
#http://www.japantimes.co.jp/news/2016/02/19/world/crime-legal-world/four-austria-custody-arrived-migrants-probed-paris-attacks-islamic-state-links/#.VspJ2pMrLu4

#Sabri Essid
#http://www.marianne.net/sabri-essid-heritier-du-clan-merah-syrie-100232578.html
#half-brother to Mohamed Merah http://www.weeklystandard.com/keyword/Sabri-Essid

#Aine Lesley Davis, a British ISIS operative 
#http://www.cnn.com/2015/12/03/europe/salah-abdeslam-cold-trail-paris-attacks/
#arrested
#http://www.independent.co.uk/news/world/europe/british-isis-fighter-aine-lesley-davies-arrested-on-eve-of-paris-attacks-planning-similar-atrocity-a6742201.html


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

#Amimour was in the UK
#http://www.dailymail.co.uk/news/article-3377465/Teenage-wife-Bataclan-killer-brags-great-life-Iraq-proud-happy-helped-murder-90-people.html

#LMD2
#Al-Adnani knew from prison Abou Bakr Al-Baghdadi
#IJR1
#Adnani was leutenant of Al-Obeidi, who was the leutenant of Baghdadi

#SOI1:
#multiple family members of Ayoub Bazarouj are in Syria

#HyperCacher and related shootings

#HyperCacher - most likely originated with AQ
#http://www.lemonde.fr/les-decodeurs/visuel/2016/01/08/un-an-apres-le-recit-detaille-des-attentats-de-janvier-2015_4843963_4355770.html#partie9

AmedyCoulibaly     = createNode(kblDB, "Person", name="Amedy Coulibaly",  preNov13=TRUE, gender="Male", alias="Abou Bassir Abdallah al-Ifriqi", ref1=references[["GRD2"]], status="dead")
HayatBoumeddiene   = createNode(kblDB, "Person", name="Hayat Boumeddiene", preNov13=TRUE, age=26, gender="Female", ref1=references[["GRD2"]], status="wanted")


createRel(AmedyCoulibaly,  "INVOLVED_IN", Montrouge, ref1=references[["GRD3"]])
createRel(AmedyCoulibaly,  "INVOLVED_IN", HyperCacher, ref1=references[["GRD3"]])

createRel(AmedyCoulibaly,  "PRESENT_IN", Molenbeek, ref1=references[["NYT2"]])
createRel(HayatBoumeddiene,  "PRESENT_IN", Syria, date="2015/01/08", ref1=references[["GRD3"]])

createRel(AmedyCoulibaly, "LINKED_TO", HayatBoumeddiene, note="common-law wife", ref1=references[["GRD3"]])

#AmedyCoulibaly had an unknown "Zigoto" controller.  Possibly link to Charlie Hebdo, despite their claim to belong to Al-Qaida
#http://www.telegraph.co.uk/news/worldnews/europe/france/11929185/Paris-killer-Amedy-Coulibaly-acted-under-orders-email-reveals.html
#HayatBoumeddiene talked to a companion of the Kouachi brothers #CHT1
#more details

FontenayAuxRoses = createNode(kblDB, "AttackSite", attackDate=2015.0107, attackType="Shooting", name="Fontenay Aux Roses Shooting", killed=0, wounded=1, ref1=references[["CHT1"]])
Montrouge = createNode(kblDB, "AttackSite", attackDate=2015.0108, attackType="Shooting", name="Montrouge Shooting", killed=1, wounded=0, ref1=references[["TEL4"]])
HyperCacher = createNode(kblDB, "AttackSite", attackDate=2015.0109,  attackType="Shooting", name="HyperCacher Shooting", killed=4, ref1=references[["TEL4"]])



" He said that Abaaoud worked in Isis’s internal security unit, known as EMNI, which has the task of sending European jihadis back to their homelands to carry out terrorist attacks. The unit is run by two Tunisians, he said.
Abaaoud is said to have told the young Frenchman that he had managed to find 25kg of explosives in Belgium, but that it was too difficult for him to return to his home country himself. He was in charge of selecting candidates, who could be paid as much as €50,000 for carrying out attacks, but it was the two unnamed Tunisians who had the final decision on who would be sent."
#GRD1
#+different names?

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

#more details on Chakib Akrouh including shootings
#http://www.lemonde.fr/police-justice/article/2016/01/14/le-kamikaze-qui-s-etait-fait-exploser-lors-de-l-assaut-policier-a-saint-denis-identifie_4847657_1653578.html

#links to Mumbai attacks
#http://www.timesofisrael.com/austria-probes-link-between-paris-mumbai-attacks/
#The 34-year-old was arrested in Austria in December along with an Algerian.

#ISIS arrests in Denmark
#http://www.cnn.com/2016/04/07/europe/copenhagen-suspected-isis-arrests/index.html

#ISIS arrests in Germany
#http://www.dw.com/en/german-police-arrest-nigerian-and-iraqi-over-suspected-links-to-is-militants/a-19172567

#Pakistani bombmaker contracted by ISIS?
#http://www.arabtimesonline.com/news/austria-probes-paris-mumbai-attacks-link-pakistani-suspect-identity-not-confi-rmed/

#Arrests in the UK
#http://www.bbc.com/news/uk-36052896

#arms supplierfor Amady
#https://www.thespainreport.com/articles/715-160413154107-spanish-police-arrest-french-arms-supplier-who-gave-paris-attacker-coulibaly-weapons