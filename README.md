# Data-akademie-2025-06-11---projekt-1
SQL projekt k datové akademii Engeto 


**Zadání projektu**
Cílem projektu č.1 v rámci Datové akademie zahájené dne 11. června 2025 bylo pomocí SQL odtazů poskytnout odpověď na několik výzkumných otázek týkajících se dostupnosti potravin pro širokou veřejnost. Připravené soubory budou sloužit jako podpůrné a zdrojové materiály pro zodpovězení předem stanovených výzkumných otázek a zároveň budou poskytnuty tiskovému oddělení naší společnost. Zdrojovými daty  pro celý projekt byly datové sady, se kterými jsme pracovali již v rámci akademie a na základě nich jsem si připravila dvě vlastní tabulky (primární a sekundární), ze kterých následně vycházejí odpovědi na výzkumné otázky. 

**Postup v rámci projektu**

Příprava drojových tabulek
V první části jsem nejprve připravovala tabulky, ze kterých vychází celý projekt. Dle výzkumných otázek jsem si stanovila jaká data budu potřebovat pro následné zodpovězení všech otázek a pomocí funkce JOIN jsem spojila několik datových sad do primární tabulky *t_lucie_sramkova_project_sql_primary_final* a sekundární tabulky *t_lucie_sramkova_project_SQL_secondary_final*. Primární tabulka zahrnuje potřebné informace týkající se mezd a cen potravin v rámci České republiky. Sekundární tabulka zahrnuje ukazatele HDP, GINI koeficiente a populace dalších evropských států pro stejné sledované období, jako primární přehled pro ČR.


**Zpracování otázek**
1. Vzhledem k tomu, že mzdy z datové sady *czechia_payroll* byly uváděny za jednotlivá čtvrtletí, nejprve jsem si vytvořila view *v_lucie_sramkova_czechia_payroll_average*, abych získala průměrnou mzdu za rok pro jednotlivé kategorie. Následné jsem na zákaldě této informace vytvořila další view *v_lucie_sramkova_czechia_payroll_difference*, kde jsem si stanovila jaký je meziroční nárůst/pokles pro jednotlivé kategorie a vytvořila nový sloupec 'payroll_increase', kde jsem si označila YES/NO/SAME, kde dochází k růstu/poklesu případně je hodnota uplně stejná. Následně jsem si v rámci tohoto view zobrazila pouze takové odvětví, kde dochází k poklesu nebo je hodnota stejná.

2. Ze zadání vyplývá, že hledáme ceny chleba a mléka pro první a poslední sledované období, které následně budeme porovnávat se mzdou za stené sledované období. V zadání není uvedeno zda nás zajímá informace pro každé odvětví zvlášť nebo zda se jedná o průměrnou mzdu skrze všechna odvětví,  SQL skriptu jsem tedy přiravila dotaz pro oba případy.
   Nejprve jsem si zjistila, jaký je první a poslední rok sledovaného období a jaký je název kategorie pro chléb a mléko, se kterým budu dále pracovat. Vzhledem k častému (týdennímu měření cen) jsem si vypočítala průměrnou cenu za daný rok pro daný produkt, a také průměrnou výši mzdy. Pomocí kluzule WHERE jsem vyfiltrovala pouze první a poslední roka (2006 a 2018) a dvě sledované kategorie potravin (Mléko a chléb). 


**Odpovědi na výzkumné oztázky**
   
**1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**
   Na základě zjištěných dat dochází v některých odvětvích k meziročnímu poklesu mzdy v rámci sledovaného období 2006. Celkem byl meziroční pokles během sledovaného období zaznamenán u 15 odvětví, přičemz u 


   
**2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**
   Na základě SQL dotazu bylo zjištěno, že v případě, že budeme počítat počet litrů mléka a kilogramů chleba pro průměrnou vzdu za daný rok (pro všechna odvětví dohromady), v roce 
   | Syntax | Description |
| ----------- | ----------- |
| Rok mereni | Kategorie potravin | Množství | 
|2006 | Chléb konzumní kmínový|  1287 |
|2018 | Chléb konzumní kmínový|  1342 |
|2006 | Mléko polotučné pasterované| 1437 |
|2018 | Mléko polotučné pasterované|  1641 |
        
**3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
        
**4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
   
**5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**
