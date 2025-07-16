--3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

--vypocet prumerne ceny a mezirocniho rozdilu v Kč

CREATE TABLE t_lucie_sramkova_czechia_price_comparison AS
SELECT
	price_measurement_year_from AS price_measurement_year,
	category_name,
	round(avg(price_value)::numeric,2) AS average_price_value,
	LAG(round(avg(price_value)::numeric,2), 1, 0) OVER (PARTITION BY category_name ORDER BY price_measurement_year_from) AS previous_year_price, 
 	round(avg(price_value)::numeric,2) - LAG(round(avg(price_value)::numeric,2), 1, 0) OVER (PARTITION BY category_name ORDER BY price_measurement_year_from) AS price_yeartoyear_difference
FROM
	t_lucie_sramkova_project_sql_primary_final
WHERE
	price_measurement_year_from >=2006 AND price_measurement_year_from <= 2018 AND category_name IS NOT null
GROUP BY 
	category_name,
	price_measurement_year_from
ORDER BY
	category_name;

---mezirocni narust v Kč a %
CREATE OR REPLACE VIEW v_lucie_sramkova_czechia_percentage_increase AS
SELECT 
	price_measurement_year,
	category_name,
	average_price_value,
	previous_year_price,
	price_yeartoyear_difference,
	round(
		CASE 
			WHEN previous_year_price IS NOT NULL AND previous_year_price !=0 THEN ((average_price_value - previous_year_price) / previous_year_price) * 100
			ELSE NULL
			END, 2) 
					AS yeartoyear_price_increase_percentage
FROM
	t_lucie_sramkova_czechia_price_comparison
WHERE 
	price_measurement_year > 2006
ORDER BY
	price_measurement_year ASC, category_name;


--prumerny mezirocni narust v %
SELECT 
	round(avg(yeartoyear_price_increase_percentage),2) AS avg_percentage_increase,
	category_name
FROM v_lucie_sramkova_czechia_percentage_increase
WHERE 
	yeartoyear_price_increase_percentage IS NOT NULL 
GROUP BY 
	category_name
ORDER BY 
	avg_percentage_increase ASC
		
