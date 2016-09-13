'
The file below creates the IS-E dataset using the neo4j Database

1. Download the Neo4j community edition (version >= 3.0.1)

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

notInNov13 = individuals who are believed to be not involved in the Paris-Brussels attacks operational network
- includes ISIS fighters who left Europe before the attacks
- includes unrelated ISIS cells


TODO: include these:
The 29-year-old Algerian Adel Haddadi and the 35-year-old Pakistani Mohamad Usman were charged with "criminal conspiracy with terrorists", the source said of the men turned over earlier Friday by Austrian authorities.
Investigators believe they travelled to the Greek island of Leros on October 3 on the same boat full of refugees as two men who took part in the November 13 attacks.
Usman is reportedly thought to be a bomb maker 

Salzburg prosecutors added Friday that two more men, a Moroccan and an Algerian arrested eight days after the others, remained in custody.
In December prosecutors had said that the men, aged 25 and 40 at the time, were being held "because of indications of close contact" with the two now transferred to France.

http://www.worldbulletin.net/world/175569/paris-attacks-accomplices-charged-in-france

Additional details
https://psmag.com/the-dark-side-of-privacy-how-isis-communications-go-undetected-890aec4e86c3#.9qvpwkoqb
"Abu Ahmed was based in Raqqah"

"Ibrahim Boudinah, a plotter captured in a Cannes safe house"

"Abderrahim Moutaharrik, a Moroccan immigrant living north of Milan with his wife and two children."
"Moutaharrik finally received an audio message from Koraichi via WhatsApp"
"Moutaharrik and three other suspects 11 days later."

Details on Adnani
http://mobile.nytimes.com/2016/08/04/world/middleeast/isis-german-recruit-interview.html

New documents
http://edition.cnn.com/2016/09/05/politics/isis-suspects-terrorism-europe-documents/index.html
-- Abid Tabaouni, was only arrested in July
-- Two ISIS attackers who never reached France: Those two suspected ISIS operatives are identified in the documents as Algerian-born Adel Haddadi and his Pakistani travel partner, Muhammad Usman.

Another ISIS network
https://sites.google.com/site/ucinetsoftware/datasets/covert-networks/islamicstategroup

30-40 supporters still at large
http://www.cnn.com/2016/09/09/politics/isis-suspects-at-large-european-officials-say/index.html

'


library(RNeo4j)

#name of the database
kblDB = startGraph("http://localhost:7474/db/data/", username="neo4j", password="1")  
clear(kblDB, input=FALSE)  

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
                  ,FTF1="http://www.france24.com/en/20151205-paris-attacks-spotlight-turns-britain"
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
                  ,WSJ4="http://www.wsj.com/articles/belgian-police-arrest-two-on-terrorism-charges-1451381052"
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
                  ,LMD5="http://www.lemonde.fr/police-justice/article/2016/01/14/le-kamikaze-qui-s-etait-fait-exploser-lors-de-l-assaut-policier-a-saint-denis-identifie_4847657_1653578.html"
                  ,LMD6="http://www.lemonde.fr/attaques-a-paris/article/2016/01/18/un-belge-lie-aux-auteurs-des-attentats-du-13-novembre-arrete-au-maroc_4849263_4809495.html"
                  ,DW1="http://www.dw.com/en/belgium-police-arrest-two-suspects-linked-to-paris-attacks/a-18995606"
                  ,DBQ1="http://www.clarionproject.org/factsheets-files/Issue-13-the-rafidah.pdf"
                  ,NYT11="http://www.nytimes.com/2016/03/20/world/europe/a-view-of-isiss-evolution-in-new-details-of-paris-attacks.html"
                  ,NYT12="http://www.nytimes.com/2016/03/19/world/europe/salah-abdeslam-belgium-apartment.html"
                  ,HP1="http://www.huffingtonpost.fr/jeanpierre-filiu/boubaker-al-hakim-daech_b_7009322.html"
                  ,CNN4="http://www.cnn.com/2014/08/28/world/europe/france-suspected-isis-link/"
                  ,NYT13="http://www.nytimes.com/2016/03/25/world/europe/expanding-portraits-of-brussels-bombers-ibrahim-and-khalid-el-bakraoui.html"
                  ,NYT14="http://www.nytimes.com/2016/03/27/world/europe/brussels-attack-faycal-cheffou.html"
                  ,NBC3="http://www.nbcnews.com/storyline/brussels-attacks/najim-laachraoui-what-we-know-about-suspected-bomb-maker-n543996"
                  ,CNN5="http://edition.cnn.com/2016/03/25/europe/brussels-investigation/index.html"
                  ,NBC4="http://www.nbcnews.com/storyline/brussels-attacks/brussels-attacks-suspect-faycal-cheffou-freed-due-lack-evidence-n546416"
                  ,ITP1="http://www.interpol.int/notice/search/wanted/2016-18544"
                  ,BBC2="http://www.bbc.com/news/world-europe-35903368"
                  ,NYT15="http://www.nytimes.com/2016/03/26/world/europe/brussels-attacks-police.html"
                  ,DM6="http://www.dailymail.co.uk/news/article-3511323/Moment-armed-Italian-police-arrest-Algerian-man-wanted-Belgium-fake-ID-documents-used-Paris-Brussels-terrorists.html"
                  ,CNN6="http://edition.cnn.com/2016/03/28/europe/brussels-paris-attacks-suspects-at-large/index.html"
                  ,NYT16="http://www.nytimes.com/2016/03/26/world/europe/najim-laachraoui-24-bomb-maker-for-paris-and-brussels-attacks.html"
                  ,STT1="http://www.seattletimes.com/nation-world/belgian-charged-with-terrorism-in-new-french-attacks-case/?utm_source=RSS&utm_medium=Referral&utm_campaign=RSS_nation-world"
                  ,EXP2="http://www.expatica.com/fr/news/Italy-to-extradite-alleged-accomplice-in-Paris-Brussels-attacks_625192.html"
                  ,TDB1="http://www.thedailybeast.com/articles/2016/03/28/terrorist-tied-to-brussels-and-paris-attacks-lived-freely-on-the-amalfi-coast-for-three-months.html"
                  ,WP3="https://www.washingtonpost.com/world/belgian-authorities-arrest-third-suspect-in-foiled-terror-attack-plotted-for-france/2016/04/02/1ac15e42-f8d5-11e5-9804-537defcc3cf6_story.html"
                  ,WSJ5="http://www.wsj.com/articles/investigators-home-in-on-scope-of-terror-network-behind-brussels-paris-attacks-1459728742"
                  ,LMD7="http://www.lemonde.fr/societe/article/2015/01/09/fusillade-de-montrouge-suspect-identifie-deux-nouvelles-interpellations_4552503_3224.html"
                  ,AFP1="https://www.yahoo.com/news/penpix-paris-terror-suspects-190923864.html"
                  ,LEX1="http://www.lexpress.fr/actualite/societe/attentats-de-paris-l-homme-arrete-en-algerie-est-il-le-chauffeur-d-abaaoud_1770636.html"
                  ,HLN1="http://www.hln.be/hln/nl/35524/Aanslagen-Parijs/article/detail/2589852/2016/01/19/Voorlopig-geen-directe-link-tussen-Attar-en-aanslagen-Parijs.dhtml"
                  ,PEU1="http://www.politico.eu/article/brussels-terror-suspects-linked-to-biker-gang/"
                  ,LMD8="http://www.lemonde.fr/police-justice/article/2016/01/15/deux-djihadistes-en-fuite-proches-d-un-kamikaze-du-bataclan-condamnes-a-5-et-3-ans-de-prison_4848338_1653578.html"
                  ,B7S71="http://www.7sur7.be/7s7/fr/35522/Attaques-en-serie-a-Paris/article/detail/2651899/2016/03/19/Attentats-de-Paris-le-point-sur-l-enquete-infographie.dhtml"
                  ,WSJ6="http://www.wsj.com/articles/belgian-authorities-arrest-suspected-third-brussels-airport-attacks-officials-say-1460129257"
                  ,TOI1="http://www.timesofisrael.com/abrini-arrest-highlights-paris-brussels-attacks-links/"
                  ,UST1="http://www.usatoday.com/story/news/2016/04/09/belgian-raids-net-6th-terror-suspect/82829644/"
                  ,REU2="http://www.reuters.com/article/us-belgium-blast-abrini-idUSKCN0X60Q2"
                  ,BBN1="http://www.bloomberg.com/news/articles/2016-04-08/terror-suspect-abrini-detained-may-be-airport-bomber-vrt-says"
                  ,GRD4="http://www.theguardian.com/world/2016/apr/11/brussels-terror-cell-planned-to-attack-euro-2016-tournament"
                  ,NYT17="http://www.nytimes.com/2016/03/29/world/europe/isis-attacks-paris-brussels.html?_r=0"
                  ,EXP3="http://www.expatica.com/be/news/Belgium-charges-new-suspects-over-Brussels-attacks_644751.html"
                  ,GRD5="http://www.theguardian.com/world/2016/apr/12/brussels-bombings-two-more-charged"
                  ,DN1="http://www.dutchnews.nl/news/archives/2016/03/rotterdam-terror-suspect-has-links-to-paris-brussels-attacks-nos/"
                  ,EXP4="http://www.expatica.com/be/news/Penpix-of-Paris-terror-suspects_641155.html"
                  ,BBC3="http://www.bbc.com/news/world-europe-36005709"
                  ,BBC5="http://www.bbc.com/news/world-europe-31378724"
                  ,LMD9="http://www.lemonde.fr/societe/article/2016/03/23/quand-la-cellule-belge-de-verviers-projetait-un-attentat-dans-un-aeroport_4888395_3224.html"
                  ,DSD1="http://www.standaard.be/cnt/dmf20160405_02220019"
                  ,NYT18="http://www.nytimes.com/2016/03/20/world/europe/paris-terror-attacks-suspect-belgium.html?_r=0"
                  ,NYT19="http://www.nytimes.com/2016/04/30/world/europe/britain-brussels-paris-attacks.html"
                  ,IND2="http://www.independent.co.uk/news/world/europe/terror-threat-still-very-high-in-france-six-months-after-the-paris-attacks-a7028921.html"
                  ,UNS1="http://www.un.org/press/en/2015/sc12063.doc.htm"
                  ,DW2="http://www.dw.com/en/charaffe-al-mouadan-is-leader-with-links-to-paris-attacks-killed/a-18950253"
                  ,FTF2="http://www.france24.com/en/20151121-france-paris-attacks-hasna-aitboulahcen-party-girl-suspected-terrorist"
                  ,B7S72="http://www.7sur7.be/7s7/fr/32684/Menaces-terroristes-en-Belgique/article/detail/2703450/2016/05/13/Les-fiches-de-djihadistes-belges-de-l-EI-devoilees.dhtml"
                  )

