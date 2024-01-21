WITH RestaurantCounts AS (
    SELECT
        p.name AS restaurant_name,
        COUNT(po.id) AS count,
        'order' AS action_type
    FROM
        person_order po
    JOIN
        menu m ON po.menu_id = m.id
    JOIN
        pizzeria p ON m.pizzeria_id = p.id
    GROUP BY
        p.name

    UNION ALL

    SELECT
        p.name AS restaurant_name,
        COUNT(pv.id) AS count,
        'visit' AS action_type
    FROM
        person_visits pv
    JOIN
        pizzeria p ON pv.pizzeria_id = p.id
    GROUP BY
        p.name
)

SELECT
    restaurant_name,
    count,
    action_type
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER (PARTITION BY action_type ORDER BY count DESC) AS rn
        FROM
            RestaurantCounts
    ) AS RankedCounts
WHERE
    rn <= 3
ORDER BY
    action_type ASC,
    count DESC;