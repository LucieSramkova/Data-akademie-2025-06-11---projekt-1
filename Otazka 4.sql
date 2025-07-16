--Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?


---prumerne ceny a prumerne mzdy
CREATE OR REPLACE VIEW v_lucie_sramkova_czechia_average_price_payroll AS
SELECT
	price_measurement_year_from AS price_measurement_year,
	ROUND(AVG(price_value)::numeric, 2) AS average_price_value,
	ROUND(AVG(payroll_value)::numeric) AS average_payroll_value
FROM
	t_lucie_sramkova_project_sql_primary_final
WHERE 
	price_measurement_year_from BETWEEN 2006 AND 2018  
GROUP BY 
	price_measurement_year_from
ORDER BY 
	price_measurement_year_from ASC;


--prumerna mzda a cena i pro predchozi rok a vypocet narustu
CREATE OR REPLACE VIEW v_lucie_sramkova_czechia__price_payroll_increase AS
WITH yeartoyear_increase_price_payroll AS (
	SELECT
		price_measurement_year,
		average_price_value,
		LAG(average_price_value) OVER (ORDER BY price_measurement_year) AS previous_price,
		average_payroll_value,
		LAG(average_payroll_value) OVER (ORDER BY price_measurement_year) AS previous_payroll
	FROM v_lucie_sramkova_czechia_average_price_payroll
)
SELECT
	price_measurement_year,
	average_price_value,
	previous_price,
	average_payroll_value,
	previous_payroll,
	ROUND(((average_price_value - previous_price) / previous_price) * 100, 2) AS price_increase,
	ROUND(((average_payroll_value - previous_payroll) / previous_payroll) * 100, 2) AS payroll_increase
FROM yeartoyear_increase_price_payroll
WHERE previous_price IS NOT NULL AND previous_payroll IS NOT NULL
ORDER BY price_measurement_year;

---urceni velikosti rustu mezi rustem mezd a cen
SELECT 
	price_measurement_year,
	price_increase,
	payroll_increase,
	price_increase - payroll_increase AS increase_difference,
	CASE
		WHEN price_increase > payroll_increase AND (price_increase - payroll_increase) >= 10 THEN 'high_increase'
		WHEN price_increase > payroll_increase AND (price_increase - payroll_increase) > 0 THEN 'increase'
		ELSE 'no_increase'
	END AS increase_type
FROM 
	v_lucie_sramkova_czechia__price_payroll_increase
ORDER BY
	increase_difference DESC;