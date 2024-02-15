


WITH YearlyChanges AS (
    SELECT
        payroll_year,
        ROUND(AVG(average_salary_per_year), 2) AS average_salary,
        ROUND(AVG(average_price_per_year), 2) AS average_price
    FROM
        t_Zuzana_Vseteckova_project_SQL_primary_final tzvpspf
    WHERE payroll_year >=2006 AND payroll_year<=2018
    GROUP BY
        payroll_year
)
SELECT
    yc1.payroll_year,
    yc1.average_salary,
    ROUND((yc1.average_salary - yc2.average_salary) / yc2.average_salary * 100,2) AS salary_change_percentage,
    yc1.average_price,
    ROUND((yc1.average_price - yc2.average_price) / yc2.average_price * 100,2) AS price_change_percentage,
    ROUND(ABS((yc1.average_salary - yc2.average_salary) / yc2.average_salary * 100 - (yc1.average_price - yc2.average_price) / yc2.average_price * 100),2) AS absolute_difference_percentage
FROM
    YearlyChanges yc1
JOIN
    YearlyChanges yc2 ON yc1.payroll_year = yc2.payroll_year + 1;
