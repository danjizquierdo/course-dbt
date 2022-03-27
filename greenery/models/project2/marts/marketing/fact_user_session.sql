with fact as (
    SELECT
    session_id
    , user_id
    , MAX(order_id) as order_id
    , COUNT(event_id) as session_events
    , COUNT(DISTINCT page_url) as pages_visited
    , COUNT(DISTINCT product_id) as products_seen
    , MIN(created_at) as session_start_utc
    , MAX(created_at) as session_end_utc
    , CASE WHEN MAX(order_id) is not null THEN 1
        ELSE 0 END as order_placed
    , MAX(order_id) as associated_order_id
    FROM {{ref('stg_events')}}
    GROUP BY 1, 2
)

SELECT * from fact