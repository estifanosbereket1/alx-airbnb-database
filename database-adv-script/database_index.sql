CREATE INDEX idx_rating ON reviews (property_id, rating);
CREATE INDEX idx_user_id ON bookings(user_id);
CREATE INDEX idx_property_id ON bookings(property_id);
CREATE INDEX idx_booking_id ON payments(booking_id);
