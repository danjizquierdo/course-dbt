with staging as (
    select 
    product_id
    , name as product_name
    , price as price_dollars
    , inventory
    from {{ ref('stg_products')}}
)

select * from staging