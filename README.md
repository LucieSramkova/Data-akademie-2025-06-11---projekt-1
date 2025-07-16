# Data-akademie-2025-06-11_projekt-SQL
SQL projekt k datové akademii Engeto 

Jméno: Lucie Šrámková


**Zadání projektu**

Cílem SQL projektu bylo pomocí SQL dotazů poskytnout odpovědi na předem stanovené výzkumné otázky týkající se dostupnosti potravin pro širokou veřejnost v České republice. Připravené soubory  (pomocí SQL dotazů) budou sloužit jako podpůrné a zdrojové materiály pro zodpovězení  výzkumných otázek a zároveň budou poskytnuty tiskovému oddělení. Zdrojovými daty pro celý projekt byly datové sady, se kterými jsme pracovali již v průběhu Datové akademie

**Postup v rámci projektu**

Příprava zdrojových tabulek
V první části jsem nejprve připravovala tabulky, ze kterých vychází celý projekt. Dle výzkumných otázek jsem si stanovila jaká data budu potřebovat pro následné zodpovězení všech otázek a pomocí funkce JOIN jsem spojila několik datových sad do primární tabulky *t_lucie_sramkova_project_sql_primary_final* a sekundární tabulky *t_lucie_sramkova_project_SQL_secondary_final*. Primární tabulka zahrnuje potřebné informace týkající se mezd a cen potravin v rámci České republiky. Sekundární tabulka zahrnuje ukazatele HDP, GINI koeficient a velikost populace dalších evropských států pro stejné sledované období, jako primární přehled pro ČR. Pouze tyto tabulky poté byly používány pro zjištění odpovědí na pět otázek.

**Zpracování otázek**

1. Vzhledem k tomu, že mzdy z datové sady *czechia_payroll* byly uváděny za jednotlivá čtvrtletí, nejprve jsem si vytvořila VIEW *v_lucie_sramkova_czechia_payroll_average*, abych získala informaci o průměrné mzdě za jeden rok pro jednotlivé kategorie. Na základě této informace  jsem vytvořila další VIEW *v_lucie_sramkova_czechia_payroll_difference*, kde jsem si stanovila jaký je meziroční nárůst/pokles pro jednotlivé kategorie a vytvořila nový sloupec 'payroll_increase', kde jsem označila jako YES/NO/SAME, kde dochází k růstu/poklesu případně je hodnota stejná. Následně jsem si v rámci tohoto VIEW zobrazila pouze takové odvětví, kde dochází k poklesu nebo je hodnota stejná a vyfiltrovala u jakého odvětví byl pokles nejnižší.

2. Nejprve jsem si zjistila, jaký je první a poslední rok sledovaného období a jaký je název kategorie pro chléb a mléko, se kterým budu dále pracovat. Vzhledem k častému (týdennímu měření cen) jsem si vypočítala průměrné ceny pro tyto kategorie za každý rok (2006 až 2018),průměrné mzdy pro jednotlivá odvětví kolik je možné nakoupit chleba a mléka za danou mzdu a rok. To stejné jsem udělala i v další tabulce, kde jsem už nepočítala průmernou mzdu za každou kategorii odděleně, ale celkově.

3. Nejprve jsem vytvořila tabulku *t_lucie_sramkova_czechia_price_comparison*, kde jsem zjistila jaká je průměrná cena za rok pro danou kategorii a jaký je meziroční rozdíl. Následně jsem z ní vycházela při výpočtu procentuálního meziročního růstu cen a vytvořila si VIEW *v_lucie_sramkova_czechia_percentage_increase*. Poté už jsem z tohoto VIEW jenom vypočítala průměrný procentuální nárůst za danou kategorii za celé sledované období a seřaila od nejpomalejšího průměrného růstu. 

4. Vytvořila jsem VIEW *v_lucie_sramkova_czechia_average_price_payroll*, kde jsem zjistila průměrnou cenu a průměrnou mzdu za každý rok (bez ohledu na kategorii a odvětví). Dale jsem vypočítala jaký je meziroční rozdíl v průměrné mzdě a průměrné ceně v Kč a v %. V posledním kroku jsem určila o jaký meziroční typ růstu se jedná, dle výše rozdílu mezi růstem mezd a cen.

