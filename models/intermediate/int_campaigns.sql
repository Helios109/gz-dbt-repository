-- Union all distinct data from different staging models
select distinct
    date_date, paid_source, campaign_key, campaign_name, ads_cost, impression, click
from
    (
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            ads_cost,
            impression,
            click
        from `da-heledd-1633.gz_raw_data.raw_gz_facebook`
        union all
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            ads_cost,
            impression,
            click
        from `da-heledd-1633.gz_raw_data.raw_gz_criteo`
        union all
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            ads_cost,
            impression,
            click
        from `da-heledd-1633.gz_raw_data.raw_gz_bing`
        union all
        select
            date_date,
            paid_source,
            campaign_key,
            campaign_name,
            ads_cost,
            impression,
            click
        from `da-heledd-1633.gz_raw_data.raw_gz_adwords`
    ) as combined_data
