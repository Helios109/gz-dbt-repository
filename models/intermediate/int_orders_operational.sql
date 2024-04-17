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
    ),
    ship_data as (
        select
            *,
            ifnull(cast(shipping_fee as float64), 0) as shipping_fee1,  -- Handle null values in shipping_fee column
            ifnull(cast(logcost as float64), 0) as logcost1,  -- Handle null values in log_cost column
            ifnull(cast(ship_cost as float64), 0) as ship_cost1  -- Handle null values in ship_cost column
        from `da-heledd-1633.dbt_hdavies.stg_raw__ship`
    )

-- Select columns and calculate operational margin per sale
select
    s.date_date,
    sum(s.revenue) as total_revenue,
    sum(s.purchase_cost) as total_purchase_cost,
    sum(s.revenue - s.purchase_cost) as total_margin,
    sum(
        s.revenue - s.purchase_cost + sh.shipping_fee1 - sh.logcost1 - sh.ship_cost1
    ) as total_operational_margin
from sales_data s
join ship_data sh on s.orders_id = sh.orders_id
group by s.date_date