5. Nejprve jsem si vytvořila VIEW *v_lucie_sramkova_czechia_gdp_increase *, kde jsem zjistila vývoj HDP pouze pro Českou republiku a meziroční nárůst. Poté jsem z tohoto VIEW vytvořila další VIEW *v_lucie_sramkova_comparison_gdp_price_payroll*, ke jsem pomoci JOIN spojila dvě dříve vytvořená VIEWs, abych zjistila také průměrný mezirořní nárůst cen a mezd za jednotlivé roky. Ve výzkumné otázce nás zajímá, kde byl výrazný růst HDP promítnut také do nárůstu cen a mezd za daný nebo následující rok. Proto jsem jako poslední rozdělila procentuální růst DPH do třech kategorií, abych identifikovala, kde je růst výraznější. 

**Odpovědi na výzkumné oztázky**
   
**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**
   Na základě zjištěných dat dochází v některých odvětvích k meziročnímu poklesu mzdy v rámci sledovaného období 2006. Celkem byl meziroční pokles během sledovaného období zaznamenán u 15 odvětví, přičemž u některých to bylo mezi lety vícekrát. Nejčastěji byl meziroční pokles do výše 1000 Kč. Naopak nejvyšší zaznamenaný pokles byl v odvětví **Peněžnictví a pojišťovnictví** ve výši 4 479 Kč.

   
**2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**
  Pomocí SQL dotazu bylo zjištěno, že v případě, že nás zajímá počet litrů mléka a kilogramů chleba pro průměrnou mzdu za sledovaný rok (pro všechna odvětví dohromady), jedná se o následující počty:
   
   | Syntax | Description |Description |
   | ----------- | ----------- |----------- |
   | Rok mereni | Kategorie potravin | Množství | 
   |2006 | Chléb konzumní kmínový| **1287** |
   |2018 | Chléb konzumní kmínový|  **1342** |
   |2006 | Mléko polotučné pasterované| **1437** |
   |2018 | Mléko polotučné pasterované|  **1641** |

   Množství v tabulce představuje kolik je možné koupit za danou průměrnou mzdu litrů mléka anebo chleba (vždy pouze jedno z toho), nejedná se o kombinaci obou potravin.

   Co se týká počtu mléka a chleba pro každé odvětví zvlášt, dalo by se blíže zkoumat zda v nějakém odvětví nastal například pokles v množství dostupnosti potravin vuči mzdě od v porovnání roku 2006 a 2018.
        
**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
      Ve sledovaném období od roku 2006 do roku 2018 je zaznamenán nejnižší procentuální nárůst u kategorie **Cukr krystalový**, kde je dokonce průměrný meziroční pokles 1,92 %. Na druhém místě je kategorie **Rajská jablka červená kulatá**, kde je opět meziroční pokles       0,73 %. U všech ostatnách potravin, které byly součástí měření je zaznamenán meziroční růst. Nejvyšší průměrný růst cen je u kategorie **Papriky** ve výši 7,29 %.
        
**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
      Mezi lety 2006 a 2018 nedošlo k výraznému navýšení cen oproti růstu mezd. Nejvyšší zaznamenaný růst byl v roce 2013, kde ceny meziročně vzrostly o 7,11 %. 
   
**5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**
      Ve sledovaném obodbí byl nejvyšší meziroční nárůst HDP v roce 2007 o 5,57 %, který se projevil také v cenách potravin a ve mzdách v roce 2007 i 2008. Dalším významným rokem, co se týká růstu HDP byl rok 2017,kde byl zazanemnán meziroční nárůst 5,17 %, v tomto roce       se to výrazně projevilo v cenách potravin (9,98 %) a také mzdách. v následujícím roce byl naopak růst cen velmi mírný, zatímco mzdy zaznamenaly další výrzaný meziroční nárůst.
      Ve sledovaném období byl meziroční nárůst HDP také v roce 2015, ale to se naopak nijak neprojevilo v cenách potravin a ve mzdách v 2015, ale ani v 2016. 
