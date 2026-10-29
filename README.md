# Maven CRM Sales Opportunities Analysis

## Project Overview

This project analyzes a CRM sales pipeline dataset to evaluate sales outcomes, product performance, sales-agent performance, regional results, and account performance.

Using **PostgreSQL** for data validation, cleaning, and analysis and **Microsoft Excel** for data modeling, measures, PivotTables, and charts, the project turns raw opportunity records into business findings and recommendations.

## Business Questions

- What proportion of sales opportunities are Won, Lost, or still open?
- Which products contribute the most won revenue, and how do products differ in win rate and average deal value?
- How do sales agents compare across revenue, conversion rate, opportunity volume, and average won-deal value?
- How do results vary by region and account?
- What should the business investigate before changing its sales priorities?

## Tools Used

- **PostgreSQL / pgAdmin 4** — data-quality checks, data cleaning, joins, aggregations, conditional calculations, and business analysis.
- **Microsoft Excel** — Power Query, Data Model relationships, DAX measures, PivotTables, and charts.
- **GitHub** — project versioning and documentation.

## Dataset

The project uses the Maven Analytics CRM Sales Opportunities dataset, containing sales opportunities and supporting lookup tables for accounts, sales agents and teams, and products.

The sales pipeline contains **8,800 opportunity records**.

## Data Preparation and Quality Checks

Data-quality checks covered opportunity ID uniqueness, missing values, deal-stage distributions, date validity, product-name consistency, and matching records to lookup tables.

Key findings and decisions:

- Confirmed that the 8,800 opportunity IDs were unique.
- Identified 1,425 opportunities with missing account names.
- Found 2,089 opportunities with missing close dates and closing values. These corresponded to opportunities still in the open stages.
- Standardized the inconsistent product label `GTXPro` to `GTX Pro` in the cleaned view, covering 1,480 records.
- Preserved open opportunities and missing account values rather than deleting potentially useful records.
- Kept the original sales pipeline table unchanged and performed the product-name correction through a SQL view.

## Key Findings

### Overall Sales Outcomes

| Metric | Result |
|---|---:|
| Total opportunities | 8,800 |
| Won opportunities | 4,238 |
| Lost opportunities | 2,473 |
| Open opportunities | 2,089 |
| Completed opportunities | 6,711 |
| Win rate among completed opportunities | 63.15% |
| Total won revenue | 10,005,534 |

The completed-deal win rate is calculated as Won opportunities divided by Won plus Lost opportunities. Open opportunities are excluded from this calculation.

### Product Performance

- **GTX Pro** generated the highest won revenue, totaling 3,510,578 across 729 won opportunities.
- **GTX Plus Pro** had an average won-deal value of 5,489.88 and a 64.30% win rate across 745 completed opportunities.
- **GTK 500** had the highest average won-deal value at 26,707.47, but this result came from only 25 completed opportunities.
- **MG Special** had the highest product win rate at 64.84%, with 793 wins, but generated only 43,768 in won revenue due to its low average won-deal value.

These results show that product rankings vary depending on whether performance is measured by revenue, win rate, deal volume, or average deal value.

### Sales-Agent Performance

- **Darcel Schlecht** generated the highest won revenue among agents, totaling 1,153,214 across 349 wins.
- **Hayden Neloms** recorded the highest agent win rate at 70.39%, across 152 completed opportunities.
- **Elease Gluck** had the highest average won-deal value among agents at 3,614.94, across 80 wins.

No single agent led every metric, demonstrating the importance of considering revenue, conversion, opportunity volume, and deal value together.

### Regional and Account Analysis

Regional analysis showed that the West office led in won revenue at 3,568,647, while Central recorded the most wins at 1,629. East had the highest average won-deal value among regions at 2,639.28.

Account-level analysis also revealed different performance patterns. Kan-code led won revenue among accounts at 341,455, while other accounts performed differently when ranked by win rate, completed opportunities, or average won-deal value.

## Business Recommendations

1. **Investigate the open pipeline.** Review how long opportunities have remained in Prospecting and Engaging, identify deals that may need follow-up, and investigate missing account names where possible.
2. **Investigate product-level demand and profitability.** Examine product margins, demand, and deal patterns before changing sales priorities. Interpret GTK 500's high average deal value cautiously because of its small completed-deal count.
3. **Learn from high-performing sales agents.** Investigate the practices of agents with strong revenue, win rates, or average deal values and assess whether effective approaches can be shared across the team.
4. **Use multiple measures when evaluating performance.** Revenue, win rate, volume, and average deal value provide different perspectives and should be interpreted together.

## Limitations

- The dataset does not provide sales targets or historical benchmarks for determining whether performance meets business expectations.
- Product costs and profit margins are not available; therefore, won revenue should not be interpreted as profit.
- Pipeline aging information is unavailable, limiting the identification of stalled opportunities.
- Some open opportunities have missing account names, which limits account-level investigation.
- Agent and regional comparisons may be affected by differences in workload, experience, product mix, account mix, and opportunity allocation.
- GTK 500's high average won-deal value is based on a small number of completed opportunities and may not represent its typical performance.

## Project Files

- [`SQL scripts`](sql/) — data-quality checks, cleaning view, and sales analysis queries.
- [`Excel workbook`](excel/maven_crm_sales_analysis.xlsx) — data model, measures, PivotTables, and charts.
- [`Screenshots`](images/) — selected visualizations from the analysis.

## Conclusion

This project demonstrates an end-to-end analytical workflow, from validating and cleaning CRM data with SQL to building an Excel Data Model and evaluating business performance through multiple measures.

The main takeaway is that strong business recommendations require more than ranking products or sales agents by one metric. The next step is to investigate open-pipeline aging, product profitability, and the practices behind sales-agent performance before making operational changes.
