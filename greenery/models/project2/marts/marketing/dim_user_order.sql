with dims as (
    select 
    users.user_id
    , users.zipcode
    , COUNT(orders.order_id) as num_orders
    , AVG(order_products.num_products::float) as avg_num_products
    , AVG(orders.order_total_dollars) as avg_price_total_dollars
    , SUM(order_products.num_items) as total_items_purchased
    , SUM(orders.order_total_dollars) as total_spent_dollars
    , MIN(orders.order_placed_utc) as first_order_placed_utc
    , MAX(orders.order_placed_utc) as last_order_placed_utc
    -- should also add a CASE WHEN to see if an order is currently waiting to be delivered
    from {{ ref('fact_orders')}} as orders 
    left join {{ ref('dim_users')}} as users
    using (user_id)
    join {{ ref('int_order_products')}} as order_products
    using (order_id)
    group by 1, 2
)

select * from dims