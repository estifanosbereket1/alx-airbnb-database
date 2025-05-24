

SELECT * FROM bookings JOIN users ON bookings.user_id=users.user_id;

SELECT * FROM properties LEFT JOIN reviews ON properties.property_id=reviews.review_id;

-- SELECT * FROM bookings FULL OUTER JOIN users ON bookings.user_id= users.user_id;

EXPLAIN ANALYZE SELECT *
FROM bookings
  LEFT JOIN users ON bookings.user_id = users.user_id
UNION
SELECT *
FROM bookings
  RIGHT JOIN users ON bookings.user_id = users.user_id;
