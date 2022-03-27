with fact as (
    select 
    orders.order_id
    , orders.user_id
    , orders.promo_id
    , orders.address_id
    , case when orders.promo_id is not null then 1
        else 0
        end as has_promo
    , orders.created_at as order_placed_utc
    , orders.order_cost as order_cost_dollars
    , orders.shipping_cost as shipping_cost_dollars
    , orders.order_total as order_total_dollars
    , orders.tracking_id 
    , orders.shipping_service
    , orders.estimated_delivery_at as estimated_delivery_at_utc
    , orders.delivered_at as delivered_at_utc
    , age(orders.delivered_at, orders.estimated_delivery_at) as estimated_days_to_deliver
    , age(orders.delivered_at, orders.created_at) as days_to_deliver
    , orders.status
    , (promos.discount::float/100) as promo_discount_rate
    , order_products.num_products as num_products
    , order_products.num_items as num_items
    from {{ ref('stg_orders')}} as orders
    join {{ ref('int_order_products')}} as order_products
    using (order_id)
    left join {{ ref('stg_promos')}} as promos
    using (promo_id)
)

select * from fact