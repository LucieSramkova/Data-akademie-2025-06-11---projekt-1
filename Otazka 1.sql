-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?


CREATE OR REPLACE VIEW v_lucie_sramkova_czechia_payroll_average AS
SELECT
	payroll_year,
	industry_name,
	round(avg(payroll_value)::numeric) AS average_payroll_value
 FROM
	t_lucie_sramkova_project_SQL_primary_final
GROUP BY
	industry_name,
	payroll_year

--vypocet mezirocniho narustu mzdy
CREATE OR REPLACE VIEW v_lucie_sramkova_czechia_payroll_difference AS
SELECT
 	payroll_year,
 	industry_name,
 	LAG(average_payroll_value, 1, 0) OVER (PARTITION BY industry_name ORDER BY payroll_year) AS previous_year_price, 
 	average_payroll_value - LAG(average_payroll_value, 1, 0) OVER (PARTITION BY industry_name ORDER BY payroll_year) AS payroll_value_difference,
 	CASE 
 		WHEN average_payroll_value - LAG(average_payroll_value, 1, 0) OVER (PARTITION BY industry_name ORDER BY payroll_year) > 0 THEN 'YES'
 		WHEN average_payroll_value - LAG(average_payroll_value, 1, 0) OVER (PARTITION BY industry_name ORDER BY payroll_year) < 0 THEN 'NO'
 		ELSE 'SAME'
 	END AS payroll_increase
 FROM v_lucie_sramkova_czechia_payroll_average;

-- ve kterych odvetvich doslo k poklesu a nebo mzdy zustaly stejne
SELECT 
	DISTINCT industry_name
FROM
	v_lucie_sramkova_czechia_payroll_difference 	
WHERE 
	payroll_increase = 'NO' OR payroll_increase = 'SAME';
ORDER BY 


 
 --kde doslo k poklesu o mene nez 1000 Kc mezirocne
SELECT 
	industry_name,
	SUM(payroll_value_difference::numeric) AS total_difference
FROM 
	v_lucie_sramkova_czechia_payroll_difference
WHERE 
	payroll_value_difference > -1000 AND payroll_value_difference < 0
GROUP BY 
	industry_name
ORDER BY 
	total_difference ASC;

 
 ---nejvetsi pokles
 SELECT 
	industry_name,
	payroll_value_difference
FROM
	v_lucie_sramkova_czechia_payroll_difference 	
WHERE 
	payroll_increase = 'NO' 
ORDER BY 
	payroll_value_difference ASC
LIMIT
	1;



 	
 	