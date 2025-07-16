----Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji
--- v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce
--- výraznějším růstem?

-- HDP vyvoj v CZ a mezirocni rust
CREATE OR REPLACE VIEW v_lucie_sramkova_czechia_gdp_increase AS
WITH yeartoyear_increase_gdp AS (
	SELECT
		year,
		LAG(gdp_rounded) OVER (ORDER BY year) AS gdp_previous,
		gdp_rounded
	FROM t_lucie_sramkova_project_SQL_secondary_final
	WHERE country = 'Czech Republic'
)
SELECT
	year,
	gdp_rounded,
	gdp_previous,
	(((gdp_rounded - gdp_previous) / gdp_previous) * 100) AS gdp_increase
FROM yeartoyear_increase_gdp
WHERE gdp_previous IS NOT NULL AND gdp_previous IS NOT NULL
ORDER BY year;


--porovnani s cenami a mzdami

CREATE OR REPLACE VIEW v_lucie_sramkova_comparison_gdp_price_payroll AS
SELECT 
	vlspi.price_measurement_year,
	vlspi.price_increase,
	vlspi.payroll_increase,
	round(vlsgdp.gdp_increase::numeric,2) AS gdp_increase_rounded
FROM v_lucie_sramkova_czechia__price_payroll_increase  AS vlspi
JOIN
	v_lucie_sramkova_czechia_gdp_increase  AS vlsgdp
ON vlspi.price_measurement_year = vlsgdp.YEAR
ORDER BY 
	price_measurement_year;


--stanoveni miry rustu - rozdeleni dle vyse rustu
SELECT
	*,
	CASE
		WHEN gdp_increase_rounded >= 10 THEN 'HIGH increase'
		WHEN gdp_increase_rounded >= 5 THEN 'MEDIUM increase'
		WHEN gdp_increase_rounded > 0 THEN 'Increase'
		ELSE 'decrease'
	END AS Type_of_increase
FROM
	v_lucie_sramkova_comparison_gdp_price_payroll

