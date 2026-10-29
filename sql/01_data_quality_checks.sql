
-- Project: Maven CRM Sales Opportunities
-- File: 01_data_quality_checks.sql
-- Purpose: Validate data completeness, uniqueness, consistency,
-- and relationships before business analysis.

-- 1. Check total rows and unique opportunity IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT opportunity_id) AS unique_opportunities
FROM public.sales_pipeline;

-- 2. Check for duplicate opportunity IDs
SELECT
    opportunity_id,
    COUNT(*) AS duplicate_count
FROM public.sales_pipeline
GROUP BY opportunity_id
HAVING COUNT(*) > 1;

-- 3. Check missing account names
SELECT
    COUNT(*) AS missing_account_rows
FROM public.sales_pipeline
WHERE account IS NULL
   OR TRIM(account) = '';

-- 4. Check missing closing dates and values
SELECT
    COUNT(*) FILTER (WHERE close_date IS NULL) AS missing_close_dates,
    COUNT(*) FILTER (WHERE close_value IS NULL) AS missing_close_values
FROM public.sales_pipeline;

-- 5. Review opportunity counts by deal stage
SELECT
    deal_stage,
    COUNT(*) AS opportunity_count
FROM public.sales_pipeline
GROUP BY deal_stage
ORDER BY opportunity_count DESC;

-- 6. Check inconsistent product naming
SELECT
    product,
    COUNT(*) AS row_count
FROM public.sales_pipeline
WHERE product = 'GTXPro'
GROUP BY product;

-- 7. Check for negative closing values
SELECT
    COUNT(*) AS negative_close_values
FROM public.sales_pipeline
WHERE close_value < 0;

-- 8. Check whether closing dates precede engagement dates
SELECT
    COUNT(*) AS invalid_date_order_rows
FROM public.sales_pipeline
WHERE close_date < engage_date;

-- 9. Check for sales agents without a matching sales-team record
SELECT COUNT(*) AS unmatched_sales_agents
FROM public.sales_pipeline AS sp
LEFT JOIN public.sales_teams AS st
    ON sp.sales_agent = st.sales_agent
WHERE st.sales_agent IS NULL;

-- 10. Check for nonblank accounts without a matching account record
SELECT COUNT(*) AS unmatched_accounts
FROM public.sales_pipeline AS sp
LEFT JOIN public.accounts AS a
    ON sp.account = a.account
WHERE sp.account IS NOT NULL
  AND TRIM(sp.account) <> ''
  AND a.account IS NULL;