AbdeilahChouaa = createNode(kblDB, "Person", name="Abdeilah Chouaa", age=30, gender="Male", citizenship="Belgium",  status="arrested", ref1=references[["ST1"]])
AbuMuhammadAlAdnani = createNode(kblDB, "Person", name="Abu Muhammad al-Adnani", age=38, gender="Male", citizenship="Syria", status="wanted", role="spokesperson", ref1=references[["SC1"]])
AbuMuhammadAlShimali = createNode(kblDB, "Person", name="Abu Muhammad al-Shimali", gender="Male", citizenship="Saudi Arabia", role="ISIS transportation", status="wanted", ref1=references[["GRD1"]], ref2=references[["UNS2"]])

AbdelhamidAbaaoud = createNode(kblDB, "Person", name="Abdelhamid Abaaoud", age=27, gender="Male", citizenship="Belgium", alias="Abu Omar al-Belgiki and Abou Omar al-Soussi",  role="leadership", status="dead", ref1=references[["DM1"]], ref2=references[["WP1"]],  ref3=references[["FT1"]])
AbdoullahCourkzine    = createNode(kblDB, "Person", name="Abdoullah Courkzine", age=30, gender="Male", citizenship="Belgium", ref1=references[["NYT7"]], status="arrested")
AhmetDahmani = createNode(kblDB, "Person", name="Ahmet Dahmani", age=26, gender="Male", citizenship="Belgium", role="Scout", ref1=references[["CNN2"]], status="arrested")
AhmetTahir = createNode(kblDB, "Person", name="Ahmet Tahir", age=29, gender="Male", citizenship="Syria", ref1=references[["CNN2"]], status="arrested")
 
BoubakerAlHakim = createNode(kblDB, "Person", name="Boubaker al-Hakim", alias="Abou Mouqatel", gender="Male", citizenship="France", ref1=references[["NYT12"]], status="wanted")


AyoubBazarouj     = createNode(kblDB, "Person", name="Ayoub Bazarouj",    age=22, gender="Male", citizenship="Belgium", ref1=references[["SOI1"]], ref2=references[["EXP4"]], status="free")
#recently released: http://www.irishtimes.com/news/world/europe/paris-attacks-suspect-released-from-custody-by-belgian-court-1.2506936
AliOulkadi        = createNode(kblDB, "Person", name="Salah Ali Oulkadi",       age=31, gender="Male", citizenship="unknown", ref1=references[["AFP1"]], status="arrested")
AugUnknown = createNode(kblDB, "Person", notInNov13=TRUE, name="August Recruit", gender="Male", citizenship="Belgium", note="traveled with RedaHame in connection to the concert plot",  ref1=references[["NYT4"]], ref2=references[["LP2"]], refr=references[["LMD5"]], status="arrested", dateOfArrest=2015.0615)
BilalHadfi        = createNode(kblDB, "Person", name="Bilal Hadfi",        age=20, gender="Male", citizenship="France", ref1=references[["DM1"]], status="dead")
ChakibAkrouh      = createNode(kblDB, "Person", name="Chakib Akrouh",   gender="Male", age=25, citizenship="Belgium", status="dead", ref1=references[["LMD5"]])
FabienClain       = createNode(kblDB, "Person", notInNov13=TRUE, name="Fabien Clain",      age=36, gender="Male", alias="Omar", citizenship="France", ref1=references[["LIR1"]], status="wanted")
FouedMohamedAggad = createNode(kblDB, "Person", name="Foued Mohamed-Aggad",  age=23, gender="Male", ref1=references[["DM1"]], citizenship="Belgium", ref2=references[["GRD2"]], status="dead")
GelelAttar        = createNode(kblDB, "Person", name="Gelel Attar", gender="Male", age=26, citizenship="Belgium", ref1=references[["LMD6"]], status="arrested")
HamzaAttou        = createNode(kblDB, "Person", name="Hamza Attou",         age=21,  gender="Male", citizenship="Belgium", role="explosives", ref1=references[["IBT1"]], ref2=references[["B7S71"]], ref3=references[["BFM1"]], status="arrested")
IbrahimAbdeslam   = createNode(kblDB, "Person", name="Ibrahim Abdeslam",    age=31, gender="Male", citizenship="France", note="citizenship inferred", alias="Brahim", ref1=references[["DM1"]], status="dead") 
IbrahimFarisi     = createNode(kblDB, "Person", name="Ibrahim Farisi",  age=28, DOB=1988, gender="Male", citizenship="Belgium", role="support", ref1=references[["EXP3"]], ref2=references[["GRD5"]], status="arrested")
JawadBendaoud       = createNode(kblDB, "Person", name="Jawad Bendaoud",      age=27, gender="Male", citizenship="France", ref1=references[["LOB1"]], ref2=references[["CNN3"]], status="arrested")
KhalidAlZerkani  = createNode(kblDB, "Person", name="Khalid al Zerkani", notInNov13=TRUE, nickname="Papa Noel", citizenship="Belgium", role="leadership", notInNov13=TRUE, role="recruiter", note="citizenship inferred", ref1=references[["CNN6"]], status="arrested")  
LazezAbraimi      = createNode(kblDB, "Person", name="Abraimi Lazez",    age=39, gender="Male", citizenship="Belgium", ref1=references[["NYT4"]], status="arrested")
#MohammadAbdeslam  = createNode(kblDB, "Person", name="Mohammad Abdeslam",          gender="Male",  citizenship="unknown", ref1=references[["DM1"]], status="free")
MohamedAbrini     = createNode(kblDB, "Person", name="Mohamed Abrini",       age=31, gender="Male", citizenship="Belgium", ref1=references[["ABC1"]], ref2=references[["TOI1"]], status="arrested")
#MohamedAmimour    = createNode(kblDB, "Person", name="Mohamed Amimour",     age=67, gender="Male", ref1=references[["DM1"]], status="free")
MohamedBakkali    = createNode(kblDB, "Person", name="Mohamed Bakkali",      age=28, gender="Male", citizenship="unknown", role="logistics", ref1=references[["ST1"]], status="wanted")
MohamedAmri       = createNode(kblDB, "Person", name="Mohamed Amri",         age=27, gender="Male", citizenship="France", ref1=references[["DM1"]], status="arrested")
MohamedKhoualed   = createNode(kblDB, "Person", name="Mohamed Khoualed",     age=19, gender="Male", citizenship="France", ref1=references[["TEL1"]], status="arrested")
MohammedVerd = createNode(kblDB, "Person", name="Mohammed Verd", age=23, gender="Male", citizenship="Syria", ref1=references[["CNN2"]], status="arrested")
NoureddineAbraimi      = createNode(kblDB, "Person", name="Noureddine Abraimi", age=29, gender="Male", citizenship="Belgium", role="logistics", ref1=references[["WSJ5"]], status="wanted")
OmarMostefai      = createNode(kblDB, "Person", name="Omar Ismaël Mostefaï", age=29, gender="Male", citizenship="France", ref1=references[["DM1"]], status="dead")
RedaHame          = createNode(kblDB, "Person", notInNov13=TRUE, name="Reda Hame", gender="Male", citizenship="France", age=30, ref1=references[["NYT4"]], ref2=references[["LP2"]], ref4=references[["LMD4"]], status="arrested")
SalahAbdeslam     = createNode(kblDB, "Person", name="Salah Abdeslam",       age=26, gender="Male", citizenship="France", ref1=references[["DM1"]], status="arrested")
SAbdeslamAccomplice     = createNode(kblDB, "Person", name="Unknown accomplice of Salah Abdeslam",  alias="Monir Ahmed Alaaj and Amine Choukri",  gender="Male", citizenship="unknown", ref1=references[["NYT12"]], status="arrested")
SnailFarisi     = createNode(kblDB, "Person", name="Snail Farisi",  age=32, DOB=1984, gender="Male", citizenship="Belgium", role="support", ref1=references[["EXP3"]], ref2=references[["GRD5"]], status="arrested")
SamyAmimour       = createNode(kblDB, "Person", name="Samy Amimour",         age=28, gender="Male", citizenship="France", ref1=references[["DM1"]], status="dead")
YoussefBazarouj   = createNode(kblDB, "Person", name="Youssef Bazarouj",  gender="Male", citizenship="Belgium", ref1=references[["SOI1"]], status="arrested")
YounesAbaaoud     = createNode(kblDB, "Person", notInNov13=TRUE, name="Younes Abaaoud",      age=13,      gender="Male", citizenship="Belgium", ref1=references[["GRD1"]], status="wanted")
YassineAbaaoud     = createNode(kblDB, "Person", notInNov13=TRUE, name="Yassine Abaaoud",        gender="Male", citizenship="Belgium", ref1=references[["WSJ3"]], status="wanted")
ZouhirMehdaoui     = createNode(kblDB, "Person", notInNov13=TRUE, name="Zouhir Mehdaoui", age=29,    gender="Male", citizenship="Algeria", ref1=references[["LEX1"]], status="arreted")


