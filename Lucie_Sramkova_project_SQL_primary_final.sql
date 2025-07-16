
CREATE TABLE t_lucie_sramkova_project_SQL_primary_final AS
SELECT 
	date_part ('year',cpri.date_from) AS price_measurement_year_from,
	cpricat.name AS category_name,
	cpri.value AS price_value,
	cpay.payroll_year,
	cpay.value AS payroll_value,
	cpib.name AS industry_name
FROM czechia_price AS cpri
	JOIN czechia_payroll AS cpay
		ON date_part ('year',cpri.date_from) = cpay.payroll_year
		AND date_part ('year',cpri.date_to) = cpay.payroll_year
		AND cpay.value_type_code = 5958
		JOIN czechia_price_category AS cpricat
		ON cpri.category_code = cpricat.code
		JOIN czechia_payroll_industry_branch AS cpib
		ON cpay.industry_branch_code = cpib.code
		JOIN czechia_payroll_unit AS cpu 
		ON cpay.unit_code = cpu.code
		JOIN czechia_region AS cr
		ON cr.code = cpri.region_code
		WHERE cpri.region_code IS NOT NULL
ORDER BY 
	cpay.payroll_year,
	cpricat.name ASC;
	
	
	
	