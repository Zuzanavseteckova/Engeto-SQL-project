
   
 
SELECT
    payroll_year,
    AVG(average_salary_per_year) AS average_salary,
    AVG (CASE WHEN name = 'Chléb konzumní kmínový' THEN average_price_per_year END) AS average_price_bread,
    AVG (CASE WHEN name = 'Mléko polotučné pasterované' THEN average_price_per_year END) AS average_price_milk,
    ROUND (AVG(average_salary_per_year / CASE WHEN name = 'Chléb konzumní kmínový' THEN average_price_per_year END),1) AS bread_affordability,
    ROUND (AVG(average_salary_per_year / CASE WHEN name = 'Mléko polotučné pasterované' THEN average_price_per_year END),1) AS milk_affordability
FROM
    t_Zuzana_Vseteckova_project_SQL_primary_final tzvpspf
WHERE
    payroll_year IN (2006, 2018)
GROUP BY
    payroll_year;