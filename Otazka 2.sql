---Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v
--- dostupných datech cen a mezd?

SELECT 
	DISTINCT category_name,
	round(avg(price_value)::numeric,2) AS average_price_value
FROM 
	t_lucie_sramkova_project_sql_primary_final tlspspf 
WHERE lower(category_name) LIKE '%chléb%' OR lower(category_name) LIKE '%chleba%' 
GROUP BY
	category_name,
	tlspspf.price_measurement_year_from;
---	Chléb konzumní kmínový

SELECT 
	DISTINCT category_name,
	round(avg(price_value)::numeric,2) AS average_price_value
FROM 
	t_lucie_sramkova_project_sql_primary_final tlspspf 
WHERE lower(category_name) LIKE '%mléko%' 
GROUP BY
	category_name,
	tlspspf.price_measurement_year_from;
--- Mléko polotučné pasterované



--- pocet mleka a chleba pro kazde odvetvi
CREATE OR REPLACE VIEW v_lucie_sramkova_czechia_price_average_selection AS 
SELECT
	price_measurement_year_from AS price_measurement_year,
	category_name,
	round(avg(price_value)::numeric,2) AS average_price_value,
	industry_name,	
	round(avg(payroll_value)::numeric) AS average_payroll_value,
	round((avg(payroll_value)::numeric / avg(price_value)::NUMERIC),2) AS availability_products
 FROM
	t_lucie_sramkova_project_sql_primary_final
WHERE 
	price_measurement_year_from IN (2006,2018) 
	AND category_name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
GROUP BY 
	industry_name,
	category_name,
	price_measurement_year_from;


--- pocet mleka a chleba pro rok 2006 a 2018 pro celkovou prumernou mzdy (bez ohledu na kategorie)
SELECT
	price_measurement_year_from AS price_measurement_year,
	category_name,
	round(avg(price_value)::numeric,2) AS average_price_value,
	round(avg(payroll_value)::numeric) AS average_payroll_value,
	trunc(round((avg(payroll_value)::numeric / avg(price_value)::NUMERIC),2)) AS availability_products
 FROM
	t_lucie_sramkova_project_sql_primary_final
WHERE 
	price_measurement_year_from IN (2006,2018) 
	AND category_name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový')
GROUP BY 
	category_name,
	price_measurement_year_from
ORDER BY 
	category_name ASC;





