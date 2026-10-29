
-- Project: Maven CRM Sales Opportunities
-- Purpose: Standardize inconsistent product names while preserving source records.

CREATE OR REPLACE VIEW public.sales_pipeline_clean AS
SELECT
    opportunity_id,
    sales_agent,
    CASE
        WHEN product = 'GTXPro' THEN 'GTX Pro'
        ELSE product
    END AS product,
    account,
    deal_stage,
    engage_date,
    close_date,
    close_value
FROM public.sales_pipeline;
