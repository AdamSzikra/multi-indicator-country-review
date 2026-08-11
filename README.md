# Multi-Indicator Country Review Database (SQLite)

[Magyar leírás](#-magyar) | [English Description](#-english)

---

<a name="-magyar"></a>
## 🇭🇺 Magyar

### 📌 A Projekt Eredete és Célja
A projekt egy geopolitikai hobbikutatásból indult, amely során a **Közel-Kelet országainak és a globális Nukleáris hatalmaknak** az összetett mutatóit saját adatgyűjtés alapján, a nulláról építettem fel egy összetett Excel táblázatban.

Az adathalmaz és a változók bővülésével – az SQL alapok elsajátítása után – a cél a saját magam által gyűjtött nyers adatok **átültetése és strukturálása lett egy skálázható, 3NF-ig normalizált relációs adatbázisba**. A projekt jól példázza a teljes adat-életciklust: az önálló adattervezéstől és adatgyűjtéstől kezdve a relációs architektúra kiépítésén át a komplex analitikai lekérdezések (VIEW) megírásáig.

* **Adatbázis motor:** SQLite (DB Browser for SQLite)
* **Architektúra:** 21 normalizált tábla (3NF szintig)
* **Főbb SQL és adategyeztetési mérföldkövek:** 
  * Saját gyűjtésű Excel adathalmaz átültetése relációs adatmodellbe.
  * M:N kapcsolatok feloldása hídtáblákkal (pl. szövetségek, erőforrások, rivalizálások).
  * Adat-integritási szabályok: Idegen kulcsok (Foreign Keys), Check feltételek (`BOOLEAN`, intervallumok) és összetett kulcsok.
  * Hibaellenőrzés, adat-konszolidáció, adminisztráció és analitikai nézetek (VIEW) írása.

---

### 🏗️ Adatbázis Szerkezet
Az adatmodell 21 táblán keresztül fűzi össze a nemzeti mutatókat:
* **Gazdaság és Erőforrások:** Fő exportcikkek, erőforrás-eloszlás és kereskedelmi partnerek.
* **Geopolitika és Szövetségek:** Multilaterális szövetségek, diplomáciai kapcsolatok és aktív rivalizálások.
* **Biztonság és Demográfia:** Haderőnemi fókuszok, nukleáris státusz, stabilitási mutatók, etnikai és vallási megoszlás.

---

### 📊 Elemzői Nézetek (4 Összetett VIEW)
Az aggregált adatok elemzésére és riportálására 4 komplex `CREATE VIEW` készült:

1. **`View_Tengerszoros_Kereskedelem`**
   * A tengeri kereskedelmi szűk keresztmetszeteket (chokepoints), az érintett nemzeteket és a biztonsági kockázatokat elemzi.
2. **`View_Vallasi_Polusok_Es_Biztonsag`**
   * Keresztbe elemzi a vallási demográfiát, a többségi vallási igazodást és a regionális stabilitási mutatókat.
3. **`View_Gazdasagi_Es_Ipari_Alapok`**
   * Aggregálja a nemzeti erőforrás-arányokat, az ipari szektorok súlyát és a védelmi kiadásokat (GDP %-ban).
4. **`View_Nuklearis_Védelmi_Ernyő`**
   * A nem-nukleáris államok védelmi ernyőjét vizsgálja: megszámlálja a szövetségeken keresztüli atomhatalmi partnereket, feltünteti a stabilitási kockázatot és az aktív rivalizálásokat (feltételes aggregációval és önmagára hivatkozó JOIN-okkal).

---

<a name="-english"></a>
## 🇬🇧 English

### 📌 Project Origin & Motivation
This project originated from a personal geopolitical research effort focusing on the **Middle East and global Nuclear Powers**. I independently collected the raw data and built the initial multi-indicator dataset from scratch in Excel.

As the complexity of the data grew, I used this self-sourced dataset to practice and apply SQL fundamentals by **designing and migrating the flat file into a fully normalized (up to 3NF) relational database in SQLite**. This project demonstrates the complete end-to-end data workflow: from primary data collection and schema design to database administration and writing complex analytical views.

* **Database Engine:** SQLite (managed via DB Browser for SQLite)
* **Architecture:** 21 normalized tables (up to 3NF)
* **Key SQL & Data Milestones:**
  * Independent data collection and transformation into a relational schema.
  * Resolving M:N relationships using junction tables (alliances, resources, rivalries).
  * Data integrity enforcement via Foreign Keys, Check constraints (`BOOLEAN`, value limits), and composite keys.
  * Data validation, error handling, administration, and writing analytical `CREATE VIEW` queries.

---

### 🏗️ Database Architecture
The schema structures national metrics across 21 interconnected tables:
* **Economic & Resource Profiles:** Primary export products, resource distributions, and trade partners.
* **Geopolitical & Alliances:** Multilateral alliances, diplomatic ties, and active national rivalries.
* **Security & Demographics:** Military branch focuses, nuclear capabilities, stability indices, and ethnic/religious compositions.

---

### 📊 Analytical Views (4 Custom Views)
To extract actionable insights from the normalized structure, 4 complex analytical views were developed:

1. **`View_Tengerszoros_Kereskedelem`**
   * Analyzes maritime trade choke points, connected nations, critical trade routes, and security risk factors.
2. **`View_Vallasi_Polusok_Es_Biztonsag`**
   * Cross-references religious demographics, majority religion alignments, and regional stability indicators.
3. **`View_Gazdasagi_Es_Ipari_Alapok`**
   * Aggregates national resource allocations, industrial sector dependencies, and military spending (% of GDP).
4. **`View_Nuklearis_Védelmi_Ernyő`**
   * Evaluates protection umbrella for non-nuclear states by aggregating allied nuclear powers through multilateral alliances, stability risks, and active bilateral rivalries (utilizing conditional aggregation and self-referencing junction joins).

---

## 📁 Repository Structure
* `Multi-Indicator_Country_Review.sql` – Full DDL/DML script containing table schemas, foreign keys, constraints, and the 4 analytical view queries.
* `Multi-Indicator Country Review.db` – Complete, ready-to-query SQLite database file.