#the unknowns from Nov 13
#AbbdulakbakB     = createNode(kblDB, "Person", name="AbbdulakbakB",  age=25, gender="Male", ref1=references[["DM1"]], ref2=references[["LI1"]], status="dead", note="possibly fake passport or a victim_s name")
MohammedAlmahmod  = createNode(kblDB, "Person", name="Mohammed al-Mahmud", alias="Ali al-Iraqi ?", gender="Male",  citizenship="unknown", ref1=references[["BBC1"]], ref2=references[["DBQ1"]], status="dead")
AhmedAlmuhamed    = createNode(kblDB, "Person", name="Ahmed Almuhamed",    alias="Anashah al-Iraqi ?",  gender="Male", citizenship="unknown", ref1=references[["DM1"]], ref2=references[["DBQ1"]], status="dead")

ZakariaJaffal = createNode(kblDB, "Person", name="Zakaria Jaffak", age=29, DOB=1986, gender="Male", citizenship="Belgium", ref1=references[["DW1"]], ref2=references[["B7S71"]], status="arrested")
MustafaE      = createNode(kblDB, "Person", name="Mustafa E", age=34, DOB=1981, gender="Male", citizenship="Morocco", ref1=references[["DW1"]], status="arrested")
createRel(MustafaE, "LINKED_TO", ZakariaJaffal, note="might be unrelated", ref1=references[["DW1"]])
createRel(ZakariaJaffal, "LINKED_TO", AbdelhamidAbaaoud, ref1=references[["B7S71"]])

#BrusselsUnknown  = createNode(kblDB, "Person", name="BrusselsUnknown", ref1=references[["WSJ2"]], status="arrested")
#possibly one of the people below

MohamedS         = createNode(kblDB, "Person", name="MohamedS", age=25, gender="Male", role="logistics", note="petty criminal assisted with finding safe house", citizenship="unknown", ref1=references[["FTF1"]], status="arrested")
#apparently not the BrusselsUnknown

MohamedBelkaid    = createNode(kblDB, "Person", name="Mohamed Belkaïd", age=35, alias = "Samir Bouzid", gender="Male", citizenship="Algeria", role="logistics", ref1=references[["TL1"]], ref2=references[["NYT12"]], ref3=references[["GRD"]], status="dead")

HasnaAitboulahcen  = createNode(kblDB, "Person", name="Hasna Aitboulahcen", age=26, DOB="August 12, 1989", gender="Female",  status="dead", citizenship="France", ref1=references[["LOB1"]], ref2=references[["NP1"]], ref3=references[["CNN3"]], ref4=references[["FTF2"]])

#Early 2015 plots
RedouaneHagaoui  = createNode(kblDB, "Person", notInNov13=TRUE, name="Redouane Hagaoui", alias="Abu Khalid Al Maghribi", gender="Male", age=23, citizenship="Belgium", ref1=references[["DM2"]], status="dead")
TarikJadaoun     = createNode(kblDB, "Person", notInNov13=TRUE, name="Tarik Jadaoun", alias="Abu Hamza Belgiki", gender="Male", citizenship="Belgium", ref1=references[["DM2"]], status="dead")

MehdiNemmouche       = createNode(kblDB, "Person", notInNov13=TRUE, name="Mehdi Nemmouche",  gender="Male", citizenship="France", ref1=references[["LOB1"]], status="arrested")
AyoubElKhazzani       = createNode(kblDB, "Person", notInNov13=TRUE, name="Ayoub El Khazzani",  age=25, gender="Male", citizenship="Morocco", ref1=references[["LOB1"]], status="arrested")  #http://www.cnn.com/2015/08/24/europe/france-train-attack-what-we-know-about-suspect/


#Brussels
IbrahimElBakraoui = createNode(kblDB, "Person", name="Ibrahim El Bakraoui", notInNov13=FALSE, age=29, gender="Male", citizenship="Belgium", ref1=references[["NYT13"]], status="dead")
KhalidElBakraoui = createNode(kblDB, "Person", name="Khalid El Bakraoui", alias="Ibrahim Maaroufi", notInNov13=FALSE, age=27, gender="Male", citizenship="Belgium", role="logistics", ref1=references[["NYT13"]], status="dead")
NajimLaachraoui = createNode(kblDB, "Person", name="Najim Laachraoui", alias="Soufiane Kayal", notInNov13=FALSE, age=24, DOB="18/05/1991", gender="Male", citizenship="Belgium", role="weapons", ref1=references[["NBC3"]], ref2=references[["ITP1"]], status="dead")

OsamaKrayem = createNode(kblDB, "Person", name="Osama Krayem", alias="Naim Al Ahmed", gender="Male", age=23, citizenship="Sweden", notInNov13=FALSE, ref1=references[["TOI1"]], status="arrested")
HerveBM     = createNode(kblDB, "Person", name="Herve BM", gender="Male", citizenship="Rwanda", notInNov13=FALSE, note="Arrested with Abrini", ref1=references[["TOI1"]], ref2=references[["BBC3"]], status="arrested")

