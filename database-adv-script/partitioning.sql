CREATE TABLE IF NOT EXISTS bookings (
    booking_id VARCHAR(255) PRIMARY KEY DEFAULT (UUID()),
    property_id VARCHAR(255),
    user_id VARCHAR(255),
    start_date Date NOT NULL, 
    end_date Date NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM("pending", "confirmed", "canceled") NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
) PARTITION BY RANGE (YEAR(start_date)) (
  PARTITION p2022
  VALUES LESS THAN (2023),
    PARTITION p2023
  VALUES LESS THAN (2024),
    PARTITION p2024
  VALUES LESS THAN (2025),
    PARTITION pmax
  VALUES LESS THAN MAXVALUE
);