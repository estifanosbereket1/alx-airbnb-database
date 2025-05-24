# before

```
+----+-------------+------------+------------+--------+-----------------------------+---------+---------+-------------------------+------+----------+-------------------------------------------------------------------+
| id | select_type | table      | partitions | type   | possible_keys               | key     | key_len | ref                     | rows | filtered | Extra                                                             |
+----+-------------+------------+------------+--------+-----------------------------+---------+---------+-------------------------+------+----------+-------------------------------------------------------------------+
|  1 | SIMPLE      | properties | NULL       | ALL    | PRIMARY                     | NULL    | NULL    | NULL                    |    2 |   100.00 | NULL                                                              |
|  1 | SIMPLE      | bookings   | NULL       | range  | PRIMARY,property_id,user_id | user_id | 1023    | NULL                    |    2 |    50.00 | Using index condition; Using where; Using join buffer (hash join) |
|  1 | SIMPLE      | payments   | NULL       | ALL    | booking_id                  | NULL    | NULL    | NULL                    |    2 |    50.00 | Using where; Using join buffer (hash join)                        |
|  1 | SIMPLE      | users      | NULL       | eq_ref | PRIMARY                     | PRIMARY | 1022    | airbnb.bookings.user_id |    1 |   100.00 | NULL                                                              |
+----+-------------+------------+------------+--------+-----------------------------+---------+---------+-------------------------+------+----------+-------------------------------------------------------------------+
4 rows in set, 1 warning (0.00 sec)

```

# after

```
+----+-------------+------------+------------+--------+-----------------------------+-------------+---------+-------------------------+------+----------+-------------------------------------------------------------------+
| id | select_type | table      | partitions | type   | possible_keys               | key         | key_len | ref                     | rows | filtered | Extra                                                             |
+----+-------------+------------+------------+--------+-----------------------------+-------------+---------+-------------------------+------+----------+-------------------------------------------------------------------+
|  1 | SIMPLE      | properties | NULL       | ALL    | PRIMARY                     | NULL        | NULL    | NULL                    |    2 |   100.00 | NULL                                                              |
|  1 | SIMPLE      | bookings   | NULL       | range  | idx_user_id,idx_property_id | idx_user_id | 1023    | NULL                    |    2 |    50.00 | Using index condition; Using where; Using join buffer (hash join) |
|  1 | SIMPLE      | users      | NULL       | eq_ref | PRIMARY                     | PRIMARY     | 1022    | airbnb.bookings.user_id |    1 |   100.00 | NULL                                                              |
|  1 | SIMPLE      | payments   | NULL       | ALL    | idx_booking_id              | NULL        | NULL    | NULL                    |    2 |   100.00 | Using where; Using join buffer (hash join)                        |
+----+-------------+------------+------------+--------+-----------------------------+-------------+---------+-------------------------+------+----------+-------------------------------------------------------------------+

```
