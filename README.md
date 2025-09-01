# Swiggy Data Analysis – Project Bundle

**Date:** 2025-09-01

This package contains:
- **Swiggy_Analysis.ipynb** – an end-to-end, presentation-ready notebook.
- **swiggy_analysis.sql** – DDL + curated insight queries for your database.
- **/outputs** – auto-created folder for charts and CSV exports when the notebook is run.

## Dataset
Single table derived from `swiggy.csv` with the following columns:
`ID, Area, City, Restaurant, Price, Avg ratings, Total ratings, Food type, Address, Delivery time`

## What the Notebook Delivers
- Data quality checks (rows, columns, missing values, duplicates, PK uniqueness).
- Core aggregations: city density, pricing by city, engagement leaders, cuisine mix.
- Clean matplotlib charts (no seaborn), one chart per cell, no explicit styling.
- Advanced flags: Hidden gems (high rating + moderate engagement) and high-rated-but-slow delivery.
- CSV exports for top tables and a KPI→Action matrix for your deck.

## How to Run
1. Place `swiggy.csv` next to the notebook.

2. Open **Swiggy_Analysis.ipynb** and run all cells.

3. Use the generated **/outputs** PNGs and CSVs directly in PowerPoint.


## SQL Usage
- Execute `swiggy_analysis.sql` in your SQL engine (SQLite-compatible syntax for string ops in the cuisine query). Adjust string functions for your dialect if needed (e.g., SPLIT_PART in Postgres, STRING_SPLIT in SQL Server 2022+).

## KPIs & Actions (Quick Reference)
- **Top-Rated Restaurants** → Co-marketing + best-practice replication.

- **Customer Engagement (Total Ratings)** → Feature high-volume partners prominently.

- **Average Price by City** → Tailor promotions/commission by city.

- **Geographic Density** → Improve SLAs where saturated; expand elsewhere.

- **Delivery Efficiency** → Borrow logistics playbooks from fastest cities.

- **Food Type Popularity** → Create homepage rows & festivals for top cuisines.


## Notes

- If your CSV uses different column headers, update `COLUMN_MAP` in the first code cell.

- The notebook saves assets in `./outputs`. Ensure the folder is writable.

