SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    current_timestamp() AS ingestion_date
from {{ source('olist_bronze', 'olist_customers') }}
where customer_id is not null