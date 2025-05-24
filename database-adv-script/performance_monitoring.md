# Before Optimization

```
| -> Table scan on rated_properties  (cost=2.5..2.5 rows=0) (actual time=0.861..0.862 rows=1 loops=1)
    -> Materialize  (cost=0..0 rows=0) (actual time=0.861..0.861 rows=1 loops=1)
        -> Filter: (average_rating > 4.0)  (actual time=0.621..0.622 rows=1 loops=1)
            -> Table scan on <temporary>  (actual time=0.469..0.47 rows=2 loops=1)
                -> Aggregate using temporary table  (actual time=0.468..0.468 rows=2 loops=1)
                    -> Filter: (properties.property_id = reviews.property_id)  (cost=1.1 rows=2) (actual time=0.148..0.157 rows=2 loops=1)
                        -> Inner hash join (<hash>(properties.property_id)=<hash>(reviews.property_id))  (cost=1.1 rows=2) (actual time=0.144..0.152 rows=2 loops=1)
                            -> Table scan on reviews  (cost=0.175 rows=2) (actual time=0.0152..0.0205 rows=2 loops=1)
                            -> Hash
                                -> Covering index scan on properties using host_id  (cost=0.45 rows=2) (actual time=0.0677..0.0743 rows=2 loops=1)
 |


```

# After optimization

```
| -> Table scan on rated_properties  (cost=3.27..4 rows=1.41) (actual time=0.139..0.139 rows=1 loops=1)
    -> Materialize  (cost=1.49..1.49 rows=1.41) (actual time=0.138..0.138 rows=1 loops=1)
        -> Filter: (avg(reviews.rating) > 4.0)  (cost=1.35 rows=1.41) (actual time=0.0847..0.0875 rows=1 loops=1)
            -> Group aggregate: avg(reviews.rating)  (cost=1.35 rows=1.41) (actual time=0.0818..0.0842 rows=2 loops=1)
                -> Nested loop inner join  (cost=1.15 rows=2) (actual time=0.0541..0.0617 rows=2 loops=1)
                    -> Covering index scan on properties using PRIMARY  (cost=0.45 rows=2) (actual time=0.0163..0.0175 rows=2 loops=1)
                    -> Filter: (properties.property_id = reviews.property_id)  (cost=0.3 rows=1) (actual time=0.0199..0.0213 rows=1 loops=2)
                        -> Covering index lookup on reviews using idx_rating (property_id=properties.property_id)  (cost=0.3 rows=1) (actual time=0.019..0.0203 rows=1 loops=2)
 |

```
