
EXPLAIN
SELECT * FROM bookings 
JOIN users ON bookings.user_id = users.user_id
JOIN properties ON bookings.property_id = properties.property_id
LEFT JOIN payments ON bookings.booking_id = payments.booking_id
WHERE bookings.status = 'confirmed'
  AND bookings.start_date > '2024-01-01';
