WITH RestaurantVisits AS (
    SELECT
        p.name AS restaurant_name,
        COUNT(pv.id) AS visit_count
    FROM
        person_visits pv
    JOIN
        pizzeria p ON pv.pizzeria_id = p.id
    GROUP BY
        p.name
),
RestaurantOrders AS (
    SELECT
        p.name AS restaurant_name,
        COUNT(po.id) AS order_count
    FROM
        person_order po
    JOIN
        menu m ON po.menu_id = m.id
    JOIN
        pizzeria p ON m.pizzeria_id = p.id
    GROUP BY
        p.name
)

SELECT
    COALESCE(rv.restaurant_name, ro.restaurant_name) AS restaurant_name,
    COALESCE(visit_count, 0) + COALESCE(order_count, 0) AS total_count
FROM
    RestaurantVisits rv
FULL JOIN
    RestaurantOrders ro ON rv.restaurant_name = ro.restaurant_name
ORDER BY
    total_count DESC,
    restaurant_name ASC;
