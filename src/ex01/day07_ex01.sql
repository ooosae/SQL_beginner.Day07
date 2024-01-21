SELECT
    pe.name AS name,
    COUNT(*) AS count_of_visits
FROM
    person_visits pv
JOIN
    person pe ON pv.person_id = pe.id
GROUP BY
    pe.name
ORDER BY
    count_of_visits DESC,
    name ASC
LIMIT 4;
