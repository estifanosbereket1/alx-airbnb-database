
EXPLAIN ANALYZE
SELECT * FROM (
    SELECT properties.property_id , AVG(reviews.rating) as average_rating 
    FROM properties 
    JOIN reviews ON properties.property_id = reviews.property_id 
    GROUP BY properties.property_id
) AS rated_properties
WHERE average_rating >4.0;



SELECT * FROM (
    SELECT users.user_id, COUNT(bookings.user_id) as number_of_booking 
    FROM users 
    JOIN bookings ON users.user_id=bookings.user_id
    GROUP BY users.user_id
) AS user_booking
WHERE number_of_booking >3;


