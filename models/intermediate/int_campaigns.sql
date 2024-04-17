select distinct
    date_date, paid_source, campaign_key, campaign_name, ads_cost, impression, click
from
    (
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            cast(ads_cost as float64) as ads_cost,  -- Ensure consistent data type
            impression,
            click
        from {{ ref("stg_raw__facebook") }}
        union all
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            cast(ads_cost as float64) as ads_cost,  -- Ensure consistent data type
            impression,
            click
        from {{ ref("stg_raw__criteo") }}
        union all
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            cast(ads_cost as float64) as ads_cost,  -- Ensure consistent data type
            impression,
            click
        from {{ ref("stg_raw__bing") }}
        union all
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            cast(ads_cost as float64) as ads_cost,  -- Ensure consistent data type
            impression,
            click
        from {{ ref("stg_raw__adwords") }}
    ) as combined_data
