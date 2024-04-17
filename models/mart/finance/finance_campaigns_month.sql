with
    joined_data as (
        select
            c.date_date,
            c.ads_campaigns,
            c.ads_cost,
            c.ads_impression,
            c.ads_click,
            f.operational_margin
        from {{ ref("init_campaigns_day") }} c
        join {{ ref("finance_days")}} f on c.date_date = f.date_date
    )

select
    date_trunc(date_date, month) as month_date,
    count(ads_campaigns) as total_campaigns,
    sum(ads_cost) as total_ads_cost,
    sum(ads_impression) as total_ads_impression,
    sum(ads_click) as total_ads_click,
    sum(operational_margin) as total_operational_margin,
    sum(operational_margin) - sum(ads_cost) as total_ads_margin
from joined_data
group by month_date
order by month_date

