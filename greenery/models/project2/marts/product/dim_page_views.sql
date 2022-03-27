with dim as (
    SELECT
    page_url
    , COUNT( distinct session_id) as page_views
    , MIN(created_at) as last_opened_utc
    FROM {{ref('stg_events')}}
    WHERE event_type = 'page_view'
    GROUP BY 1
)

SELECT * from dim