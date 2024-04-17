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
        join da-heledd-1633.dbt_prod.finance_days f on c.date_date = f.date_date
    )

select
    date_date,
    ads_campaigns,
    ads_cost,
    ads_impression,
    ads_click,
    operational_margin,
    operational_margin - ads_cost as ads_margin
from joined_data
