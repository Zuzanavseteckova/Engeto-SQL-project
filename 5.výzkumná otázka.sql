


WITH YearlyChanges AS (
    SELECT
        tzvpspf.payroll_year,
        ROUND(AVG(tzvpspf.average_salary_per_year), 2) AS average_salary,
        ROUND(AVG(tzvpspf.average_price_per_year), 2) AS average_price
    FROM
        t_Zuzana_Vseteckova_project_SQL_primary_final tzvpspf
    WHERE tzvpspf.payroll_year >= 2006 AND tzvpspf.payroll_year <= 2018
    GROUP BY
        tzvpspf.payroll_year
),
GDPData AS (
    SELECT
        country,
        year,
        GDP
    FROM
        t_Zuzana_Vseteckova_project_SQL_secondary_final
    WHERE
        country = 'Czech Republic' AND year >= 2006 AND year <= 2018
)
SELECT
    yc1.payroll_year,
    yc1.average_salary,
    ROUND((yc1.average_salary - yc2.average_salary) / yc2.average_salary * 100, 2) AS salary_change_percentage,
    yc1.average_price,
    ROUND((yc1.average_price - yc2.average_price) / yc2.average_price * 100, 2) AS price_change_percentage,
    gdp_data.GDP,
    ROUND((gdp_data.GDP - prev_gdp.GDP) / prev_gdp.GDP * 100, 2) AS gdp_change_percentage
FROM
    YearlyChanges yc1
JOIN
    YearlyChanges yc2 ON yc1.payroll_year = yc2.payroll_year + 1
JOIN
    GDPData gdp_data ON yc1.payroll_year = gdp_data.year
LEFT JOIN
    GDPData prev_gdp ON yc2.payroll_year = prev_gdp.year
ORDER BY
    yc1.payroll_year;
