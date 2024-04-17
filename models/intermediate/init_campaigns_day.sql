with
    aggregated_campaigns as (
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            sum(ads_cost) as ads_cost,
            sum(impression) as ads_impression,
            sum(click) as ads_click
        from {{ ref("int_campaigns") }}
        group by date_date, paid_source, campaign_key, campaign_name
    )

select
    date_date,
    count(distinct campaign_key) as ads_campaigns,
    sum(ads_cost) as ads_cost,
    sum(ads_impression) as ads_impression,
    sum(ads_click) as ads_click
from aggregated_campaigns
group by date_date
