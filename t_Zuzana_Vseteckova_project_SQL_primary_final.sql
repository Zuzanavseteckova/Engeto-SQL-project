CREATE TABLE t_Zuzana_Vseteckova_project_SQL_primary_final AS
SELECT *
FROM
    ( 
      SELECT
          cp.payroll_year,
          cpib.name AS industry_branch_name,
          ROUND(AVG(cp.value), 0) AS average_salary_per_year
      FROM
          czechia_payroll cp
      JOIN
          czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
      WHERE
          cp.value_type_code = 5958 AND cp.value IS NOT NULL
      GROUP BY
          cp.payroll_year, cpib.name
      ORDER BY
          cpib.name, cp.payroll_year
    ) AS payroll
LEFT JOIN
    (
      SELECT
          YEAR(cp.date_from) AS year,
          pc.name,
          ROUND(AVG(cp.value), 2) AS average_price_per_year
      FROM
          czechia_price cp
      JOIN
          czechia_price_category pc ON cp.category_code = pc.code
      WHERE
          cp.region_code IS NULL
      GROUP BY
          pc.name, year
      ORDER BY
          pc.name, year
    ) AS prices
ON
    payroll.payroll_year = prices.year;
