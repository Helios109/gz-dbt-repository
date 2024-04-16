with
    sales_data as (
        select
            s.*,
            p.purchase_price,
            (
                cast(s.quantity as float64) * cast(p.purchase_price as float64)
            ) as purchase_cost
        from `da-heledd-1633.dbt_hdavies.stg_raw__sales` s
        join
            `da-heledd-1633.dbt_hdavies.stg_raw__product` p
            on s.products_id = p.products_id
    )

-- Select columns and calculate margin per sale
select
    s.date_date,
    sum(s.revenue) as total_revenue,
    sum(s.purchase_cost) as total_purchase_cost,
    sum(s.revenue - s.purchase_cost) as total_margin
from sales_data s
group by s.date_date

