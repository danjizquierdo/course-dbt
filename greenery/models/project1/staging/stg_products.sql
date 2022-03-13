with source as (
    select * from {{ source('tutorial','products')}}
),

renamed as (

    select
    product_id
    , name
    , price
    , inventory
    from source
)

select * from renamed