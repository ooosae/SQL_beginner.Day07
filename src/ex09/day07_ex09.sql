SELECT
    address,
    ROUND(MAX(age) - (MIN(age) / MAX(age::NUMERIC)), 2) AS formula,
    ROUND(AVG(age), 2) AS average,
    CASE WHEN MAX(age) - (MIN(age) / MAX(age)) > AVG(age) THEN TRUE ELSE FALSE END AS comparison
FROM
    person
GROUP BY
    address
ORDER BY
    address;