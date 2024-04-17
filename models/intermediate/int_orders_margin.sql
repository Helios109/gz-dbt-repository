with sales_data as (
    select
        s.*,
        p.purchase_price,
        ROUND(cast(s.quantity as float64) * cast(p.purchase_price as float64), 2) as purchase_cost
    from `da-heledd-1633.dbt_hdavies.stg_raw__sales` s
    join `da-heledd-1633.dbt_hdavies.stg_raw__product` p
    on s.products_id = p.products_id
)

select
    s.date_date,
    ROUND(sum(s.revenue), 2) as total_revenue,
    ROUND(sum(s.purchase_cost), 2) as total_purchase_cost,
    ROUND(sum(s.revenue - s.purchase_cost), 2) as total_margin
from sales_data s
group by s.date_date