#now free
#FayçalCheffou = createNode(kblDB, "Person", name="Fayçal Cheffou", gender="Male", ref1=references[["NYT14"]], ref2=references[["NBC4"]], status="free")

#"Kriket" independent cell
RedaKriket = createNode(kblDB, "Person", name="Reda Kriket", notInNov13=TRUE, age=34, gender="Male", citizenship="France", role="finance", ref1=references[["NYT14"]], ref1=references[["EXP3"]], status="arrested")
#3 arrested in Belgium
YassineA           = createNode(kblDB, "Person", notInNov13=TRUE, name="Yassine A", age=33, DOB="1982.0504", gender="Male", citizenship="Belgium", ref1=references[["STT1"]],  status="arrested")
RabahN             = createNode(kblDB, "Person", notInNov13=TRUE, name="Rabah N", age=34, gender="Male", citizenship="Algeria", ref1=references[["NYT14"]], status="arrested", note="Rebah M in some sources")
AbderahmaneAmeroud = createNode(kblDB, "Person", notInNov13=TRUE, name="Abderamane Ameroud", age=38, gender="Male", citizenship="Algeria", ref1=references[["BBC2"]],  status="arrested")
AnisBahri          = createNode(kblDB, "Person", notInNov13=TRUE, name="Anis Bahri", age=32, gender="Male", citizenship="France", ref1=references[["DN1"]],  status="arrested")
AboubakerO         = createNode(kblDB, "Person", notInNov13=TRUE, name="Aboubaker O", age=28, gender="Male", citizenship="unknown", ref1=references[["NYT14"]], status="arrested")
MohamedB           = createNode(kblDB, "Person", notInNov13=TRUE, name="Mohamed B", age=37, gender="Male", citizenship="unknown", ref1=references[["NYT14"]], status="arrested")
#no other details provided by the police for confidentiality reasons

#associate of Bakraouis
DusseldorfSuspect = createNode(kblDB, "Person", name="Dusseldorf Suspect", gender="Male", age=28, citizenship="Germany", ref1=references[["CNN5"]], status="arrested")
createRel(DusseldorfSuspect, "LINKED_TO", IbrahimElBakraoui, note="arrested together in Turkey", ref1=references[["NYT15"]])
createRel(DusseldorfSuspect, "LINKED_TO", KhalidElBakraoui, ref1=references[["NYT15"]])

GiessenSuspect = createNode(kblDB, "Person", name="Giessen Suspect", gender="Male", age=28, citizenship="Morocco", ref1=references[["NYT15"]], status="arrested")
createRel(GiessenSuspect, "LINKED_TO", SalahAbdeslam, ref1=references[["NYT15"]])
createRel(GiessenSuspect, "LINKED_TO", KhalidElBakraoui, ref1=references[["NYT15"]])

createRel(OsamaKrayem, "LINKED_TO", NajimLaachraoui, ref1=references[["NYT15"]])
createRel(OsamaKrayem, "LINKED_TO", KhalidElBakraoui, ref1=references[["NYT15"]])
createRel(OsamaKrayem, "LINKED_TO", MohamedAbrini, ref1=references[["NYT15"]])

YoniPatricMayne  = createNode(kblDB, "Person", notInNov13=TRUE, name="Yoni Patric Mayne", age=25, gender="Male", citizenship="Belgium", note="also, Mali citizenship", status="wanted", ref1=references[["CNN6"]], ref2=references[["WSJ6"]])
createRel(YoniPatricMayne, "LINKED_TO",  AbdelhamidAbaaoud, ref1=references[["CNN6"]])
createRel(YoniPatricMayne, "LINKED_TO",  YounesAbaaoud, ref1=references[["CNN6"]])

DjamalEddineOuali = createNode(kblDB, "Person", name="Djamal Eddine Ouali", gender="Male", age=40, citizenship="Algeria", status="arrested", role="logistics", ref1=references[["DM6"]])
createRel(DjamalEddineOuali, "LINKED_TO", NajimLaachraoui, ref1=references[["DM6"]])
#Hundreds of digital photographs were then seized from a counterfeiter's workshop, including three of those who planned the deadly attacks in Paris in November.
createRel(DjamalEddineOuali, "LINKED_TO", SalahAbdeslam, ref1=references[["EXP2"]])
createRel(DjamalEddineOuali, "LINKED_TO", MohamedBelkaid, ref1=references[["EXP2"]])
createRel(DjamalEddineOuali, "LINKED_TO", KhalidElBakraoui, ref1=references[["TDB1"]])
#curious: many of the attackers traveled to Italy... 

BilalElMakhoukhi  = createNode(kblDB, "Person", notInNov13=TRUE, name="Bilal El Makhoukhi", age=27, gender="Male", citizenship="Belgium", status="arrested", ref1=references[["UST1"]])
#arrested in Etterbeek

#KhalidAlZerkani network
createRel(KhalidAlZerkani, "LINKED_TO", YoniPatricMayne, note="recruited", ref1=references[["CNN6"]])
createRel(KhalidAlZerkani, "LINKED_TO", AnisBahri, note="recruited", ref1=references[["CNN6"]])  #source is not clear
createRel(KhalidAlZerkani, "LINKED_TO", AbdelhamidAbaaoud, ref1=references[["CNN6"]])
createRel(KhalidAlZerkani, "LINKED_TO", RedaKriket, note="recruited", ref1=references[["CNN6"]])
createRel(KhalidAlZerkani, "LINKED_TO", GelelAttar, note="recruited", ref1=references[["HLN1"]])
createRel(KhalidAlZerkani, "LINKED_TO", NajimLaachraoui, note="financed travel to Syria", ref1=references[["WSJ5"]])


createRel(IbrahimFarisi, "LINKED_TO", SnailFarisi, note="brother", ref1=references[["EXP3"]])

createRel(AbdelhamidAbaaoud, "LINKED_TO", MehdiNemmouche, ref1=references[["CNN6"]])

SamiZarrouk = createNode(kblDB, "Person", notInNov13=TRUE, name="Sami Zarrouk", gender="Male", age=32, DOB="1983-09-13", citizenship="Tunis", status="wanted", ref1=references[["WSJ5"]])
createRel(KhalidAlZerkani, "LINKED_TO", SamiZarrouk, ref1=references[["WSJ5"]])

NicholasMoreau = createNode(kblDB, "Person", notInNov13=TRUE, name="Nicholas Moreau", gender="Male", citizenship="France", status="arrested", ref1=references[["CNN6"]])
createRel(AbdelhamidAbaaoud, "LINKED_TO", NicholasMoreau, ref1=references[["CNN6"]])
#been_to syria


#unspecified terrorism
#released Tawfik A

#linked to Bilal
SamirZ = createNode(kblDB, "Person", age=20, name="Samir Z", gender="Male", citizenship="France", ref1=references[["IBT2"]], ref2=references[["ST1"]], ref3=references[["CBS2"]], ref4=references[["AFP1"]],  status="free")
PierreN = createNode(kblDB, "Person", age=28, name="Pierre N", gender="Male", citizenship="Belgium", ref1=references[["IBT2"]], ref2=references[["ST1"]], status="arrested")

CharaffeAlMouadan  = createNode(kblDB, "Person", name="Charaffe al Mouadan", alias="Souleymane", age=27, gender="Male", role="planner", citizenship="France", status="dead", ref1=references[["LP3"]])
SamirBouabout  = createNode(kblDB, "Person", name="Samir Bouabout", age=28, citizenship="France", gender="Male",  status="wanted", ref1=references[["LMD8"]])

###################
# PAST PLOTS BY KBL
###################
#by some accounts, the operation was done by ENMI rather than KBL
#LP2, http://www.francetvinfo.fr/monde/proche-orient/offensive-jihadiste-en-irak/un-jihadiste-incarcere-en-france-detaille-comment-l-etat-islamique-deploie-son-reseau-d-espionnage_1055939.html

