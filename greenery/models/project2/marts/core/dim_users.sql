with staging as (
    select 
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at as user_created_at_utc
    , updated_at as user_updated_at_utc
    , address
    , zipcode
    , state
    , country
    from {{ ref('stg_users')}}
    join {{ ref('stg_addresses')}}
    using (address_id)
)

select * from staging