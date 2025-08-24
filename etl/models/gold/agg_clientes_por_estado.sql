select 
    customer_state as estado,
    count(DISTINCT customer_unique_id) as total_clientes_unicos
from {{ ref('stg_customers') }}
group by customer_state
order by total_clientes_unicos desc