FrenchRivieraPlot = createNode(kblDB, "AttackSite", attackDate=2015, name="French Riviera Plot", outcome="aborted", killed=0, wounded=0, ref=references[["NYT17"]])
createRel(RedaHame, "INVOLVED_IN", FrenchRivieraPlot, ref1=references[["NYT17"]])
createRel(AugUnknown, "INVOLVED_IN", FrenchRivieraPlot, ref1=references[["NYT17"]])


######
# Nodes
######

#countries (some countries not used)
#Belgium = createNode(kblDB, "Country", name="Belgium")
#Egypt  = createNode(kblDB, "Country", name="Egypt")
#France = createNode(kblDB, "Country", name="France")
#Morocco = createNode(kblDB, "Country", name="Morocco")
Greece = createNode(kblDB, "Country", name="Greece")
Syria = createNode(kblDB, "Country", name="Syria")
Turkey = createNode(kblDB, "Country", name="Turkey")
UK = createNode(kblDB, "Country", name="United Kingdon")

BazaroujFamily  = createNode(kblDB, "Activity", name="Bazarouj family", note="likely primarily not radical")

#localities / sites
AlfortvilleApt  = createNode(kblDB, "Site", name="Alfortville apartment in Appart’City")
AnderlechtArrest  = createNode(kblDB, "Site", name="Arrest site in Anderlecht near Brussels", ref1=references[["TOI1"]])
AuvelaisHouse = createNode(kblDB, "Site", name="Auvelais, Belgium", note="rented in October", role="suspected planning site and bomb making")
Bobigny       = createNode(kblDB, "Site", name="Bobigny apartment")
CharleroiApt  = createNode(kblDB, "Site", name="Charleroi apartment", note="Rue du Fort. Rented in September", ref1=references[["NYT10"]])
EtterbeekApt  = createNode(kblDB, "Site", name="Etterbeek apartment", note="rue des Casernes", ref1=references[["EXP3"]])
ForestApt     = createNode(kblDB, "Site", name="Safehouse Apartment at Forest", address="Rue du Dries, Forest, Brussels", ref1=references[["NYT12"]])
HouseInMolenbeek = createNode(kblDB, "Site", name="Safehouse at Molenbeek", address="Jouse on the Rue des Quatre-Vents, Molenbeek", ref1=references[["NYT12"]])
Laeken        = createNode(kblDB, "Locality", name="Laeken, Brussels", ref1=references[["NYT13"]])
Molenbeek     = createNode(kblDB, "Locality", name="Molenbeek, Brussels", location="various")
NederOverHeembeek   = createNode(kblDB, "Locality", name="Neder-over-Heembeek", location="various")
StDenis       = createNode(kblDB, "Site", name="St.Denis", address="8 rue du Carillon and rue Carnot", ref1=references[["NBC1"]])
SchaerbeekApt = createNode(kblDB, "Site", name="Schaerbeek bomb factory", address="Rue Henri Berge", ref1=references[["DM5"]])
SchaerbeekApt2 = createNode(kblDB, "Site", name="Schaerbeek safehouse", address="Rue Max Roos", ref1=references[["BBN1"]])
#Used by airport attackers

#attack sites.  dates are approximate, if the attack was interdicted.
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

ZaventemAirport  = createNode(kblDB, "AttackSite", attackDate=2016.0322, name="Brussels Airport Zaventem", killed=21, wounded=81)
MaalbeckMetro    = createNode(kblDB, "AttackSite", attackDate=2016.0322, name="Maalbeck Metro", killed=14, wounded=220)
France2016plot    = createNode(kblDB, "AttackSite", attackDate=2016, name="Interdicted plot in France led by Kriket")


#Known Syria connections
createRel(AbuMuhammadAlAdnani,  "PRESENT_IN", Syria, ref1=references[["DM1"]])
createRel(AbuMuhammadAlShimali, "PRESENT_IN", Syria, ref1=references[["DM1"]])
createRel(AhmedAlmuhamed,     "PRESENT_IN", Syria, ref1=references[["IND1"]])
createRel(AbdelhamidAbaaoud,  "PRESENT_IN", Syria, ref1=references[["DM1"]])
createRel(AhmetTahir,       "PRESENT_IN", Syria, ref1=references[["CNN2"]])
createRel(AugUnknown,       "PRESENT_IN", Syria, ref1=references[["NYT4"]])
createRel(BilalHadfi,         "PRESENT_IN", Syria, ref1=references[["DM1"]])
createRel(BilalElMakhoukhi,    "PRESENT_IN", date=2012, Syria, ref1=references[["UST1"]])
createRel(FabienClain,          "PRESENT_IN", Syria, ref1=references[["DM1"]])
createRel(FouedMohamedAggad,    "PRESENT_IN", Syria, ref1=references[["GRD2"]])
createRel(GelelAttar,         "PRESENT_IN", Syria, ref1=references[["LMD6"]])
createRel(IbrahimElBakraoui,  "PRESENT_IN", Syria, date=2015.06, ref1=references[["NYT13"]])
createRel(MohammedAlmahmod,   "PRESENT_IN", Syria, ref1=references[["IND1"]])
createRel(MohammedVerd,     "PRESENT_IN", Syria, ref1=references[["CNN2"]])
createRel(NajimLaachraoui,  "PRESENT_IN", Syria, date=2013, ref1=references[["NBC3"]])
createRel(RedouaneHagaoui,   "PRESENT_IN", Syria, ref1=references[["DM2"]])
createRel(RedaHame,   "PRESENT_IN", Syria, ref1=references[["NYT4"]])
createRel(RedaKriket,  "PRESENT_IN", Syria, date=2014, ref1=references[["NYT14"]])
createRel(OmarMostefai,       "PRESENT_IN", Syria, date="2013", ref1=references[["DM1"]])
createRel(SamyAmimour,        "PRESENT_IN", Syria, ref1=references[["NEW2"]])
createRel(SamiZarrouk, "PRESENT_IN", Syria, date=2013, ref1=references[["WSJ5"]])
createRel(YoniPatricMayne,        "PRESENT_IN", Syria, date=2013, ref1=references[["CNN6"]])
createRel(YoniPatricMayne,        "PRESENT_IN", Syria, date=2014, ref1=references[["CNN6"]])



#Known Turkey connections
createRel(OmarMostefai,       "PRESENT_IN", Turkey, date="2010", ref1=references[["DM1"]])
createRel(AhmetDahmani,     "PRESENT_IN", Turkey, ref1=references[["CNN2"]])
createRel(AhmetTahir,       "PRESENT_IN", Turkey, ref1=references[["CNN2"]])

createRel(DusseldorfSuspect,       "PRESENT_IN", Turkey, ref1=references[["NYT15"]])
createRel(IbrahimElBakraoui,       "PRESENT_IN", Turkey, ref1=references[["NYT15"]])


#UK travel
createRel(MohamedAbrini,       "PRESENT_IN", UK, date=2015.07,  ref1=references[["NYT9"]])
createRel(AbdelhamidAbaaoud,   "PRESENT_IN", UK, date="unknown", ref1=references[["NYT9"]])

#Greece transits
createRel(AbdelhamidAbaaoud,  "PRESENT_IN", Greece, ref1=references[["EXP1"]])
createRel(AhmedAlmuhamed,     "PRESENT_IN", Greece, ref1=references[["EXP1"]])
createRel(MohammedAlmahmod,     "PRESENT_IN", Greece, ref1=references[["IND1"]])

#known Molenbeek or others
createRel(AbdelhamidAbaaoud,  "PRESENT_IN", Molenbeek, ref1=references[["DM1"]])
createRel(IbrahimAbdeslam,    "PRESENT_IN", Syria, ref1=references[["LMD3"]])
createRel(IbrahimAbdeslam,    "PRESENT_IN", Molenbeek, ref1=references[["NBC2"]])
createRel(AbdoullahCourkzine,         "PRESENT_IN", Molenbeek, ref1=references[["NYT7"]])
createRel(SamirZ,             "PRESENT_IN", Molenbeek, ref1=references[["ST1"]])
createRel(SamiZarrouk, "PRESENT_IN", Molenbeek, ref1=references[["WSJ5"]])
createRel(PierreN,            "PRESENT_IN", Molenbeek, ref1=references[["ST1"]])
createRel(SalahAbdeslam,      "PRESENT_IN", Molenbeek, ref1=references[["NBC2"]])
createRel(BilalHadfi,         "PRESENT_IN", NederOverHeembeek, ref1=references[["NYT8"]])
createRel(AyoubBazarouj,      "PRESENT_IN", Molenbeek, ref1=references[["SOI1"]])
createRel(YoussefBazarouj,    "PRESENT_IN", Molenbeek, ref1=references[["SOI1"]])
createRel(ZakariaJaffal,  "PRESENT_IN", Molenbeek, ref1=references[["DW1"]])

