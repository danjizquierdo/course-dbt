with source as (
    select * from {{ source('tutorial','promos')}}
),

renamed as (

    select
    promo_id
    , discount
    , status
    from source
)

select * from renamed