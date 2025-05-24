-- Seeding `users`
USE airbnb;
INSERT INTO users (
    first_name,
    last_name,
    email,
    password_hash,
    phone_number,
    role
  )
VALUES (
    'John',
    'Doe',
    'john.doe@example.com',
    'hashedpassword123',
    '1234567890',
    'guest'
  ),
  (
    'Jane',
    'Smith',
    'jane.smith@example.com',
    'hashedpassword456',
    '0987654321',
    'host'
  ),
  (
    'Alice',
    'Johnson',
    'alice.johnson@example.com',
    'hashedpassword789',
    '1122334455',
    'admin'
  );
INSERT INTO properties (
    host_id,
    name,
    description,
    location,
    pricepernight
  )
VALUES (
    (
      SELECT user_id
      FROM users
      WHERE email = 'jane.smith@example.com'
    ),
    'Beach House',
    'A beautiful beach house',
    'California',
    150.00
  ),
  (
    (
      SELECT user_id
      FROM users
      WHERE email = 'jane.smith@example.com'
    ),
    'Mountain Cabin',
    'A cozy cabin in the mountains',
    'Colorado',
    120.00
  );
INSERT INTO bookings (
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status
  )
VALUES (
    (
      SELECT property_id
      FROM properties
      WHERE name = 'Beach House'
    ),
    (
      SELECT user_id
      FROM users
      WHERE email = 'john.doe@example.com'
    ),
    '2025-06-01',
    '2025-06-10',
    1500.00,
    'pending'
  ),
  (
    (
      SELECT property_id
      FROM properties
      WHERE name = 'Mountain Cabin'
    ),
    (
      SELECT user_id
      FROM users
      WHERE email = 'john.doe@example.com'
    ),
    '2025-07-01',
    '2025-07-07',
    840.00,
    'confirmed'
  );
INSERT INTO payments (booking_id, amount, payment_method)
VALUES (
    (
      SELECT booking_id
      FROM bookings
      WHERE status = 'pending'
    ),
    1500.00,
    'credit_card'
  ),
  (
    (
      SELECT booking_id
      FROM bookings
      WHERE status = 'confirmed'
    ),
    840.00,
    'paypal'
  );
INSERT INTO reviews (property_id, user_id, rating, comment)
VALUES (
    (
      SELECT property_id
      FROM properties
      WHERE name = 'Beach House'
    ),
    (
      SELECT user_id
      FROM users
      WHERE email = 'john.doe@example.com'
    ),
    5,
    'Amazing stay! The house was perfect.'
  ),
  (
    (
      SELECT property_id
      FROM properties
      WHERE name = 'Mountain Cabin'
    ),
    (
      SELECT user_id
      FROM users
      WHERE email = 'john.doe@example.com'
    ),
    4,
    'Great cabin, but could use some more amenities.'
  );
INSERT INTO messages (sender_id, recipient_id, message_body)
VALUES (
    (
      SELECT user_id
      FROM users
      WHERE email = 'john.doe@example.com'
    ),
    (
      SELECT user_id
      FROM users
      WHERE email = 'jane.smith@example.com'
    ),
    'Hi Jane, I would like to book the Beach House for June.'
  ),
  (
    (
      SELECT user_id
      FROM users
      WHERE email = 'jane.smith@example.com'
    ),
    (
      SELECT user_id
      FROM users
      WHERE email = 'john.doe@example.com'
    ),
    'Hi John, the Beach House is available for your requested dates!'
  );