createRel(KhalidAlZerkani, "PRESENT_IN", Molenbeek, ref1=references[["DN1"]])
createRel(SamiZarrouk, "PRESENT_IN", Molenbeek, ref1=references[["WSJ5"]])


#Auvelias - planning site
createRel(MohamedBakkali,  "PRESENT_IN", AuvelaisHouse, ref1=references[["ST1"]], ref2=references[["NYT10"]])
createRel(SAbdeslamAccomplice,   "PRESENT_IN", AuvelaisHouse, ref1=references[["NYT12"]])
createRel(NajimLaachraoui,   "PRESENT_IN", AuvelaisHouse, ref1=references[["DM3"]])

createRel(MohamedBakkali,   "PRESENT_IN", CharleroiApt, ref1=references[["EXP4"]])
createRel(AbdelhamidAbaaoud,   "PRESENT_IN", CharleroiApt, ref1=references[["NYT10"]])
createRel(BilalHadfi,   "PRESENT_IN", CharleroiApt, ref1=references[["NYT10"]])
createRel(KhalidElBakraoui,  "PRESENT_IN", CharleroiApt, ref1=references[["NYT13"]])

#EtterbeekApt
createRel(SnailFarisi,  "PRESENT_IN", EtterbeekApt, ref1=references[["EXP3"]])
createRel(IbrahimFarisi,  "PRESENT_IN", EtterbeekApt, ref1=references[["EXP3"]])
createRel(KhalidElBakraoui,  "PRESENT_IN", EtterbeekApt, ref1=references[["UST1"]])
createRel(OsamaKrayem,       "PRESENT_IN", EtterbeekApt, ref1=references[["UST1"]])

#ForestApt
createRel(SalahAbdeslam,    "PRESENT_IN", ForestApt, ref1=references[["NYT12"]])
createRel(MohamedBelkaid,   "PRESENT_IN", ForestApt, ref1=references[["NYT12"]])
createRel(SAbdeslamAccomplice, "PRESENT_IN", ForestApt, ref1=references[["NYT12"]])
createRel(IbrahimElBakraoui,  "PRESENT_IN", ForestApt, ref1=references[["NYT13"]])

#HouseInMolenbeek
createRel(SalahAbdeslam,    "PRESENT_IN", HouseInMolenbeek, ref1=references[["NYT12"]])
createRel(SAbdeslamAccomplice, "PRESENT_IN", HouseInMolenbeek, ref1=references[["NYT12"]])

#SchaerbeekApt: bomb factory
createRel(SalahAbdeslam,  "PRESENT_IN", SchaerbeekApt, date=2015.1314, ref1=references[["DM5"]])
createRel(NajimLaachraoui,"PRESENT_IN", SchaerbeekApt, ref1=references[["NBC3"]])
createRel(MohamedBakkali,"PRESENT_IN", SchaerbeekApt, ref1=references[["EXP4"]])

#SchaerbeekApt2: safehouse
createRel(MohamedBakkali, "PRESENT_IN", SchaerbeekApt2, ref1=references[["EXP4"]])
createRel(IbrahimElBakraoui, "PRESENT_IN", SchaerbeekApt2, ref1=references[["NYT13"]])
createRel(KhalidElBakraoui, "PRESENT_IN", SchaerbeekApt2, ref1=references[["NYT13"]])

#StDennis
createRel(AbdelhamidAbaaoud,  "PRESENT_IN", StDenis, ref1=references[["LOB1"]])
createRel(HasnaAitboulahcen,  "PRESENT_IN", StDenis, ref1=references[["LOB1"]])
createRel(ChakibAkrouh,       "PRESENT_IN", StDenis, ref1=references[["CNN3"]])
createRel(JawadBendaoud,      "PRESENT_IN", StDenis, ref1=references[["LOB1"]])

#staging for attack
createRel(SalahAbdeslam, "PRESENT_IN", AlfortvilleApt, ref1=references[["DM1"]])
#others were in AlfortvilleApt too - no data was found b/c of lack of cameras (DNA?)

createRel(IbrahimAbdeslam, "PRESENT_IN", Bobigny, ref1=references[["DM1"]])
createRel(SalahAbdeslam, "PRESENT_IN", Bobigny, ref1=references[["DM1"]])
createRel(SamyAmimour, "PRESENT_IN", Bobigny, ref1=references[["DM1"]])

#lesser sites
#createRel(HasnaAitboulahcen,  "PRESENT_IN", AulnaySousBois, ref1=references[["CNN2"]]) #http://www.cnn.com/2015/11/19/europe/paris-attacks-at-a-glance/
#createRel(MohamedKhoualed,  "PRESENT_IN", Roubaix, ref1=references[["TEL1"]])


#Laeken cell
createRel(IbrahimElBakraoui, "PRESENT_IN", Laeken, ref1=references[["NYT13"]])
createRel(KhalidElBakraoui, "PRESENT_IN", Laeken, ref1=references[["NYT13"]])


