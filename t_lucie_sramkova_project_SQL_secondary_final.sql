	CREATE TABLE t_lucie_sramkova_project_SQL_secondary_final AS
	SELECT
		ec.country,
		round(ec.GDP) AS GDP_rounded,
		ec.gini,
		ec.year,
		ec.population,
		c.region_in_world
	FROM economies  AS ec
	LEFT JOIN countries AS c 
	ON ec.country = c.country
	WHERE c.continent = 'Europe'
		AND year >= 2006 AND year <= 2018
	GROUP BY 
		ec.country,
		ec.GDP,
		ec.gini,
		ec.YEAR,
		ec.population,
		c.region_in_world
	ORDER BY country ASC;
