
-- Project: Maven CRM Sales Opportunities
-- File: 03_sales_analysis.sql
-- Purpose: Analyze sales outcomes, products, agents,
-- regional performance, and account performance.

-- =====================================================
-- 1. Overall sales outcomes and completed-deal win rate
-- =====================================================

SELECT
    deal_stage,
    COUNT(*) AS opportunity_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_all_opportunities
FROM public.sales_pipeline_clean
GROUP BY deal_stage
ORDER BY opportunity_count DESC;

SELECT
    COUNT(*) FILTER (WHERE deal_stage = 'Won') AS won_opportunities,
    COUNT(*) FILTER (WHERE deal_stage = 'Lost') AS lost_opportunities,
    COUNT(*) FILTER (
        WHERE deal_stage IN ('Won', 'Lost')
    ) AS completed_opportunities,
    ROUND(
        COUNT(*) FILTER (WHERE deal_stage = 'Won') * 100.0 /
        NULLIF(
            COUNT(*) FILTER (
                WHERE deal_stage IN ('Won', 'Lost')
            ),
            0
        ),
        2
    ) AS win_rate_pct
FROM public.sales_pipeline_clean;


-- =====================================================
-- 2. Product performance
-- =====================================================

SELECT
    product,
    COUNT(*) FILTER (WHERE deal_stage = 'Won') AS won_opportunities,
    COUNT(*) FILTER (WHERE deal_stage = 'Lost') AS lost_opportunities,
    COUNT(*) FILTER (
        WHERE deal_stage IN ('Won', 'Lost')
    ) AS completed_opportunities,
    SUM(close_value) FILTER (
        WHERE deal_stage = 'Won'
    ) AS won_revenue,
    ROUND(
        AVG(close_value) FILTER (
            WHERE deal_stage = 'Won'
        ),
        2
    ) AS avg_won_deal_value,
    ROUND(
        COUNT(*) FILTER (WHERE deal_stage = 'Won') * 100.0 /
        NULLIF(
            COUNT(*) FILTER (
                WHERE deal_stage IN ('Won', 'Lost')
            ),
            0
        ),
        2
    ) AS win_rate_pct
FROM public.sales_pipeline_clean
GROUP BY product
ORDER BY won_revenue DESC;


-- =====================================================
-- 3. Sales-agent performance
-- =====================================================

SELECT
    sales_agent,
    COUNT(*) FILTER (WHERE deal_stage = 'Won') AS won_opportunities,
    COUNT(*) FILTER (WHERE deal_stage = 'Lost') AS lost_opportunities,
    COUNT(*) FILTER (
        WHERE deal_stage IN ('Won', 'Lost')
    ) AS completed_opportunities,
    SUM(close_value) FILTER (
        WHERE deal_stage = 'Won'
    ) AS won_revenue,
    ROUND(
        AVG(close_value) FILTER (
            WHERE deal_stage = 'Won'
        ),
        2
    ) AS avg_won_deal_value,
    ROUND(
        COUNT(*) FILTER (WHERE deal_stage = 'Won') * 100.0 /
        NULLIF(
            COUNT(*) FILTER (
                WHERE deal_stage IN ('Won', 'Lost')
            ),
            0
        ),
        2
    ) AS win_rate_pct
FROM public.sales_pipeline_clean
GROUP BY sales_agent
ORDER BY won_revenue DESC;


-- =====================================================
-- 4. Regional-office performance
-- =====================================================

SELECT
    st.regional_office,
    COUNT(*) FILTER (WHERE sp.deal_stage = 'Won') AS won_opportunities,
    COUNT(*) FILTER (WHERE sp.deal_stage = 'Lost') AS lost_opportunities,
    COUNT(*) FILTER (
        WHERE sp.deal_stage IN ('Won', 'Lost')
    ) AS completed_opportunities,
    SUM(sp.close_value) FILTER (
        WHERE sp.deal_stage = 'Won'
    ) AS won_revenue,
    ROUND(
        AVG(sp.close_value) FILTER (
            WHERE sp.deal_stage = 'Won'
        ),
        2
    ) AS avg_won_deal_value,
    ROUND(
        COUNT(*) FILTER (WHERE sp.deal_stage = 'Won') * 100.0 /
        NULLIF(
            COUNT(*) FILTER (
                WHERE sp.deal_stage IN ('Won', 'Lost')
            ),
            0
        ),
        2
    ) AS win_rate_pct
FROM public.sales_pipeline_clean AS sp
LEFT JOIN public.sales_teams AS st
    ON sp.sales_agent = st.sales_agent
GROUP BY st.regional_office
ORDER BY won_revenue DESC;


-- =====================================================
-- 5. Account performance
-- =====================================================

SELECT
    sp.account,
    COUNT(*) FILTER (WHERE sp.deal_stage = 'Won') AS won_opportunities,
    COUNT(*) FILTER (WHERE sp.deal_stage = 'Lost') AS lost_opportunities,
    COUNT(*) FILTER (
        WHERE sp.deal_stage IN ('Won', 'Lost')
    ) AS completed_opportunities,
    SUM(sp.close_value) FILTER (
        WHERE sp.deal_stage = 'Won'
    ) AS won_revenue,
    ROUND(
        AVG(sp.close_value) FILTER (
            WHERE sp.deal_stage = 'Won'
        ),
        2
    ) AS avg_won_deal_value,
    ROUND(
        COUNT(*) FILTER (WHERE sp.deal_stage = 'Won') * 100.0 /
        NULLIF(
            COUNT(*) FILTER (
                WHERE sp.deal_stage IN ('Won', 'Lost')
            ),
            0
        ),
        2
    ) AS win_rate_pct
FROM public.sales_pipeline_clean AS sp
GROUP BY sp.account
ORDER BY won_revenue DESC NULLS LAST;