#Kriket cell
createRel(RedaKriket,  "INVOLVED_IN", France2016plot, ref1=references[["NYT14"]])
createRel(RabahN,      "INVOLVED_IN", France2016plot, ref1=references[["NYT14"]])
createRel(YassineA,    "INVOLVED_IN", France2016plot, ref1=references[["STT1"]])
createRel(AbderahmaneAmeroud,  "INVOLVED_IN", France2016plot, ref1=references[["WP3"]])
createRel(AnisBahri,   "INVOLVED_IN", France2016plot, ref1=references[["WP3"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", RedaKriket, ref1=references[["NYT15"]])
createRel(RedaKriket,  "PRESENT_IN", Syria, date="2014", ref1=references[["NYT15"]])

# #transit countries
createRel(AbdelhamidAbaaoud,  "PRESENT_IN", Greece, ref1=references[["EXP1"]])
createRel(AhmedAlmuhamed,     "PRESENT_IN", Greece, ref1=references[["EXP1"]])

createRel(AhmetDahmani,     "PRESENT_IN", Turkey, ref1=references[["CNN2"]])
createRel(AhmetDahmani,     "PRESENT_IN", Syria, ref1=references[["CNN2"]])


#friend and familiar affiliations
createRel(IbrahimElBakraoui, "LINKED_TO", KhalidElBakraoui, note="brother", ref1=references[["NYT13"]])
createRel(SalahAbdeslam,     "LINKED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
#createRel(SalahAbdeslam,     "LINKED_TO", MohammadAbdeslam, note="brother", ref1=references[["DM1"]])
#createRel(MohammadAbdeslam , "LINKED_TO", IbrahimAbdeslam, note="brother", ref1=references[["DM1"]])
createRel(YoussefBazarouj,     "LINKED_TO", AyoubBazarouj, note="brother", ref1=references[["SOI1"]])

#createRel(MohamedAmimour,    "LINKED_TO", SamyAmimour, note="father_of", ref1=references[["DM1"]])
createRel(HasnaAitboulahcen, "LINKED_TO", AbdelhamidAbaaoud, note="cousin", ref1=references[["IBT2"]])
createRel(SalahAbdeslam,     "LINKED_TO", AbdelhamidAbaaoud, note="friends", ref1=references[["CNN1"]])
createRel(IbrahimAbdeslam,     "LINKED_TO", AbdelhamidAbaaoud, note="friends", ref1=references[["NYT5"]])

#AbdelhamidAbaaoud family
createRel(AbdelhamidAbaaoud,  "LINKED_TO", YounesAbaaoud,   note="brother, recruited", ref1=references[["GRD1"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", YassineAbaaoud,  note="brother, recruited", ref1=references[["GRD1"]])

createRel(AbdelhamidAbaaoud,  "LINKED_TO", RedaHame,  note="recruited", ref1=references[["GRD1"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", AugUnknown, note="recruited", ref1=references[["NYT17"]])

createRel(AhmedAlmuhamed, "LINKED_TO", MohammedAlmahmod, note="traveled together or may be related",  ref1=references[["IND1"]])

#GelelAttar arrest
createRel(GelelAttar, "LINKED_TO", AbdelhamidAbaaoud, note="possibly through explosive preparation",  ref1=references[["LMD6"]])
createRel(GelelAttar, "LINKED_TO", ChakibAkrouh, note="traveled together",  ref1=references[["LMD6"]])

createRel(AbdelhamidAbaaoud,  "LINKED_TO", OmarMostefai, note="uncharacterized", ref1=references[["NYT2"]])
createRel(AbdelhamidAbaaoud,  "LINKED_TO", BilalHadfi, note="led in Syria", ref1=references[["NYT2"]])

createRel(SamirZ,  "LINKED_TO", BilalHadfi, ref1=references[["IBT2"]])
createRel(PierreN, "LINKED_TO", BilalHadfi, ref1=references[["IBT2"]])

createRel(AhmetDahmani,     "LINKED_TO", SalahAbdeslam, ref1=references[["CNN4"]])

createRel(AbdeilahChouaa,    "LINKED_TO",  SalahAbdeslam, note="knew family", ref1=references[["VOA1"]])
createRel(AbdeilahChouaa,    "LINKED_TO",  MohamedAbrini, note="particularly close", ref1=references[["VOA1"]])

#foci - coded as INVOLVED_IN
createRel(SalahAbdeslam,     "INVOLVED_IN", BazaroujFamily, note="family friend", ref1=references[["SOI1"]])
createRel(AyoubBazarouj,     "INVOLVED_IN", BazaroujFamily, note="member", ref1=references[["SOI1"]])
createRel(YoussefBazarouj,   "INVOLVED_IN", BazaroujFamily, note="member", ref1=references[["SOI1"]])


#Ride1 to Bobigny in Renault Clio
DriveToBobigny = createNode(kblDB, "Activity", data=2015.1112, name="Drive to Bobigny (Clio)")
createRel(SalahAbdeslam,   "INVOLVED_IN",  DriveToBobigny,  ref1=references[["DM5"]])
createRel(IbrahimAbdeslam, "INVOLVED_IN",  DriveToBobigny,  ref1=references[["DM5"]])
createRel(MohamedAbrini,   "INVOLVED_IN",  DriveToBobigny,  ref1=references[["DM5"]])

#
TripFromUlm = createNode(kblDB, "Activity", data=2015.10, name="trip from Ulm")
createRel(SalahAbdeslam,   "INVOLVED_IN",  TripFromUlm,  ref1=references[["CNN6"]])
createRel(SAbdeslamAccomplice,   "INVOLVED_IN",  TripFromUlm,  ref1=references[["CNN6"]])
createRel(OsamaKrayem,   "INVOLVED_IN",  TripFromUlm,  ref1=references[["CNN6"]])

#Anderlecht
createRel(MohamedAbrini, "PRESENT_IN",  AnderlechtArrest,  ref1=references[["DM5"]])
createRel(HerveBM,       "PRESENT_IN",  AnderlechtArrest,  ref1=references[["DM5"]])
createRel(OsamaKrayem,   "PRESENT_IN",  AnderlechtArrest,  ref1=references[["DM5"]])

#Sharia4Belgium group
Sharia4Belgium = createNode(kblDB, "Activity", name="Radical group Sharia4Belgium")
createRel(BilalElMakhoukhi, "INVOLVED_IN", Sharia4Belgium,  ref1=references[["UST1"]])
#BBC5
#DM1: 43 men and three women alleged to be members of Sharia4Belgium


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
createRel(HamzaAttou,  "LINKED_TO", AliOulkadi,  ref1=references[["B7S71"]])


#Daesh core
OverallOrganization = createNode(kblDB, "Activity", name="Attack Organization")
createRel(FabienClain,          "INVOLVED_IN", OverallOrganization, ref1=references[["DM1"]])
createRel(AbuMuhammadAlAdnani,  "INVOLVED_IN", OverallOrganization, ref1=references[["NYT3"]], ref2=references[["NYT4"]])
createRel(AbuMuhammadAlShimali, "INVOLVED_IN", OverallOrganization, ref1=references[["GRD1"]])
createRel(AbdelhamidAbaaoud,    "INVOLVED_IN", OverallOrganization, ref1=references[["GRD1"]])
createRel(CharaffeAlMouadan,  "INVOLVED_IN", OverallOrganization, ref1=references[["LP3"]])
createRel(BoubakerAlHakim,  "INVOLVED_IN", OverallOrganization, ref1=references[["NYT11"]])
#wishlist: identify locations if different from Syria/Iraq

MakingExplosives = createNode(kblDB, "Activity", name="Making Explosives")
createRel(MohamedKhoualed,  "INVOLVED_IN", MakingExplosives, ref1=references[["TEL1"]])
createRel(SalahAbdeslam,    "INVOLVED_IN", MakingExplosives, ref1=references[["TEL1"]])
#possible link to GelelAttar, who was also into explosives

ExfilitrationThroughBelgium = createNode(kblDB, "Activity", name="Exfilitration Through Belgium")
createRel(SalahAbdeslam, "INVOLVED_IN", ExfilitrationThroughBelgium, ref1=references[["NYT4"]])
createRel(LazezAbraimi,  "INVOLVED_IN", ExfilitrationThroughBelgium, ref1=references[["NYT4"]])
createRel(MohamedAbrini, "INVOLVED_IN",  ExfilitrationThroughBelgium, ref1=references[["ABC1"]])
createRel(AliOulkadi,    "INVOLVED_IN",  ExfilitrationThroughBelgium, ref1=references[["DM2"]], ref2=references[["TL1"]])
createRel(AbdeilahChouaa,    "INVOLVED_IN",  ExfilitrationThroughBelgium, ref1=references[["VOA1"]])

ExfiltrationToSyria = createNode(kblDB, "Activity", name="Exfiltration To Syria")
createRel(MohammedVerd,  "INVOLVED_IN", ExfiltrationToSyria, ref1=references[["TEL1"]])
createRel(AhmetTahir,    "INVOLVED_IN", ExfiltrationToSyria, ref1=references[["TEL1"]])
createRel(AhmetDahmani,  "INVOLVED_IN", ExfiltrationToSyria, ref1=references[["TEL1"]])

MissionInHungary = createNode(kblDB, "Activity", name="Mission in Hungary")
createRel(NajimLaachraoui,     "INVOLVED_IN", MissionInHungary, ref1=references[["TL1"]], ref2=references[["NBC3"]])
createRel(MohamedBelkaid,       "INVOLVED_IN", MissionInHungary, ref1=references[["TL1"]])
createRel(AbdelhamidAbaaoud, "INVOLVED_IN", MissionInHungary, ref1=references[["TL1"]])

#StDenis safe house.  apparently pre-existing ties, rather than a joint mission
createRel(MohamedBelkaid,       "LINKED_TO", HasnaAitboulahcen,   note="transfer money after the attack", ref1=references[["TL1"]])
createRel(AbdoullahCourkzine,        "LINKED_TO", HasnaAitboulahcen,   note="unclear role. been in contact after attacks", ref1=references[["NYT7"]], ref2=references[["FIG2"]])
createRel(HasnaAitboulahcen, "LINKED_TO", MohamedS, note="knew", ref1=references[["FTF1"]])
createRel(MohamedS,          "LINKED_TO", JawadBendaoud, note="knew", ref1=references[["FTF1"]])

#planner
createRel(CharaffeAlMouadan,  "LINKED_TO", SamyAmimour, ref1=references[["LP3"]])
createRel(CharaffeAlMouadan,  "LINKED_TO", AbdelhamidAbaaoud, ref1=references[["LP3"]])

createRel(SamirBouabout,  "LINKED_TO", SamyAmimour, ref1=references[["LMD8"]])
createRel(SamirBouabout,  "LINKED_TO", AbdelhamidAbaaoud, ref1=references[["LMD8"]])
createRel(SamirBouabout,  "LINKED_TO", OmarMostefai, ref1=references[["LMD8"]])

createRel(ZakariaJaffal,          "LINKED_TO", AbdelhamidAbaaoud, note="friend", ref1=references[["AFP1"]])
createRel(ZouhirMehdaoui,    "LINKED_TO", AbdelhamidAbaaoud, note="friend", ref1=references[["LEX1"]])

#attacks
createRel(IbrahimAbdeslam, "INVOLVED_IN", ComptoirVoltaire, attackType="SuicideBombing", ref1=references[["DM1"]])

createRel(OmarMostefai,    "INVOLVED_IN",  Bataclan, attackType="SuicideBombing", ref1=references[["DM1"]])
createRel(SamyAmimour,     "INVOLVED_IN", Bataclan, attackType="Suicide", ref1=references[["DM1"]])
createRel(FouedMohamedAggad, "INVOLVED_IN", Bataclan, attackType="Suicide", ref1=references[["DM1"]])
#only 3 detonated.  several (all?) shot.  Volkswagen Polo abandoned at site
#some early reports from Bataclan report a 4th Female attacker/shooter and also AbbdulakbakB.  No evidence in later reports.

createRel(AhmedAlmuhamed, "INVOLVED_IN", StadeDeFrance, attackType="SuicideBombing", ref1=references[["DM1"]])
createRel(BilalHadfi,     "INVOLVED_IN", StadeDeFrance, attackType="SuicideBombing", ref1=references[["DM1"]])  
createRel(MohammedAlmahmod, "INVOLVED_IN", StadeDeFrance, attackType="SuicideBombing", note="detonated at nearby MacDonalds",  ref1=references[["DM1"]], ref2=references[["WSJ1"]])  
createRel(SalahAbdeslam, "INVOLVED_IN", StadeDeFrance, attackType="SuicideBombing", note="backed out",  ref1=references[["NYT18"]])  
# 

#gunmen in a black Seat Leon.  possibly Abdeslam brothers + unknown (YoussefBazarouj?  SOI1)
#http://www.lefigaro.fr/actualite-france/2015/11/18/01016-20151118ARTFIG00346-ce-que-l-on-sait-du-commando-qui-a-seme-la-terreur-a-paris.php
createRel(IbrahimAbdeslam, "INVOLVED_IN", LeCarillonBarAndLePetitCambodge, attackType="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "INVOLVED_IN", LeCarillonBarAndLePetitCambodge, attackType="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "INVOLVED_IN", LeCarillonBarAndLePetitCambodge, attackType="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "INVOLVED_IN", LaCasaNostra, attackType="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "INVOLVED_IN", LaCasaNostra, attackType="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "INVOLVED_IN", LaCasaNostra, attackType="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "INVOLVED_IN", LaBonneBiere, attackType="Shooting", ref1=references[["NEW2"]])  
createRel(SalahAbdeslam, "INVOLVED_IN", LaBonneBiere, attackType="Shooting", ref1=references[["NEW2"]])  
createRel(AbdelhamidAbaaoud, "INVOLVED_IN", LaBonneBiere, attackType="Shooting", ref1=references[["FOX1"]])  
#they moved on... DM1
createRel(IbrahimAbdeslam, "INVOLVED_IN", LaBelleEquipe, attackType="Shooting", ref1=references[["DM1"]])  
createRel(SalahAbdeslam, "INVOLVED_IN", LaBelleEquipe, attackType="Shooting", ref1=references[["DM1"]])  
createRel(AbdelhamidAbaaoud, "INVOLVED_IN", LaBelleEquipe, attackType="Shooting", ref1=references[["FOX1"]])  

#suspected attack 1
createRel(SalahAbdeslam, "INVOLVED_IN", Arrondisement18, attackType="Unknown", ref1=references[["DM1"]])

#suspected attack 2
createRel(AbdelhamidAbaaoud, "INVOLVED_IN", LaDefense, attackType="SuicideBombing", ref1=references[["LMD5"]])
createRel(ChakibAkrouh,      "INVOLVED_IN", LaDefense, attackType="SuicideBombing", ref1=references[["LMD5"]])

#suspected attack 3?
#+8 arrested in Saint Dennis with force 2015-11-18, http://www.nydailynews.com/news/world/paris-raid-killed-2-terror-suspects-time-article-1.2438743
#TARGETED Airport, Shopping Mall

#ZaventemAirport
createRel(IbrahimElBakraoui,  "INVOLVED_IN", ZaventemAirport, ref1=references[["NYT13"]])
createRel(NajimLaachraoui,  "INVOLVED_IN", ZaventemAirport, ref1=references[["NBC3"]])
createRel(MohamedAbrini,  "INVOLVED_IN", ZaventemAirport, ref1=references[["NYT13"]], ref2=references[["REU2"]])

#BrusselsMetro
createRel(KhalidElBakraoui,  "INVOLVED_IN", MaalbeckMetro, ref1=references[["UST1"]])
createRel(OsamaKrayem,       "INVOLVED_IN", MaalbeckMetro, ref1=references[["UST1"]])

######################
#PREVIOUS PLOTS BY KBL
######################
JewishMuseum       = createNode(kblDB, "AttackSite", attackDate=2014.0524, name="Jewish Museum of Belgium", attackType="Shooting", killed=4, wounded=0)
BrusselsParisTrain = createNode(kblDB, "AttackSite", attackDate=2015.0821, name="Brussels Paris Train attempt", attackType="Shooting", killed=0, wounded=2)
VerviersPlot       = createNode(kblDB, "AttackSite", attackDate=2015.0115, name="Police attack plot in Verviers", attackType="Shooting", killed=0, wounded=0, ref1=references[["DM1"]], ref2=references[["GRD1"]])

#BrusselsParisTrain
createRel(AyoubElKhazzani, "INVOLVED_IN", BrusselsParisTrain, attackType="Shooting", ref1=references[["NYT2"]])
createRel(AyoubElKhazzani, "LINKED_TO", AbdelhamidAbaaoud, ref1=references[["NYT4"]])
createRel(AyoubElKhazzani, "PRESENT_IN", Molenbeek, ref1=references[["NYT1"]])

#VerviersPlot
createRel(RedouaneHagaoui,  "INVOLVED_IN", VerviersPlot, ref1=references[["TEL3"]])
createRel(TarikJadaoun,     "INVOLVED_IN", VerviersPlot, ref1=references[["TEL3"]])
createRel(AbdelhamidAbaaoud,  "INVOLVED_IN", VerviersPlot, ref1=references[["TEL3"]])
createRel(NoureddineAbraimi,  "INVOLVED_IN", VerviersPlot, ref1=references[["WSJ5"]])

createRel(RedouaneHagaoui,  "PRESENT_IN", Molenbeek, ref1=references[["NYT3"]])
createRel(TarikJadaoun,     "PRESENT_IN", Molenbeek, ref1=references[["NYT3"]])

#"provided logistical support", but not actually INVOLVED_IN - code as link to the head of the plot
createRel(NoureddineAbraimi,  "LINKED_TO", AbdelhamidAbaaoud, ref1=references[["WSJ5"]])

createRel(NoureddineAbraimi,  "LINKED_TO", LazezAbraimi, note="brother", ref1=references[["WSJ5"]])

createRel(NoureddineAbraimi, "PRESENT_IN", Molenbeek, ref1=references[["WSJ5"]])
createRel(NoureddineAbraimi, "PRESENT_IN", Syria, date=2014, ref1=references[["WSJ5"]])

#Brussels Jewish Museum
createRel(MehdiNemmouche, "INVOLVED_IN", JewishMuseum, attackType="Shooting", ref1=references[["NYT2"]])
createRel(MehdiNemmouche, "LINKED_TO", AbdelhamidAbaaoud, note="liaised", ref1=references[["NYT2"]])
createRel(MehdiNemmouche, "PRESENT_IN", Molenbeek, ref1=references[["NYT2"]])

#load the data sources as nodes
# infoFiles <- list.files("~/academic/paris/media_references/")
# for(fname in infoFiles) {
#   createNode(kblDB, "InfoNode", name=fname)
#   #optionally, parse and add full text
# }
print("Database built!")

