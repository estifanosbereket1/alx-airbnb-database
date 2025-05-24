SELECT user_id, COUNT(bookings.user_id) as number_of_booking 
FROM users 
JOIN bookings ON users.user_id=bookings.user_id
GROUP BY users.user_id;


SELECT 
    property_id,
    name,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
    SELECT 
        p.property_id,
        p.name,
        COUNT(b.booking_id) AS total_bookings
    FROM properties p
    LEFT JOIN bookings b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name
) AS property_booking_counts;
