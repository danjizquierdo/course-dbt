## **Greenery**
### Week 1 Inquiries
<ol><li>There are 130 users.</li>
<li>We receive ~7.7 orders per hour.</li>
<li> Orders take ~4 days from being placed to being delivered.</li>
<li>Purchase quantity:<ul><li>25 users have made one purchase.</li><li>28 users have made two purchases</li><li>71 users have made 3+ purchases.</li></ul></li>
<li>We have ~7000 sessions per hour.</li></ol>

### Week 3 Inquiries
<ol>
    <li>What is the conversion rate?
    Query: 
        ```sql
        select SUM(order_placed)::float/ COUNT(*)*100 as conversion_rate
        from dbt_dan_i.fact_user_session
        ```
    Around 62%
    </li>
<li>What is the conversion rate by product?
        ```sql
        select dim_products.product_name
        , ROUND(COUNT(stg_order_items.order_id)::float/COUNT(DISTINCT int_session_product.session_id)::float*100) as conv_rate
        from dbt_dan_i.int_session_product
        join dbt_dan_i.dim_products
        using (product_id)
        join dbt_dan_i.fact_user_session
        using (session_id)
        left join dbt_dan_i.stg_order_items
        on int_session_product.product_id = stg_order_items.product_id
        and fact_user_session.order_id = stg_order_items.order_id
        group by 1
        ORDER BY 2 DESC
        ```
        | product name | conversion_rate (%) |
        | String of pearls | 61 |
        |   Arrow Head  | 56 |
        | Cactus| 55| 
        | Bamboo | 54 |
        | ZZ Plant | 54 |
        | Rubber Plant | 52 |
        | Calathea Makoyana | 51 |
        | Monstera | 51 |
        | Fiddle Leaf Fig | 50 | 
        | Majesty Palm | 49 |
        | Aloe Vera | 49 |
        | Devil's Ivy | 49 |
        | Jade Plant | 48 |
        | Philodendron | 48 |
        | Pilea Peperomioides | 47 |
        | Dragon Tree | 47 |
        | Spider Plant | 47 |
        | Money Tree | 46 |
        | Bird of Paradise | 45 |
        | Orchid | 45 |
        | Ficus | 43 | 
        | Birds Nest Fern | 42 |
        | Pink Anthurium | 42 |
        | Peace Lily | 41 |
        | Boston Fern | 41 |
        | Alocasia Polly | 41 |
        | Snake Plant | 40 |
        | Ponytail Palm | 40 |
        | Angel Wings Begonia | 39 |
        | Pothos | 34 |
</li>
 
</ol>
