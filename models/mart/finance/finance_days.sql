-- Materialization: table
-- Schedule: 0 8 * * * (UTC)
-- Define a CTE to calculate the total revenue and margin per order
with
    order_metrics as (
        select
            o.date_date,
            o.orders_id,
            sum(s.revenue) as total_revenue,
            sum(s.margin) as total_margin
        from `da-heledd-1633.dbt_hdavies.int_sales_margin` s
        join `da-heledd-1633.dbt_hdavies.stg_raw__sales` o on s.orders_id = o.orders_id
        group by o.date_date, o.orders_id
    ),

    -- Define a CTE to calculate the total operational margin per day
    operational_margin_per_day as (
        select
            date_date,
            round(sum(total_operational_margin), 2) as total_operational_margin
        from `da-heledd-1633.dbt_hdavies.int_orders_operational`
        group by date_date
    )

-- Final select statement to define the finance_days model
select
    om.date_date,
    count(distinct om.orders_id) as nb_transactions,
    round(sum(om.total_revenue), 2) as revenue,
    round(avg(om.total_revenue), 2) as average_basket,
    round(sum(om.total_margin), 2) as margin,
    op.total_operational_margin as operational_margin
from order_metrics om
join operational_margin_per_day op on om.date_date = op.date_date
group by om.date_date, op.total_operational_margin
