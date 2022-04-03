with fact as (
    SELECT
    DATE(session_start_utc) as session_date
    , SUM( CASE WHEN pages_visited>0 THEN 1 ELSE 0 END) as sessions_page_views
    , SUM( CASE WHEN added_to_cart_events>0 THEN 1 ELSE 0 END) as sessions_add_to_cart
    , SUM( CASE WHEN checkout_events>0 THEN 1 ELSE 0 END) as sessions_checkout
    FROM {{ref('fact_user_session')}}
    GROUP BY 1
)

SELECT *
, sessions_add_to_cart::float/sessions_page_views*100 as add_to_cart_rate
, sessions_checkout::float/sessions_page_views*100 as checkout_rate
from fact