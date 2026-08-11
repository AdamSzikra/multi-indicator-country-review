BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Eroforrasok" (
	"ID"	INTEGER,
	"Megnevezes"	TEXT NOT NULL UNIQUE,
	"Kategoria"	TEXT NOT NULL,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Etnikumok" (
	"ID"	INTEGER,
	"Nev"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Ipari_Szektorok" (
	"ID"	INTEGER,
	"Nev"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Kereskedelmi_Fotermek" (
	"ID"	INTEGER,
	"Nev"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Nemzet" (
	"ID"	INTEGER,
	"Orszag_Nev"	TEXT NOT NULL UNIQUE,
	"Regio"	TEXT NOT NULL,
	"Kereskedelmi_Elerhetoseg"	TEXT NOT NULL DEFAULT 'Szárazföld',
	"Politikai_Rendszer"	TEXT NOT NULL,
	"Politikai_Jegyzet"	TEXT,
	"Gazdasagi_Modell"	TEXT NOT NULL,
	"Gazdasagi_Jegyzet"	TEXT,
	"Populacio_Szam"	INTEGER,
	"Korszerkezet"	TEXT,
	"YY_GDP_2024"	REAL,
	"Infrastruktura_szint"	TEXT,
	"Infrastruktura_megjegyzes"	TEXT,
	"Kihivasok"	TEXT,
	"Geopolitikai_Doktrina"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Nemzet_Biztonsagi_Profil" (
	"Nemzet_id"	INTEGER,
	"Kiemelt_Katonai_Nem"	TEXT NOT NULL DEFAULT 'Szárazföldi',
	"Katonai_Jegyzet"	TEXT,
	"Nuklearis_Hatalom"	BOOLEAN NOT NULL CHECK("Nuklearis_Hatalom" IN (0, 1)),
	"DefExp_GDP_2024_Szazalek"	REAL,
	"Stabilitasi_szint"	TEXT,
	"Stabilitasi_jegyzet"	TEXT,
	PRIMARY KEY("Nemzet_id"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Eroforras_Kapcsolat" (
	"Nemzet_id"	INTEGER,
	"Eroforras_id"	INTEGER,
	PRIMARY KEY("Nemzet_id","Eroforras_id"),
	FOREIGN KEY("Eroforras_id") REFERENCES "Eroforrasok"("id"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Etnikumok_Kapcsolat" (
	"Nemzet_id"	INTEGER,
	"Etnikumok_id"	INTEGER,
	"Arany_Szazalek"	INTEGER,
	"Megjegyzes"	TEXT,
	PRIMARY KEY("Nemzet_id","Etnikumok_id"),
	FOREIGN KEY("Etnikumok_id") REFERENCES "Etnikumok"("id"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Iparstruktúra_Kapcsolat" (
	"Nemzet_id"	INTEGER,
	"Ipari_Szektorok_id"	INTEGER,
	"Kiemelt_Agazat_Sulyozas"	INTEGER,
	PRIMARY KEY("Nemzet_id","Ipari_Szektorok_id"),
	FOREIGN KEY("Ipari_Szektorok_id") REFERENCES "Ipari_Szektorok"("id"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Kereskedelmi_Partnerek" (
	"Nemzet_A_id"	INTEGER,
	"Nemzet_B_id"	INTEGER,
	PRIMARY KEY("Nemzet_A_id","Nemzet_B_id"),
	FOREIGN KEY("Nemzet_A_id") REFERENCES "Nemzet"("id"),
	FOREIGN KEY("Nemzet_B_id") REFERENCES "Nemzet"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Rivalizalas" (
	"Nemzet_A_id"	INTEGER,
	"Nemzet_B_id"	INTEGER,
	"Jegyzet"	TEXT,
	"Is_Active"	BOOLEAN,
	PRIMARY KEY("Nemzet_A_id","Nemzet_B_id"),
	FOREIGN KEY("Nemzet_A_id") REFERENCES "Nemzet"("id"),
	FOREIGN KEY("Nemzet_B_id") REFERENCES "Nemzet"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Szovetseg_Kapcsolat" (
	"Nemzet_id"	INTEGER,
	"Szovetseg_id"	INTEGER,
	"Tagsag_Statusza"	TEXT,
	"Magyarazat"	TEXT,
	"Suly_Ertek"	INTEGER,
	PRIMARY KEY("Nemzet_id","Szovetseg_id"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id"),
	FOREIGN KEY("Szovetseg_id") REFERENCES "Szovetsegek"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Tajegyseg_Kapcsolat" (
	"Nemzet_id"	INTEGER,
	"Tajegyseg_id"	INTEGER,
	"Leiras_Specifikus"	TEXT,
	PRIMARY KEY("Nemzet_id","Tajegyseg_id"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id"),
	FOREIGN KEY("Tajegyseg_id") REFERENCES "Tajegyseg_Tipus"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Technologia_Kapcsolat" (
	"Nemzet_id"	INTEGER,
	"Fo_Technologia_id"	INTEGER,
	"Megjegyzes"	TEXT,
	PRIMARY KEY("Nemzet_id","Fo_Technologia_id"),
	FOREIGN KEY("Fo_Technologia_id") REFERENCES "Technologia"("id"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Termek_Profil" (
	"Nemzet_id"	INTEGER,
	"Termek_id"	INTEGER,
	"Irany"	TEXT,
	PRIMARY KEY("Nemzet_id","Termek_id","Irany"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id"),
	FOREIGN KEY("Termek_id") REFERENCES "Kereskedelmi_Fotermek"("id")
);
CREATE TABLE IF NOT EXISTS "Nemzet_Vallas_Kapcsolat" (
	"Nemzet_id"	INTEGER,
	"Vallas_id"	INTEGER,
	"Arany_Szazalek"	INTEGER,
	"Megjegyzes"	TEXT,
	PRIMARY KEY("Nemzet_id","Vallas_id"),
	FOREIGN KEY("Nemzet_id") REFERENCES "Nemzet"("id"),
	FOREIGN KEY("Vallas_id") REFERENCES "Vallasok"("id")
);
CREATE TABLE IF NOT EXISTS "Szovetsegek" (
	"ID"	INTEGER,
	"Nev"	TEXT,
	"Tipus"	TEXT,
	"Leiras"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Tajegyseg_Tipus" (
	"ID"	INTEGER,
	"Tipus"	TEXT,
	"Strategiai_Elony"	TEXT,
	"Strategiai_Hatrany"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Technologia" (
	"ID"	INTEGER,
	"Tech_Nev"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Vallasok" (
	"ID"	INTEGER,
	"Nev"	TEXT,
	PRIMARY KEY("ID" AUTOINCREMENT)
);
INSERT INTO "Eroforrasok" VALUES (1,'Vas','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (2,'Bauxit','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (3,'Kobalt','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (4,'Réz','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (5,'Ólom','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (6,'Ón','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (7,'Wolfram','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (8,'Kromit','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (9,'Fémek (vegyes)','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (10,'Arany','Nemesfém');
INSERT INTO "Eroforrasok" VALUES (11,'Ezüst','Nemesfém');
INSERT INTO "Eroforrasok" VALUES (12,'Nemesfémek (vegyes)','Nemesfém');
INSERT INTO "Eroforrasok" VALUES (13,'Mészkő','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (14,'Só','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (15,'Hamuzsír','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (16,'Foszfát','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (17,'Agyag','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (18,'Kén','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (19,'Borát','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (20,'Gipsz','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (21,'Hélium','Ipari fém és ásvány');
INSERT INTO "Eroforrasok" VALUES (22,'Drágakő','Drágakő');
INSERT INTO "Eroforrasok" VALUES (23,'Aszfalt','Építőanyag');
INSERT INTO "Eroforrasok" VALUES (24,'Fa','Agrár és élelmiszer');
INSERT INTO "Eroforrasok" VALUES (25,'Tengeri élővilág','Agrár és élelmiszer');
INSERT INTO "Eroforrasok" VALUES (26,'Halászat','Agrár és élelmiszer');
INSERT INTO "Eroforrasok" VALUES (27,'Pálma','Agrár és élelmiszer');
INSERT INTO "Eroforrasok" VALUES (28,'Urán','Energiahordozó');
INSERT INTO "Eroforrasok" VALUES (29,'Thorium','Energiahordozó');
INSERT INTO "Eroforrasok" VALUES (30,'Ritkaföldfémek','Kritikus technológiai nyersanyag');
INSERT INTO "Eroforrasok" VALUES (31,'Szén','Energiahordozó');
INSERT INTO "Eroforrasok" VALUES (32,'Kőolaj','Energiahordozó');
INSERT INTO "Eroforrasok" VALUES (33,'Földgáz','Energiahordozó');
INSERT INTO "Eroforrasok" VALUES (34,'Fosszilis energia (vegyes)','Energiahordozó');
INSERT INTO "Etnikumok" VALUES (1,'Arab');
INSERT INTO "Etnikumok" VALUES (2,'Perzsa');
INSERT INTO "Etnikumok" VALUES (3,'Török');
INSERT INTO "Etnikumok" VALUES (4,'Kurd');
INSERT INTO "Etnikumok" VALUES (5,'Zsidó');
INSERT INTO "Etnikumok" VALUES (6,'Han kínai');
INSERT INTO "Etnikumok" VALUES (7,'Orosz');
INSERT INTO "Etnikumok" VALUES (8,'Koreai');
INSERT INTO "Etnikumok" VALUES (9,'Indo-árja');
INSERT INTO "Etnikumok" VALUES (10,'Dravida');
INSERT INTO "Etnikumok" VALUES (11,'Pastu');
INSERT INTO "Etnikumok" VALUES (12,'Pandzsábi');
INSERT INTO "Etnikumok" VALUES (13,'Szindhi');
INSERT INTO "Etnikumok" VALUES (14,'Fehér / Kaukázusi');
INSERT INTO "Etnikumok" VALUES (15,'Afroamerikai / Fekete');
INSERT INTO "Etnikumok" VALUES (16,'Hispán / Latino');
INSERT INTO "Etnikumok" VALUES (17,'Ázsiai származású');
INSERT INTO "Etnikumok" VALUES (18,'Dél-ázsiai / Indiai-Pakisztáni');
INSERT INTO "Etnikumok" VALUES (19,'Ujgur');
INSERT INTO "Etnikumok" VALUES (20,'Tibeti');
INSERT INTO "Ipari_Szektorok" VALUES (1,'Bányászat');
INSERT INTO "Ipari_Szektorok" VALUES (2,'Szolgáltató szektor');
INSERT INTO "Ipari_Szektorok" VALUES (3,'Luxusipar');
INSERT INTO "Ipari_Szektorok" VALUES (4,'Katonai ipar');
INSERT INTO "Ipari_Szektorok" VALUES (5,'Feldolgozóipar');
INSERT INTO "Ipari_Szektorok" VALUES (6,'Textilipar');
INSERT INTO "Ipari_Szektorok" VALUES (7,'Elektronikai ipar');
INSERT INTO "Ipari_Szektorok" VALUES (8,'Mezőgazdaság');
INSERT INTO "Ipari_Szektorok" VALUES (9,'Gyógyszeripar');
INSERT INTO "Ipari_Szektorok" VALUES (10,'Gépipar');
INSERT INTO "Ipari_Szektorok" VALUES (11,'Autóipar');
INSERT INTO "Ipari_Szektorok" VALUES (12,'Repülőgépipar');
INSERT INTO "Ipari_Szektorok" VALUES (13,'Általános vegyipar');
INSERT INTO "Ipari_Szektorok" VALUES (14,'Energiaipar');
INSERT INTO "Ipari_Szektorok" VALUES (15,'Ammónia- és hidrogénipar');
INSERT INTO "Ipari_Szektorok" VALUES (16,'Turizmus és vendéglátás');
INSERT INTO "Ipari_Szektorok" VALUES (17,'Építőipar');
INSERT INTO "Ipari_Szektorok" VALUES (18,'Élelmiszeripar');
INSERT INTO "Ipari_Szektorok" VALUES (19,'Dohányipar');
INSERT INTO "Ipari_Szektorok" VALUES (20,'Bőripar');
INSERT INTO "Ipari_Szektorok" VALUES (21,'Pénzügyi és bankszektor');
INSERT INTO "Ipari_Szektorok" VALUES (22,'Hajóipar');
INSERT INTO "Ipari_Szektorok" VALUES (23,'Acélipar');
INSERT INTO "Ipari_Szektorok" VALUES (24,'Műtrágyaipar');
INSERT INTO "Ipari_Szektorok" VALUES (25,'Rézipar');
INSERT INTO "Ipari_Szektorok" VALUES (26,'Alumíniumipar');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (1,'Gyógyszer');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (2,'IT');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (3,'Textil');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (4,'Elektronikai eszközök');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (5,'Gépipari termékek');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (6,'Élelmiszer');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (7,'Autó');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (8,'Alkatrészek');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (9,'Feldolgozott termék');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (10,'Bányászati alapanyagok');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (11,'Csiszolt gyémánt');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (12,'Nyers alapanyag');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (13,'Katonai eszközök');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (14,'Repülőgépipari alapanyag');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (15,'Luxus termék');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (16,'Műanyag');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (17,'Repülőgép-alkatrész');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (18,'Óraalkatrész');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (19,'Szépségápolás');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (20,'Wolfrám');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (21,'Ruházat');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (22,'Vegyi termékek');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (23,'Szőnyeg');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (24,'Műtrágya');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (25,'Járművek');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (26,'Telefon');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (27,'Acéltermékek');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (28,'Gyapot');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (29,'Üveg');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (30,'Szappan');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (31,'Motoralkatrész');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (32,'Dohány');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (33,'Élelmiszer-alapanyag');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (34,'Állatok');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (35,'Gépek');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (36,'Arany');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (37,'Gyémánt');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (38,'Alumínium');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (39,'Drágakő');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (40,'Papír');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (41,'Hamuzsír');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (42,'Hal');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (43,'Kenőanyag');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (44,'Fémek');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (45,'Viszontexport');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (46,'Energia');
INSERT INTO "Kereskedelmi_Fotermek" VALUES (47,'Ékszerek');
INSERT INTO "Nemzet" VALUES (2,'India','Ázsia','Tengeri','Demokratikus','Regionális_Hatalom','Félkapitalista','Állami_befolyás',1400000000,'Fiatalos',6.5,'Közepes','Gyorsan_Fejlődő','Energia_Kitettség | Etnikai_Feszültségek','Himalája_Kontrol | Technologiai_Függetlenség');
INSERT INTO "Nemzet" VALUES (3,'Oroszország','Európa | Ázsia','Szárazföldi','Államkapitalista','Autoriter','Államvezérelt Nyersanyagexport','Alacsony Ipari Diverzifikáció',144000000,'Öregedő',4.1,'Regionálisan Változó','Nagyváros Dominancia','Szankciók | Demográfia','Melegvízi Kikötő | Dedollazizáció');
INSERT INTO "Nemzet" VALUES (4,'Pakisztán','Ázsia','Tengeri','Demokratikus','Szövetségi Parlamentáris Rendszer','Félkapitalista','Állami befolyás',254000000,'Fiatalos',2.4,'Alacsony','Lassan Fejlődő','Vallási Szélsőségek | Belpolitikai Instabilitás','Kína Tengely | Kashmir');
INSERT INTO "Nemzet" VALUES (5,'Észak-Korea','Ázsia','Szárazföldi','Diktatúra','Totalitárius','Államvezérelt','Központosított',26000000,'Stagnáló',3.1,'Gyenge','Lassan Fejlődő','Belpolitikai Instabilitás | Élelmiszer','Digitális Hatalom');
INSERT INTO "Nemzet" VALUES (6,'USA','Észak-Amerika','Tengeri','Demokratikus','Szövetségi Rendszer','Kapitalizmus',NULL,347000000,'Öregedő',2.8,'Regionálisan Változó','Fragmentált (államonként változó)','Belső Feszültségek | BRICS','Kínai Gazdasági blokád | Blocklánc dominancia');
INSERT INTO "Nemzet" VALUES (7,'Kína','Ázsia','Tengeri','Államkapitalista','Autoriter','Félkapitalista','Állami befolyás',1400000000,'Öregedő',5.0,'Kiemelkedően jó',NULL,'Zárt Pénzügyi Piac | Technológiai Függés','Afrika | Dél- és kelet-kínai-tengeri ellenőrzés');
INSERT INTO "Nemzet" VALUES (8,'UK','Európa','Tengeri','Alkotmányos Monarchia',NULL,'Kapitalista',NULL,67500000,'Öregedő',1.4,'Kiemelkedően jó',NULL,'Etnikai Szélsőségek | Skócia','Globális diplomácia újraépítése');
INSERT INTO "Nemzet" VALUES (9,'Izrael','Közel-Kelet','Tengeri','Demokratikus',NULL,'Vegyes','Pluralista',10000000,'Fiatalos',1.6,'Jó',NULL,'Vallási Szélsőségek | Belpolitikai Instabilitás','Golán Fensík | Palesztina');
INSERT INTO "Nemzet" VALUES (10,'Franciaország','Európa','Tengeri','Félelnöki Köztársaság','Duális hatalmi rendszer','Szociális Piacgazdaság','Erős állami jelenlét',69000000,'Öregedő',1.1,'Kiemelkedően jó',NULL,' Migrációs Nyomás | Német-Francia Viszony','Afrika | EU integritás');
INSERT INTO "Nemzet" VALUES (11,'Irán','Közel-Kelet','Tengeri','Teokratikus Köztársaság','Legfelsőbb vezető dominanciával','Vegyes','Állami dominanciájú, erősen centralizált',91000000,'Fiatalos',4.0,'Közepes','Gyorsan fejlődő','Belpolitikai Instabilitás | Vallási Szélsőségek','USA status quo eltörlése | Regionális Nagyhatalmi pozició');
INSERT INTO "Nemzet" VALUES (12,'Szaúd-Arábia','Közel-Kelet','Tengeri','Abszolút Monarchia',NULL,'Államvezérelt Nyersanyagexport',NULL,32000000,'Fiatalos',1.5,'Közepes','Gyorsan Fejlődő','Olaj kitettség | Emberjog','Digitális hatalom | Regionális Nagyhatalmi pozició');
INSERT INTO "Nemzet" VALUES (13,'Törökország','Közel-Kelet','Tengeri','Élnöki Köztársaság','de facto autoriter vezetés','Vegyes','Magánszektor-vezérelt, állami beavatkozással és exportfókusszal',85000000,'Fiatalos',3.2,'Közepes','Gyorsan Fejlődő','Belpolitikai Instabilitás | Diplomáciai Izoláltság','Afrika | EU energia ellátása');
INSERT INTO "Nemzet" VALUES (14,'Egyiptom','Közel-Kelet','Tengeri','Demokratikus','Parlamentális','Vegyes','Állami és katonai dominanciájú',109000000,'Fiatalos',2.4,'Közepes','Stagnáló','Élelmiszer | Privát szektor tőkebevonás','Etióp garanciák | Izrael stabilitása');
INSERT INTO "Nemzet" VALUES (15,'Szíria','Közel-Kelet','Tengeri','Köztársaság','Autoriter','Átmeneti','Szociális piacgazdaságból, Szabad piaci átalakulás',18000000,'Fiatalos',1.5,'Gyenge','Lassan Fejlődő','Belpolitikai Instabilitás | Mélyszegénység','Nemzetközi csend | Újjáépítés');
INSERT INTO "Nemzet" VALUES (16,'Irak','Közel-Kelet','Tengeri','Demokratikus','Parlamentális Köztársaság','Államvezérelt Nyersanyagexport',NULL,46000000,'Fiatalos',1.5,'Gyenge','Lassan Fejlődő','Belpolitikai Instabilitás | Emberjog','Regionális diplomáciai hídszerep | Szuverenitás megőrzése');
INSERT INTO "Nemzet" VALUES (17,'UAE','Közel-Kelet','Tengeri','Monarchikus föderáció','Pártok nélküli','Digitális Piacgazdaság',NULL,9400000,'Fiatalos',4.0,'Kiemelkedően Jó',NULL,'Olajfüggőség | Emberjog','Regionális Gazdasági hatalom | Digitális hatalom');
INSERT INTO "Nemzet" VALUES (18,'Libanon','Közel-Kelet','Tengeri','Köztársaság','Unitárius állam','Kapitalista','Laissez faire',6800000,'Fiatalos',5.7,'Gyenge','Lassan Fejlődő','Belpolitikai Instabilitás | Mélyszegénység','Nemzetközi csend | Újjáépítés');
INSERT INTO "Nemzet" VALUES (19,'Jordánia','Közel-Kelet','Szárazföldi','Alkotmányos Monarchia','Unitárius állam','Vegyes','Erős szabályozói környezet, szabad magánszektorral',11100000,'Fiatalos',2.5,'Gyenge','Lassan Fejlődő','Vízhiány | Magas Munkanélküliség','Energia központ | Belső és regionális stabilitás');
INSERT INTO "Nemzet" VALUES (20,'Kuvait','Közel-Kelet','Tengeri','Alkotmányos Monarchia','Unitárius állam','Államvezérelt Nyersanyagexport','Erős olaj függés',4800000,'Öregedő',0.7,'Közepes','Gyorsan Fejlődő','Olaj kitettség | Beduin lakosság','Energia központ | Regionális semlegesség és USA biztonsági partnerség');
INSERT INTO "Nemzet" VALUES (21,'Katar','Közel-Kelet','Tengeri','Abszolút Monarchia','Emirség','Államvezérelt Nyersanyagexport','Petróleum és Gáz függés',3000000,'Öregedő',2.4,'Kiemelkedően Jó',NULL,'Vízhiány | Petróleum, gáz kitettség','Globális Adatközpont | Digitalizációs');
INSERT INTO "Nemzet" VALUES (22,'Jemen','Közel-Kelet','Tengeri','Köztársaság','Alkotmányos elnöki rendszer','Vegyes','Fragmentált, segélyalapú gazdaság',34400000,'Fiatalos',-1.0,'Gyenge','Nem fejlődik','Élelmiszer | Polgárháború','Béke | Szuverenitás');
INSERT INTO "Nemzet" VALUES (23,'Omán','Közel-Kelet','Tengeri','Abszolút Monarchia','Unitárius állam','Államvezérelt Nyersanyagexport',NULL,5000000,'Fiatalos',1.7,'Regionálisan Változó','Fejlett városi/kikötői csomópontok, elmaradott belső területek','Olaj kitettség | Emberjog','Gazdasági diverzifikáció | Regionális stabilitás');
INSERT INTO "Nemzet" VALUES (24,'Bahrein','Közel-Kelet','Tengeri','Alkotmányos Monarchia',NULL,'Államvezérelt Nyersanyagexport',NULL,1500000,'Fiatalos',2.6,'Közepes','Gyorsan Fejlődő','Olaj és aluminium kitettség | Emberjog','Gazdasági diverzifikáció | Digitalizáció');
INSERT INTO "Nemzet" VALUES (25,'Németország','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (26,'Spanyolország','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (27,'Portugália','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (28,'Olaszország','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (29,'Svájc','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (30,'Belgium','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (31,'Hollandia','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (32,'Lengyelország','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (33,'Svédország','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (34,'Finnország','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (35,'Dél-Korea','Ázsia','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (36,'Japán','Ázsia','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (37,'Tajvan','Ázsia','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (38,'Kazahsztán','Ázsia','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (39,'Kanada','Amerika','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (40,'Mexikó','Amerika','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (41,'Brazília','Amerika','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (42,'Etiópia','Afrika','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (43,'Szomália','Afrika','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (44,'Szudán','Afrika','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet" VALUES (45,'Görögország','Európa','Szárazföld','Kidolgozandó',NULL,'Kidolgozandó',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (2,'Haditengerészet','-',1,2.4,'Stabil','Tartományi belső feszülségek');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (3,'Szárazföldi','Kiterjedt nukleáris arzenál',1,6.0,'Stabil','Nem egységes, sok különböző etnikum');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (4,'Szárazföldi','-',1,1.7,'Alacsony','IMF-függő, külső segélyekre szorul');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (5,'Szárazföldi','-',1,18.0,'Stabil','A munkáspárt monopol politikai helyzetben van.');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (6,'Haditengerészet','Globális jelenlét, technológiai dominancia.',1,3.4,'Stabil','Sok etnikum ellenére is');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (7,'Szárazföldi','Gyors flottafejlesztés mellett is domináns szárazföldi létszám.',1,1.7,'Stabil','Erős belső kontrol');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (8,'Haditengerészet','-',1,2.3,'Stabil','Sok különböző etnikum ellenére is');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (9,'Légierő','-',1,8.8,'Közepes','IMF-függő, külső segélyekre szorul');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (10,'Szárazföldi','Mindhárom típus közel azonos. Idegen légió súlyozás.',1,2.1,'Stabil','-');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (11,'Szárazföldi','De facto nukleáris küszöbállam, komoly rakétaarzenál.',0,2.59,'Közepes','Bel- és regionális stabilitási problémák, szankciók.');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (12,'Légierő','Főleg Hormuz-szorosra irányuló stratégiai védelem',0,7.1,'Stabil','Stagnálás, regionális problémák');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (13,'Szárazföldi','NATO második legnagyobb hadserege',0,1.9,'Stabil','Regionális gazdasági és politikai feszültség');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (14,'Szárazföldi','Katonai dominanciájú kormányzás.',0,0.9,'Közepes','IMF-függő, külső segélyekre szorul');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (15,'Szárazföldi','Háborúban amortizálódott struktúra, orosz/iráni jelenlét.',0,6.5,'Bizonytalan','Mélyszegénység, instabilitás.');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (16,'Szárazföldi','Proxy feszültségek, újjáépülő haderő.',0,2.1,'Alacsony','IMF-függő, külső segélyekre szorul');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (17,'Légierő','Modernizált, high-tech kis haderő.',0,5.6,'Stabil','Öröklődő Monarchia');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (18,'Szárazföldi','Gyenge állami hadsereg, belbiztonság fókuszú. Erős Hezbollah jelenlét.',0,8.1,'Alacsony','IMF-függő, külső segélyekre szorul');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (19,'Szárazföldi','USA biztonsági partner, belbiztonság fókuszú.',0,4.9,'Stabil','Regionális külső feszültségek.');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (20,'Szárazföldi','USA biztonsági partnerség, belbiztonság fókuszú.',0,4.8,'Stabil','Regionális külső feszültségek.');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (21,'Légierő','Komoly USA támaszpont (Al Udeid), belbiztonság fókuszú.',0,7.0,'Stabil','Regionális külső feszültségek.');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (22,'Szárazföldi','Fragmentált milíciák, polgárháborús káosz.',0,5.0,'Instabil','Polgárháború.');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (23,'Szárazföldi','Regionális semlegességre törekvő haderő. Királyi Gárda.',0,6.5,'Stabil','-');
INSERT INTO "Nemzet_Biztonsagi_Profil" VALUES (24,'Haditengerészet','USA 5. flotta központja, belbiztonság fókuszú',0,3.2,'Stabil','-');
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (2,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (2,2);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (2,31);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (2,30);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (3,3);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (3,12);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (3,28);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (6,24);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (6,28);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (6,31);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (6,5);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (6,4);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (6,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (7,30);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (7,31);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (7,9);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (4,31);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (4,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (4,4);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (4,22);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (8,31);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (8,6);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (8,13);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (8,14);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (9,15);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (9,16);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (9,17);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (10,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (10,28);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (10,2);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (5,31);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (5,10);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (5,7);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (5,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (11,31);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (11,18);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (11,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (11,4);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (12,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (12,10);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (12,4);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (12,13);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (13,19);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (13,30);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (14,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (14,16);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (14,10);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (14,28);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (15,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (15,14);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (15,16);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (15,23);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (16,16);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (16,18);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (16,28);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (16,29);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (17,13);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (17,20);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (17,25);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (18,13);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (18,14);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (18,1);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (19,16);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (19,13);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (19,15);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (20,25);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (21,21);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (22,10);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (22,11);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (22,4);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (22,13);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (22,3);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (23,4);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (23,13);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (23,20);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (23,8);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (24,26);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (24,27);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (3,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (7,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (4,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (8,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (10,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (11,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (12,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (14,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (15,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (16,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (17,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (18,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (20,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (21,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (22,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (23,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (24,34);
INSERT INTO "Nemzet_Eroforras_Kapcsolat" VALUES (13,34);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (2,9,72,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (2,10,25,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (3,7,78,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (6,14,60,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (6,16,19,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (6,15,13,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (6,17,6,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (7,6,91,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (7,19,1,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (7,20,1,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (4,12,45,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (4,11,15,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (4,13,14,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (8,14,87,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (8,18,7,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (8,15,4,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (9,5,74,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (9,1,21,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (10,14,85,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (5,8,99,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (11,2,61,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (11,4,10,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (11,1,2,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (12,1,90,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (12,17,10,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (13,3,75,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (13,4,19,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (14,1,99,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (15,1,74,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (15,4,9,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (16,1,77,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (16,4,17,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (17,1,11,'Állampolgárok');
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (17,18,59,'Vendégmunkások');
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (18,1,95,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (19,1,98,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (20,1,60,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (20,18,35,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (21,18,65,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (21,1,12,'Állampolgárok');
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (22,1,93,NULL);
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (23,1,50,'Állampolgárok');
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (23,18,45,'Vendégmunkások');
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (24,1,46,'Állampolgárok');
INSERT INTO "Nemzet_Etnikumok_Kapcsolat" VALUES (24,18,45,'Vendégmunkások');
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (2,2,55);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (3,1,40);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (3,4,25);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (6,2,76);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (6,4,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (6,7,9);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (7,5,50);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (7,7,30);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (4,8,40);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (4,6,35);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (4,3,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (8,2,70);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (8,4,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (8,7,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (9,7,45);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (9,4,30);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (9,9,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (10,10,30);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (10,11,25);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (10,12,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (10,13,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (5,4,40);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (5,10,25);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (5,1,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (5,13,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (11,14,45);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (11,11,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (11,13,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (11,9,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (12,14,60);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (12,13,25);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (12,15,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (13,16,30);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (13,10,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (13,6,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (13,7,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (13,17,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (14,16,35);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (14,6,25);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (14,13,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (14,9,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (15,14,35);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (15,6,30);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (15,18,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (15,19,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (16,14,65);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (16,13,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (16,6,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (16,17,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (16,20,3);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (17,14,45);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (17,2,25);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (17,17,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (17,6,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (17,18,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (18,21,40);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (18,2,30);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (18,17,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (18,18,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (18,1,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (19,2,40);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (19,16,25);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (19,9,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (19,1,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (19,7,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (20,14,60);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (20,17,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (20,22,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (20,23,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (21,14,65);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (21,24,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (21,13,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (21,23,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (22,14,50);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (22,6,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (22,18,20);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (22,20,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (23,14,55);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (23,17,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (23,13,12);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (23,23,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (23,25,5);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (24,14,40);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (24,21,30);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (24,2,15);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (24,16,10);
INSERT INTO "Nemzet_Iparstruktúra_Kapcsolat" VALUES (24,26,5);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (2,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (2,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (2,10);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (2,3);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (3,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (3,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (3,13);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (3,38);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (6,39);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (6,40);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (6,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (6,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (6,10);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (7,36);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (7,35);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (7,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (7,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (7,10);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (7,3);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (4,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (4,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (4,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (4,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (9,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (9,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (9,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (9,13);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (5,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (5,3);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (11,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (11,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (11,41);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (11,13);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (12,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (12,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (12,36);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (12,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (12,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (13,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (13,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (13,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (13,3);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (14,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (14,10);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (14,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (14,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (14,13);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (15,13);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (15,12);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (15,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (15,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (16,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (16,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (16,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (16,13);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (17,12);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (17,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (17,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (17,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (17,36);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (17,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (18,10);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (18,29);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (18,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (18,13);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (18,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (19,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (19,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (19,12);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (19,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (19,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (20,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (20,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (20,35);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (20,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (20,37);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (20,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (22,12);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (22,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (22,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (22,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (23,22);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (23,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (23,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (23,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (23,12);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (24,12);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (24,17);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (24,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (24,41);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (24,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (8,2);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (8,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (8,10);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (8,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (10,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (10,8);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (10,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (10,25);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (10,28);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (10,30);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (10,26);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (21,7);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (21,36);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (21,35);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (21,6);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (21,8);
INSERT INTO "Nemzet_Kereskedelmi_Partnerek" VALUES (21,25);
INSERT INTO "Nemzet_Rivalizalas" VALUES (2,7,'Regionális dominancia és határviták',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (2,4,'Katonai és területi konfliktus (Kasmír)',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (3,6,'Globális geopolitikai és katonai rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (3,25,'Geopolitikai és biztonságpolitikai feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (3,10,'Geopolitikai és biztonságpolitikai feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (6,7,'Globális szuperhatalmi és gazdasági rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (6,3,'Globális geopolitikai és katonai rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (7,6,'Globális szuperhatalmi és gazdasági rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (7,2,'Regionális dominancia és határviták',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (7,25,'Gazdasági és piaci rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (7,10,'Gazdasági és piaci rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (4,2,'Katonai és területi konfliktus (Kasmír)',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (8,7,'Geopolitikai és diplomatikai feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (8,3,'Biztonságpolitikai rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (8,10,'Történelmi és európai befolyásolási rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (8,25,'Európai befolyásolási és gazdasági rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (9,16,'Katonai és biztonságpolitikai feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (10,7,'Gazdasági és afrikai befolyási övezetek harca',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (10,3,'Geopolitikai feszültség (Kelet-Európa és Afrika)',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (5,35,'Katonai és ideológiai szembenállás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (5,6,'Nukleáris és katonai fenyezettség miatti szembenállás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (5,36,'Történelmi és biztonságpolitikai rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (11,12,'Közel-keleti vallási és regionális vezetői harc',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (11,6,'Ideológiai és katonai feszültség, szankciók',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (11,9,'Egzisztenciális és katonai szembenállás, proxy háborúk',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (12,11,'Közel-keleti vallási és regionális vezetői harc',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (12,22,'Katonai intervenció a jemeni polgárháború miatt',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (12,21,'Öböl-menti befolyási övezetek harca',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (12,13,'Szunnita világ feletti befolyási rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (13,45,'Égei-tengeri határviták és történelmi feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (13,12,'Regionális befolyási harc',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (14,42,'Nílus vízkészlet-megosztási vita (Reneszánsz Gát)',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (14,43,'Biztonságpolitikai és regionális feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (14,44,'Határviták és politikai instabilitás hatásai',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (15,13,'Határbiztonság és katonai jelenlét a polgárháború miatt',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (15,6,'Katonai szembenállás, szankciók és beavatkozás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (15,19,'Határbiztonsági és menekültügyi feszültségek',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (16,12,'Regionális és vallási feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (16,6,'Történelmi háborús feszültség és szuverenitási kérdések',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (17,21,'Diplomáciai és befolyásolási verseny',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (17,11,'Öböl-menti biztonságpolitikai feszültség és szigeti viták',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (17,23,'Gazdasági és pénzügyi központi rivalizálás',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (18,9,'Folyamatos katonai és határmenti konfliktus (Hezbollah)',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (18,15,'Történelmi befolyásolási és belpolitikai feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (19,15,'Határbiztonság és fegyvercsempészet miatti feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (19,11,'Befolyásolási kísérletek elleni védekezés',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (19,9,'Diplomáciai és erőforrás-alapú rejtett feszültség',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (20,16,'Történelmi háborús örökség (Öbölháború)',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (20,11,'Tengeri határvonal-viták és biztonságpolitika',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (21,12,'Öböl-menti diplomáciai és befolyási harc',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (21,14,'Politikai és ideológiai vita',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (21,17,'Diplomáciai és regionális verseny',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (22,12,'Polgárháborús külső katonai beavatkozás feszültsége',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (22,11,'Belső húszi lázadók támogatása miatti destabilizáció',1);
INSERT INTO "Nemzet_Rivalizalas" VALUES (23,8,'Múltbéli gyarmati/birodalmi befolyásolási rivalizálás',0);
INSERT INTO "Nemzet_Rivalizalas" VALUES (23,27,'Történelmi tengeri gyarmati rivalizálás',0);
INSERT INTO "Nemzet_Rivalizalas" VALUES (24,11,'Siíta-szunnita belső feszültségek külső szítása miatti rivalizálás',1);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (6,13,'Alapító tag','Biztonsági Tanács állandó tagja',100);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (6,17,'Alapító tag','A szövetség vezető katonai hatalma',100);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (6,5,'Tag','Gazdasági együttműködés',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (6,11,'Alapító tag','Hírszerzési szövetség magja',95);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (6,10,'Alapító tag','Trilaterális biztonsági paktum',90);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (6,3,'Tag','Stratégiai biztonsági párbeszéd',80);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (3,13,'Állandó tag','Biztonsági Tanács állandó tagja',100);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (3,4,'Alapító tag','Katonai védelmi szövetség vezetője',95);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (3,1,'Alapító tag','Gazdasági tömb alapítója',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (3,2,'Alapító tag','Sanghaji Együttműködési Szervezet',80);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (3,18,'Tag','Fekete-tengeri Gazdasági Együttműködés',40);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (3,15,'Tag','Gázexportáló Országok Fóruma',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (7,13,'Állandó tag','Biztonsági Tanács állandó tagja',100);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (7,1,'Alapító tag','A tömb legnagyobb gazdasága',90);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (7,2,'Alapító tag','Politikai és biztonsági szövetség',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (7,6,'Alapító tag','Egy Övezet Egy Út kezdeményezés gazdája',95);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (8,13,'Állandó tag','Biztonsági Tanács állandó tagja',100);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (8,17,'Alapító tag','Vezető európai katonai hatalom',90);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (8,5,'Tag','Gazdasági együttműködés',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (8,11,'Alapító tag','Hírszerzési szövetség',95);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (8,10,'Alapító tag','Trilaterális biztonsági paktum',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (2,13,'Tag','Globális diplomáciai részvétel',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (2,1,'Alapító tag','Gazdasági és politikai partnerség',75);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (2,2,'Tag','Regionális biztonsági fórum',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (2,3,'Tag','Indo-csendes-óceáni biztonsági partnerség',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (2,19,'Közvetett partner','Középhatalmi egyeztető fórum',30);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (4,13,'Tag','Nemzetközi diplomácia',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (4,7,'Alapító tag','Kína-Pakisztán Gazdasági Folyosó (BRI mag)',95);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (4,2,'Tag','Regionális biztonsági integráció',65);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (4,8,'Tag','Iszlám Együttműködés Szervezete',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (4,9,'Alapító tag','Gazdasági Együttműködési Szervezet',50);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (10,13,'Állandó tag','Biztonsági Tanács állandó tagja',100);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (10,17,'Alapító tag','Katonai szövetség nukleáris hatalma',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (10,5,'Tag','Gazdasági együttműködés',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (9,13,'Tag','Nemzetközi elismertség',50);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (9,12,'Alapító tag','Közel-keleti normalizációs paktum',90);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (12,8,'Alapító tag','Iszlám világ központja (Mekka)',95);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (12,16,'Alapító tag','Öböl-menti Együttműködési Tanács vezetője',90);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (12,24,'Tag','Nagy Arab Szabadkereskedelmi Övezet',75);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (12,15,'Megfigyelő','Olaj/gázpiaci koordináció',50);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (17,16,'Alapító tag','Öböl-menti integráció',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (17,12,'Alapító tag','Normalizáció Izraellel',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (17,24,'Tag','Arab szabadkereskedelem',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (17,8,'Tag','Iszlám együttműködés',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (13,17,'Tag','Katonai szövetség keleti bástyája',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (13,5,'Alapító tag','Gazdasági szervezet',55);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (13,8,'Tag','Iszlám diplomáciai jelenlét',65);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (13,9,'Alapító tag','Regionális gazdasági partnerség',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (13,18,'Alapító tag','Fekete-tengeri együttműködés',50);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (14,21,'Alapító tag','Afrikai Unió tagság',75);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (14,24,'Tag','Arab szabadkereskedelem',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (14,8,'Tag','Iszlám együttműködés',65);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (14,22,'Tag','Arab Gazdasági Egység Tanácsa',50);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (11,2,'Tag','Keleti biztonsági integráció',75);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (11,1,'Tag','Gazdasági tömb tagja',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (11,8,'Tag','Iszlám világ (Síita pólus)',80);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (11,15,'Alapító tag','Gázexportőrök szövetsége',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (11,9,'Alapító tag','Gazdasági együttműködés',55);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (16,24,'Tag','Arab szabadkereskedelem',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (16,8,'Tag','Iszlám együttműködés',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (16,22,'Tag','Arab Gazdasági Egység',45);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (15,8,'Tag','Felfüggesztett, majd visszaállított tagság',50);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (15,24,'Tag','Arab piac',40);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (19,24,'Tag','Arab szabadkereskedelem',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (19,8,'Tag','Iszlám diplomácia',60);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (20,16,'Alapító tag','Öböl-menti integráció',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (20,24,'Tag','Arab piac',65);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (21,16,'Alapító tag','Öböl-menti integráció',80);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (21,15,'Alapító tag','Vezető cseppfolyósított gáz exportőr',90);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (22,24,'Tag','Regionális arab piac',40);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (23,16,'Alapító tag','Öböl-menti integráció',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (24,16,'Alapító tag','Öböl-menti integráció',85);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (24,12,'Tag','Normalizáció Izraellel',75);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (5,13,'Tag','Nemzetközi elismertség',50);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (5,14,'Regionális fórum tag','ASEAN Regionális Fórum (ARF) tagság',40);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (18,22,'Tag','Arab Gazdasági Egység Tanácsa',65);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (18,24,'Tag','Nagy Arab Szabadkereskedelmi Övezet',70);
INSERT INTO "Nemzet_Szovetseg_Kapcsolat" VALUES (18,8,'Tag','Iszlám Együttműködés Szervezete',60);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (6,2,'Középső-Alföld: Globális élelmiszer-biztonsági mag');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (6,3,'Kétóceános védettség: Katonai sebezhetetlenség');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (6,1,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (6,11,'Mexikói-öböl: Karibi tengeri dominancia ellenőrzése');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (3,2,'Európai-síkvidék: Történelmi inváziós kapu Nyugat felől');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (3,1,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (3,8,'Szibéria: Áttörhetetlen északi védelmi puffer');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (3,6,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (7,7,'Jangce és Sárga-folyó: A Han civilizáció és gazdaság demográfiai magja');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (7,1,'Himalája és Tibet: Áttörhetetlen déli és nyugati természetes fal');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (7,3,'Első szigetlánc: Tengeri blokádveszély és sebezhetőség');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (7,4,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (2,1,'Himalája: Teljes szárazföldi elszigetelés és védelem északról');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (2,3,'Indiai-óceáni-félsziget: Regionális tengeri útvonalak dominanciája');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (2,7,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (4,7,'Indus-völgy: Az ország egyetlen kritikus agrár- és gazdasági ütőere');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (4,1,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (8,3,'Szigetország: Évszázados természetes védelem a szárazföldi invázió ellen');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (8,11,'GIUK-átjáró és La Manche: Észak-atlanti tengeri fojtópontok ellenőrzése');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (9,3,'Földközi-tenger: Az egyetlen szabad logisztikai ablak a világra');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (9,4,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (12,4,'Rub al-Háli sivatag: A világ legnagyobb stratégiai olajtartalékai');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (12,11,'Vörös-tenger és Perzsa-öböl partvidék: Közvetlen kitettség a Hormuzi szorosnak');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (13,11,'Boszporusz és Dardanellák: Globális fojtópont, a Fekete-tenger kapuja');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (13,1,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (14,11,'Szuezi-csatorna: Globális tengeri fojtópont és tranzitfolyosó');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (14,7,'Nílus-delta: Az egyetlen lakható, életbevágó oázis a sivatagban');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (11,1,'Zagrosz- és Alborz-hegység: Bevehetetlen természetes hegyi erődrendszer');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (11,11,'Hormuzi-szoros: Globális energia-zsarolási potenciál és fojtópont');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (17,3,'Perzsa-öböl: Globális reexport és kereskedelmi csomópont');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (17,4,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (18,1,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (18,3,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (5,1,'Északi hegyvidék: Ideális földalatti katonai bázisoknak és tüzérségnek');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (5,3,NULL);
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (10,1,'Alpok és Pireneusok: Természetes védelmi vonal és határzóna délen/keleten');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (10,2,'Észak-francia síkság: Történelmi felvonulási és inváziós folyosó Nyugat-Európában');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (10,3,'Kétarcú partvidék: Atlanti-óceáni és mediterrán tengeri jelenlét');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (15,4,'Szír-sivatag: Hatalmas mélységi puffer és irreguláris hadviselési terep');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (15,7,'Eufrátesz-völgy: Az ország mezőgazdasági és édesvízi életvonala');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (16,4,'Nyugati sivatag: Természetes pufferzóna Jordánia és Szaúd-Arábia felé');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (16,7,'Tigris és Eufrátesz (Maddzsár): Mezozoikumi agrármag és demográfiai súlypont');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (16,11,'Al-Faw félsziget: Szűk, sebezhető kijárat a Perzsa-öbölre');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (19,4,'Badiyya sivatag: Az ország területének 80%-át kitevő sivár puffer');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (19,7,'Jordán-völgy: Stratégiai édesvízi és mezőgazdasági magzóna');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (20,4,'Kuvaiti sivatag: Hatalmas szénhidrogén-tartalékok, de zéró terepi védelem');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (20,11,'Perzsa-öböl / Bubiyan-sziget: Kiemelt mélyvízi olajkikötő és tengeri kapu');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (21,4,'Sivatagi félsziget: Kiterjedt földgázmezők, szárazföld felől sérülékeny határ');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (21,11,'Perzsa-öböli elhelyezkedés: Északi Olajmező és LNG globális exportkapu');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (22,1,'Sarawat-hegység: Bevehetetlen húszi erődítmény és gerillaterep');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (22,11,'Bab el-Mandeb szoros: Globális tengeri fojtópont és olajútvonal ellenőrzése');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (23,1,'Hadzsar-hegység: Természetes erődítmény a belső sivatag és a tenger között');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (23,11,'Muszandam-félsziget: A Hormuzi-szoros déli kapujának közvetlen ellenőrzése');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (24,3,'Szigetállam: Tengeri védettség, de stratégiai kiszolgáltatottság a szomszédoknak');
INSERT INTO "Nemzet_Tajegyseg_Kapcsolat" VALUES (24,11,'Perzsa-öböli mélyvízi horgonyzóhely: US 5th Fleet stratégiai bázisa');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (6,3,'Globális dominancia a chipek tervezésében és a LLM modellekben');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (6,11,'Vezető szerep a szuperszámítógépekben és a kvantum-számítástechnikában');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (6,5,'Kereskedelmi és katonai űrdominancia (NASA, SpaceX)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (6,6,'Globális támadó és védelmi digitális infrastruktúra');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (3,1,'Roszatom: Globális nukleáris reexport és reaktortechnológiai dominancia');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (3,6,'Államilag szponzorált kiberhadviselési és dezinformációs képességek');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (3,8,'Elektronikus hadviselés és hiperszonikus rakétatechnológia');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (7,3,'Nemzeti szintű arcfelismerő és megfigyelő AI rendszerek, chipek');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (7,11,'Vezető szerep a műholdas kvantum-kommunikációban és titkosításban');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (7,4,'A világ legnagyobb ipari robotizációs piaca és gyártási bázisa');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (7,9,'Globális piacvezető a napelemek, akkumulátorok és az EV-ellátási lánc terén');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (2,2,'A világ legnagyobb IT-kiszervezési (outsourcing) és szoftverfejlesztési központja');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (2,10,'A "világ patikája": Globális generikus gyógyszergyártási és vakcinaközpont');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (2,5,'Költséghatékony hold- és mélyűri missziók (ISRO)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (4,1,'Nukleáris elrettentő arzenál fenntartása és fejlesztése');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (8,3,'Kiemelkedő akadémiai kutatóközpontok és AI-biztonsági szabályozás');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (8,6,'GCHQ: Globális szintű elektronikus hírszerzés és kibervédelem');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (9,6,'A világ legfejlettebb kiberbiztonsági startup ökoszisztémája (pl. Unit 8200)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (9,8,'Iron Dome és fejlett légvédelmi/rakétaelhárító rendszerek');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (9,3,'Magas hozzáadott értékű AI kutatás-fejlesztés és katonai alkalmazások');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (12,16,'NEOM és The Line: A gazdaság diverzifikációjának csúcsprojektje');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (12,9,'A világ legnagyobb zöldhidrogén-üzemének építése (NEOM zóna)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (13,8,'Bayraktar drónok: Globális sikereket elérő hazai drónfejlesztés');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (14,14,'Digitális Egyiptom program a közigazgatás modernizálására');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (11,1,'Központilag menedzselt, vitatott dúsítási és nukleáris program');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (11,8,'Aszimmetrikus hadviselésre tervezett öngyilkos drónok tömeggyártása');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (11,6,'Regionális és globális infrastruktúrák elleni célzott kibertámadások');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (17,14,'Papírmentes kormányzati ökoszisztéma és minisztériumi szintű AI-stratégia');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (17,16,'Luxus- és high-tech infrastrukturális beruházások (Dubaj/Abu Dhabi)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (17,15,'Arab nyelvű digitális tartalmak és régió-specifikus platformok fejlesztése');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (17,5,'Mars-misszió (Hope szonda) és az arab világ űrkutatási HUB-jává válás');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (18,2,'Hagyományosan erős regionális digitális/szoftveres szabadúszó réteg');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (5,6,'Állami hackercsoportok (Lazarus) kriptovaluta-rablásokra és szabotázsra');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (5,1,'Tiltott katonai célú nukleáris fegyverkezési és rakétaprogram');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (19,2,'Közel-keleti szoftverfejlesztési és IT-outsourcing központ');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (20,12,'Kormányzati szintű felhőinfrastruktúra és adatbirodalom kiépítése');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (20,16,'Silk City (Madinat al-Hareer) megaprojekt fejlesztése');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (21,3,'Nemzeti AI-stratégia és szuperszámítógépes kutatóközpontok');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (21,16,'Okosváros-infrastruktúra (Lusail City) és high-tech sportberuházások');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (22,8,'Aszimmetrikus hadviselésre használt importált és helyben összeszerelt drónok');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (23,9,'Globális zöldhidrogén-exportőrré válás stratégiai célja (Hydrom)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (23,16,'High-tech és fenntartható okosváros-projektek (pl. Sultan Haitham City)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (24,12,'A régió első "Cloud-First" kormányzati politikája (Amazon Web Services HUB)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (24,13,'Országos 5G és intelligens városi IoT hálózatok korai adaptációja');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (10,1,'Független energiaellátási és katonai nukleáris doktrína (Framatome, CEA)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (10,5,'Az európai űrprogram és rakétagyártás magja (Arianespace)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (10,8,'Önálló hadiipari fejlettségi szint (Rafale, Thales, Naval Group)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (10,3,'Kiemelt európai AI-kutatási és fejlesztési központ (Mistral AI)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (15,6,'Állami és nem-állami szereplők által támogatott kiberhadsereg (Syrian Electronic Army)');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (15,7,'Erősen korlátozott, szankcionált és újjáépítésre szoruló IKT infrastruktúra');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (16,14,'A közigazgatás digitális modernizációja és az átláthatóság növelése');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (16,7,'Kiterjedt mobilhálózati és szélessávú infrastruktúra-fejlesztések');
INSERT INTO "Nemzet_Technologia_Kapcsolat" VALUES (16,6,'Kritikus infrastruktúrák és bankrendszerek elleni kiberdefense kiépítése');
INSERT INTO "Nemzet_Termek_Profil" VALUES (6,2,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (6,13,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (6,7,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (6,4,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (6,21,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (3,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (3,13,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (3,24,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (3,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (3,4,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (7,4,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (7,3,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (7,26,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (7,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (7,12,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (2,2,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (2,1,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (2,11,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (2,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (2,36,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (4,3,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (4,21,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (4,28,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (4,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (4,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (8,5,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (8,2,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (8,7,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (8,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (8,4,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (9,11,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (9,13,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (9,2,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (9,12,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (9,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (12,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (12,22,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (12,13,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (12,25,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (12,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (13,7,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (13,21,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (13,27,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (13,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (13,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (14,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (14,24,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (14,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (14,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (11,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (11,22,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (11,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (11,33,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (17,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (17,45,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (17,36,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (17,15,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (17,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (18,47,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (18,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (18,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (5,10,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (5,13,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (5,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (5,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (19,22,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (19,1,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (19,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (19,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (20,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (20,25,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (20,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (21,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (21,22,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (21,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (21,25,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (22,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (22,42,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (22,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (23,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (23,44,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (23,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (23,25,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (24,38,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (24,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (24,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (24,7,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (10,5,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (10,1,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (10,15,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (10,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (10,4,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (15,3,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (15,6,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (15,46,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (15,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (15,1,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (16,46,'Export');
INSERT INTO "Nemzet_Termek_Profil" VALUES (16,6,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (16,25,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (16,35,'Import');
INSERT INTO "Nemzet_Termek_Profil" VALUES (16,1,'Import');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (12,10,85,'Hivatalos államvallás, a cselekvő külpolitika alapja');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (12,11,15,'Jelentős kisebbség a stratégiai fontosságú Keleti Tartományban');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (17,10,75,'Hivatalos államvallás a helyi állampolgárok körében');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (17,11,15,'Kisebbség, főleg a kereskedő rétegekben');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (21,10,90,'Hivatalos államvallás, a vahhabita irányzat dominál');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (20,10,70,'Hivatalos államvallás');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (20,11,30,'Befolyásos, a gazdasági és politikai életbe integrált kisebbség');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (24,11,65,'A lakosság többsége, komoly belső politikai törésvonal');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (24,10,35,'A kormányzó királyi elit és a hadsereg vallása');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (11,11,90,'Hivatalos államvallás, a teokratikus berendezkedés alapja');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (11,10,10,'Főleg a határmenti régiókban élő, politikailag marginalizált kisebbség');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (23,12,45,'A szunnita-síita blokkokon kívüli, semleges közvetítő külpolitika alapja');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (23,10,50,'A lakosság másik fele, békés együttélésben');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (22,10,65,'Főleg a déli és keleti területeken');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (22,11,35,'Zaidita ág; a Húszi mozgalom politikai és katonai bázisa északon');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (18,10,30,'A törvényi hatalommegosztás szerint a miniszterelnököt adja');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (18,11,30,'A Hezbollah társadalmi és katonai hátországa délen');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (18,2,35,'Főleg maroniták; a paktum szerint az elnököt adják');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (9,6,74,'A cionista államalkotó nemzet vallása');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (9,10,18,'Az izraeli arab állampolgárok többsége');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (7,13,70,'A Kínai Kommunista Párt hivatalos ideológiája');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (7,7,15,'Kulturálisan és történelmileg a legelfogadottabb vallási forma');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (7,8,5,'Klasszikus kínai filozófiai gondolkodásmód és gyakorlat');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (7,9,5,'Társadalmi és államszervezési normarendszer, nem klasszikus vallás');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (5,13,100,'A Juche ideológia által kikényszerített totális állami kontroll');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (13,10,98,'Alkotmány szerint szekuláris állam, de a politika erősen támaszkodik rá');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (14,10,90,'Hivatalos államvallás, a törvénykezés fő forrása');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (14,2,10,'Kopt keresztények; jelentős és őshonos kisebbség');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (4,10,85,'Iszlám Köztársaság, a nemzeti identitás alapköve');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (4,11,15,'Jelentős kisebbség, időszakos felekezeti feszültségekkel');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (6,4,43,'Történelmi államalkotó kulturális mag');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (6,2,22,'Római katolikus felekezet');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (2,1,79,'A többségi társadalom vallása, a jelenlegi nacionalista politika alapja');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (2,10,14,'A világ egyik legnagyobb muszlim kisebbsége');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (2,5,2,'Koncentráltan Pandzsáb államban, komoly regionális identitással');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (3,3,75,'A nemzeti identitás és a puha hatalmi befolyás (soft power) fő bázisa');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (3,10,10,'Jelentős regionális koncentráció az észak-kaukázusi köztársaságokban');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (8,4,45,'Anglikán és skót presbiteriánus történelmi magállam');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (8,2,10,'Főleg római katolikusok, erős észak-ír és bevándorló bázissal');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (10,2,50,'Történelmileg római katolikus, de a társadalom erősen szekularizált');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (10,10,8,'Az észak-afrikai migráció révén jelentős demográfiai és belpolitikai tényező');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (15,10,74,'A lakosság abszolút többsége, a polgárháború egyik fő törésvonala');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (15,11,13,'Alavita ág; az Aszad-rezsim és a katonai/biztonsági elit vallási hátországa');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (15,3,10,'Őshonos keresztény kisebbség (antiochiai ortodoxok, melkiták)');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (16,11,62,'A déli területek többsége; a Szaddám utáni politikai rendszer domináns ereje');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (16,10,35,'Közép- és Nyugat-Irak arab lakossága, valamint a kurdok vallása');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (19,10,94,'Hivatalos államvallás, a társadalom és jogrendszer alapja');
INSERT INTO "Nemzet_Vallas_Kapcsolat" VALUES (19,2,5,'Őshonos, garantált parlamenti képviselettel rendelkező kisebbség');
INSERT INTO "Szovetsegek" VALUES (1,'BRICS','Gazdasági','Feltörekvő gazdaságok szövetsége (Brazília, Oroszország, India, Kína, Dél-Afrikai Köztársaság és bővüléseik)');
INSERT INTO "Szovetsegek" VALUES (2,'SCO','Biztonsági / Politikai','Sanghaji Együttműködési Szervezet - eurázsiai politikai, gazdasági és biztonsági szövetség');
INSERT INTO "Szovetsegek" VALUES (3,'QUAD','Stratégiai / Biztonsági','Négyoldalú Biztonsági Párbeszéd (USA, Japán, Ausztrália, India) az indo-csendes-óceáni régióban');
INSERT INTO "Szovetsegek" VALUES (4,'CSTO','Katonai','Kollektív Biztonsági Szerződés Szervezete - posztszovjet katonai szövetség Oroszország vezetésével');
INSERT INTO "Szovetsegek" VALUES (5,'OECD','Gazdasági','Gazdasági Együttműködési és Fejlesztési Szervezet - fejlett gazdaságú országok szervezete');
INSERT INTO "Szovetsegek" VALUES (6,'BRI','Gazdasági / Infrastrukturális','Belt and Road Initiative - Kína globális infrastrukturális és kereskedelem-fejlesztési stratégiája (Új Selyemút)');
INSERT INTO "Szovetsegek" VALUES (7,'CPEC','Gazdasági / Infrastrukturális','Kína-Pakisztán Gazdasági Folyosó - a BRI egyik legfontosabb, specifikus bilaterális ága');
INSERT INTO "Szovetsegek" VALUES (8,'OIC','Politikai / Vallási','Iszlám Együttműködés Szervezete - a muszlim világ kollektív hangja');
INSERT INTO "Szovetsegek" VALUES (9,'ECO','Gazdasági','Gazdasági Együttműködési Szervezet - közel-keleti és közép-ázsiai államok kereskedelmi blokkja (korábban ECD)');
INSERT INTO "Szovetsegek" VALUES (10,'AUKUS','Katonai / Biztonsági','Trilaterális biztonsági paktum Ausztrália, az Egyesült Királyság és az USA között (főleg nukleáris tengeralattjárók)');
INSERT INTO "Szovetsegek" VALUES (11,'Five Eyes','Hírszerzési','Angolszász országok (USA, UK, Kanada, Ausztrália, Új-Zéland) globális hírszerzési szövetsége');
INSERT INTO "Szovetsegek" VALUES (12,'Abraham Accords','Politikai / Diplomáciai','Ábrahám-megállapodások - Izrael és több arab ország (UAE, Bahrein stb.) közötti diplomáciai normalizáció');
INSERT INTO "Szovetsegek" VALUES (13,'ENSZ','Globális Politikai','Egyesült Nemzetek Szervezete - nemzetközi kormányközi szervezet a globális békéért és együttműködésért');
INSERT INTO "Szovetsegek" VALUES (14,'ASEAN','Gazdasági / Politikai','Délkelet-ázsiai Nemzetek Szövetsége - regionális integrációs blokk');
INSERT INTO "Szovetsegek" VALUES (15,'GECF','Energetikai','Gázexportáló Országok Fóruma - a földgáz-kitermelő országok szövetsége (hasonló az OPEC-hez)');
INSERT INTO "Szovetsegek" VALUES (16,'GCC','Gazdasági / Politikai','Öböl-menti Együttműködési Tanács - a hat arab öböl-állam szoros regionális szövetsége');
INSERT INTO "Szovetsegek" VALUES (17,'NATO','Katonai','Észak-atlanti Szerződés Szervezete - kollektív védelmi katonai szövetség');
INSERT INTO "Szovetsegek" VALUES (18,'BSEC','Gazdasági','Fekete-tengeri Gazdasági Együttműködés - a fekete-tengeri régió országainak regionális szervezete');
INSERT INTO "Szovetsegek" VALUES (19,'MIKTA','Politikai / Diplomáciai','Középhatalmak informális partnersége (Mexikó, Indonézia, Dél-Korea, Törökország, Ausztrália)');
INSERT INTO "Szovetsegek" VALUES (20,'EUCU','Gazdasági / Kereskedelmi','Európai Unió Vámuniója - egységes vámterület az EU tagjai és néhány külső ország között');
INSERT INTO "Szovetsegek" VALUES (21,'AU','Politikai / Regionális','Afrikai Unió - az afrikai kontinens államait tömörítő integrációs szervezet');
INSERT INTO "Szovetsegek" VALUES (22,'CAEU','Gazdasági','Arab Gazdasági Egység Tanácsa - az Arab Liga tagjainak gazdasági integrációját segítő szerv');
INSERT INTO "Szovetsegek" VALUES (23,'COMESA','Gazdasági / Kereskedelmi','Kelet- és Dél-afrikai Közös Piac - hatalmas afrikai szabadkereskedelmi övezet');
INSERT INTO "Szovetsegek" VALUES (24,'GAFTA','Gazdasági / Kereskedelmi','Nagy Arab Szabadkereskedelmi Övezet - az arab országok közötti vámok lebontására létrehozott egyezmény');
INSERT INTO "Tajegyseg_Tipus" VALUES (1,'Hegység / Magaslat','Kiváló természetes védelmi vonal, nehezen áttörhető határok, ellenőrizhető szorosok (Chokepoints). Potenciális ásványkincs-lelőhelyek.','Nehéz és költséges infrastruktúra-építés, korlátozott mezőgazdaság, elszigetelt belső régiók, lassú logisztika.');
INSERT INTO "Tajegyseg_Tipus" VALUES (2,'Síkság / Alföld','Ideális mezőgazdaságra (élelmiszer-biztonság), gyors és olcsó infrastruktúra-fejlesztés (utak, vasút), maximális belső mobilitás.','Természetes akadályok hiánya miatt katonailag rendkívül nehezen védhető, minden irányból nyitott az invázióra.');
INSERT INTO "Tajegyseg_Tipus" VALUES (3,'Tenger / Óceán (Partvidék)','Közvetlen hozzáférés a globális kereskedelmi útvonalakhoz (olcsó tengeri szállítás), tengeri erőforrások.','Parti sebezhetőség (haditengerészeti invázió, blokád), kitettség a természeti katasztrófáknak.');
INSERT INTO "Tajegyseg_Tipus" VALUES (4,'Sivatag / Félsivatag','Hatalmas mélységi védelmi puffer, gyakran jelentős szénhidrogén- (olaj, gáz) tartalékok.','Lakhatatlan területek, extrém vízhiány, mezőgazdaság teljes hiánya, elszigeteltség a szomszédos termékeny régióktól.');
INSERT INTO "Tajegyseg_Tipus" VALUES (5,'Mocsár / Lápvidék','Gyakorlatilag átjárhatatlan nehéz páncélos technika számára, kiváló gerillaharcra és védekezésre, elvágja a támadási útvonalakat.','Lehetetlen komoly infrastruktúrát vagy városokat építeni rá, magas betegségkockázat, mezőgazdaságilag értéktelen.');
INSERT INTO "Tajegyseg_Tipus" VALUES (6,'Erdőség / Dzsungel','Kiváló rejtőzködési lehetőség, légi felderítés ellen védett csapatmozgások, bőséges faanyag (nyersanyag).','Hagyományos gépesített hadviselésre alkalmatlan terep, nehéz belső kommunikáció és utánpótlás-szervezés.');
INSERT INTO "Tajegyseg_Tipus" VALUES (7,'Folyóvölgy / Delta','Rendkívül termékeny földek, természetes belső vízi utak a kereskedelemhez, a folyó maga lokális védelmi vonal.','Árvízveszély, a hidak stratégiai szűk keresztmetszetté válnak, torkolatoknál külső blokád veszélye.');
INSERT INTO "Tajegyseg_Tipus" VALUES (8,'Tundra / Permafrost','Extrém téli fagy mint természetes védelmi vonal, kiaknázatlan északi erőforrások.','Az év nagy részében fagyott talaj miatt szinte nullázódó mezőgazdaság, az olvadáskor sártengerré váló utak, extrém fenntartási költségek.');
INSERT INTO "Tajegyseg_Tipus" VALUES (9,'Szavanna / Füves fás biom','Kiváló láthatóság és gyors csapatmozgás száraz évszakban. Hatalmas területek állattenyésztésre és erőforrás-kiaknázásra.','A kiszámíthatatlan csapadék miatt instabil mezőgazdaság, természetes fedezék hiánya a modern nehézfegyverzet ellen.');
INSERT INTO "Tajegyseg_Tipus" VALUES (10,'Jégsapka / Állandó jégmező','Tökéletes elszigeteltség, ideális helyszín titkos katonai bázisoknak, radarállomásoknak és korai riasztórendszereknek.','Permanens emberi életre alkalmatlan, a felszíni logisztika és infrastruktúra-építés szinte lehetetlen, extrém fenntartási költségek.');
INSERT INTO "Tajegyseg_Tipus" VALUES (11,'Stratégiai Tengerszoros / Csatorna / Öböl-bejárat','Globális jelentőségű fojtópont (Chokepoint). Hatalmas geopolitikai zsarolási potenciál, ellenőrzés a világkereskedelmi és energia-szállítási útvonalak felett.','Első számú katonai célpont háború vagy blokád esetén; folyamatos külső nagyhatalmi nyomás és állandó konfliktusveszély.');
INSERT INTO "Technologia" VALUES (1,'Atomtechnológia');
INSERT INTO "Technologia" VALUES (2,'IT-fejlesztés és szoftver');
INSERT INTO "Technologia" VALUES (3,'Mesterséges Intelligencia (AI)');
INSERT INTO "Technologia" VALUES (4,'Robotika és automatizáció');
INSERT INTO "Technologia" VALUES (5,'Űrtechnológia');
INSERT INTO "Technologia" VALUES (6,'Kiberbiztonság és kiberhadviselés');
INSERT INTO "Technologia" VALUES (7,'IKT (Információs és Kommunikációs Technológiák)');
INSERT INTO "Technologia" VALUES (8,'Katonai high-tech és dróntechnológia');
INSERT INTO "Technologia" VALUES (9,'Zöldenergia és hidrogéntechnológia');
INSERT INTO "Technologia" VALUES (10,'Gyógyszertechnológia');
INSERT INTO "Technologia" VALUES (11,'Kvantumtechnológia');
INSERT INTO "Technologia" VALUES (12,'Felhőalapú szolgáltatások (Cloud)');
INSERT INTO "Technologia" VALUES (13,'Okoseszköz-hálózatok és IoT');
INSERT INTO "Technologia" VALUES (14,'E-Kormányzat (E-Government)');
INSERT INTO "Technologia" VALUES (15,'Internet-arabizációs technológiák');
INSERT INTO "Technologia" VALUES (16,'Futurisztikus megaprojektek (NEOM)');
INSERT INTO "Vallasok" VALUES (1,'Hindu');
INSERT INTO "Vallasok" VALUES (2,'Keresztény');
INSERT INTO "Vallasok" VALUES (3,'Ortodox');
INSERT INTO "Vallasok" VALUES (4,'Protestáns');
INSERT INTO "Vallasok" VALUES (5,'Szikh');
INSERT INTO "Vallasok" VALUES (6,'Zsidó');
INSERT INTO "Vallasok" VALUES (7,'Buddhizmus');
INSERT INTO "Vallasok" VALUES (8,'Taoizmus');
INSERT INTO "Vallasok" VALUES (9,'Konfucianizmus');
INSERT INTO "Vallasok" VALUES (10,'Szunnita iszlám');
INSERT INTO "Vallasok" VALUES (11,'Sía iszlám');
INSERT INTO "Vallasok" VALUES (12,'Ibádita iszlám');
INSERT INTO "Vallasok" VALUES (13,'Állami ateizmus');
CREATE VIEW View_Gazdasagi_Es_Ipari_Alapok AS
SELECT 
    n.Orszag_Nev AS Orszag,
    n.Infrastruktura_szint AS Infrastruktura,
    GROUP_CONCAT(DISTINCT e.Megnevezes) AS Eroforrasok,
    GROUP_CONCAT(DISTINCT isz.Nev) AS Ipari_Szektorok
FROM Nemzet n
LEFT JOIN Nemzet_Eroforras_Kapcsolat nek ON n.id = nek.Nemzet_id
LEFT JOIN Eroforrasok e ON nek.Eroforras_id = e.id
LEFT JOIN Nemzet_Iparstruktúra_Kapcsolat nik ON n.id = nik.Nemzet_id
LEFT JOIN Ipari_Szektorok isz ON nik.Ipari_Szektorok_id = isz.id
GROUP BY n.id, n.Orszag_Nev;
CREATE VIEW View_Nuklearis_Védelmi_Ernyő AS
SELECT 
    n.Orszag_Nev AS Orszag,
    CASE 
        WHEN nbp.Stabilitasi_szint IS NOT NULL THEN nbp.Stabilitasi_szint
        ELSE 'Nincs adatrögzítés'
    END AS Stabilitasi_Szint,
    CASE 
        WHEN nbp.Stabilitasi_szint = 'Stabil' THEN 'Alacsony Kockázat'
        WHEN nbp.Stabilitasi_szint = 'Közepes' THEN 'Mérsékelt Kockázat'
        WHEN nbp.Stabilitasi_szint IN ('Alacsony', 'Bizonytalan', 'Instabil') THEN 'Magas Kockázat'
        ELSE 'Ismeretlen'
    END AS Kockazati_Kategoria,
    SUM(CASE WHEN partner_nbp.Nuklearis_Hatalom = 1 THEN 1 ELSE 0 END) AS Atomhatalom_Szovetsegesek_Szama,
    GROUP_CONCAT(DISTINCT sz.Nev) AS Szovetsegek,
    GROUP_CONCAT(DISTINCT r_n.Orszag_Nev) AS Rivalis_Orszagok

FROM Nemzet n
JOIN Nemzet_Biztonsagi_Profil nbp ON n.id = nbp.Nemzet_id

LEFT JOIN Nemzet_Szovetseg_Kapcsolat nszk ON n.id = nszk.Nemzet_id
LEFT JOIN Szovetsegek sz ON nszk.Szovetseg_id = sz.id


LEFT JOIN Nemzet_Szovetseg_Kapcsolat partner_nszk ON sz.id = partner_nszk.Szovetseg_id AND partner_nszk.Nemzet_id != n.id
LEFT JOIN Nemzet_Biztonsagi_Profil partner_nbp ON partner_nszk.Nemzet_id = partner_nbp.Nemzet_id


LEFT JOIN Nemzet_Rivalizalas nr ON n.id = nr.Nemzet_A_id AND nr.Is_Active = 1
LEFT JOIN Nemzet r_n ON nr.Nemzet_B_id = r_n.id


WHERE nbp.Nuklearis_Hatalom = 0

GROUP BY n.id, n.Orszag_Nev, nbp.Stabilitasi_szint;
CREATE VIEW View_Tengerszoros_Kereskedelem_Profil AS
SELECT 
    n.Orszag_Nev AS Orszag,
     GROUP_CONCAT(DISTINCT tk.Leiras_Specifikus) AS Tengerszorosok,
    
    
    GROUP_CONCAT(DISTINCT CASE WHEN tp.Irany = 'Export' THEN kf.Nev END) AS Export_Termekek,
    GROUP_CONCAT(DISTINCT CASE WHEN tp.Irany = 'Import' THEN kf.Nev END) AS Import_Termekek

FROM Nemzet n
JOIN Nemzet_Tajegyseg_Kapcsolat tk ON n.id = tk.Nemzet_id
JOIN Nemzet_Termek_Profil tp ON n.id = tp.Nemzet_id
JOIN Kereskedelmi_Fotermek kf ON tp.Termek_id = kf.id
WHERE tk.Tajegyseg_id = 11
GROUP BY n.id, n.Orszag_Nev;
CREATE VIEW View_Vallasi_Polusok_Es_Biztonsag AS
SELECT
    v.id AS Vallas_ID,
    GROUP_CONCAT(n.Orszag_nev, ', ') AS Polus_Orszagai,
    SUM(nbp.Nuklearis_Hatalom) AS Nuklearis_Hatalmak_Szama,
    ROUND(AVG(nbp.DefExp_GDP_2024_Szazalek), 2) AS Atlagos_Vedelmi_Kiadas_GDP_Szazalek
FROM Nemzet n  
JOIN Nemzet_Vallas_Kapcsolat nvk ON n.id = nvk.Nemzet_id
JOIN Nemzet_Biztonsagi_Profil nbp ON n.id = nbp.Nemzet_id
JOIN Vallasok v ON nvk.Vallas_id = v.id
GROUP BY v.id;
COMMIT;
