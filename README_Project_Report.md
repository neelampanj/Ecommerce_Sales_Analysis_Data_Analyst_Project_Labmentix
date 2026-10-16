# E-commerce Sales Analysis Project

## Project overview
This project demonstrates a small end-to-end business analytics workflow using Excel, SQL, Power BI, and introductory Python. It explores order-level sales data to understand revenue, profit, category performance, regional performance, channel performance, and monthly trends.

**Important data note:** The 500 rows in `ecommerce_sales_data.csv` are synthetic, generated for this portfolio project. They are not real company/customer transactions. State this clearly if asked.

## Business questions
1. What are delivered-order revenue, profit, units sold, and profit margin?
2. How do revenue and profit change month by month?
3. Which product categories and products contribute most revenue?
4. Which regions and sales channels perform best?
5. What share of records are delivered, returned, or cancelled?
6. How can discounting be evaluated alongside profit?

## Files
- `ecommerce_sales_data.csv` — 500 synthetic order records.
- `Ecommerce_Sales_Analysis.xlsx` — executive summary and analysis sheets.
- `analysis_queries.sql` — MySQL schema and analysis queries.
- `analyze_sales.py` — Python analysis script (requires pandas and matplotlib).
- `PowerBI_Dashboard_Guide.txt` — import steps, suggested visuals, and DAX measures.

## Methodology
1. Generated a reproducible synthetic dataset with order date, region, channel, category, product, quantity, price, discount, revenue, cost, profit, payment method, and status.
2. Used delivered orders for primary revenue/profit KPIs to avoid counting returned/cancelled orders as completed sales.
3. Aggregated monthly, category, regional, channel, and product-level results.
4. Prepared SQL queries for independent analysis and a Power BI dashboard design guide.
5. Included Python code to reproduce key summaries and export charts/summary CSVs.

## KPI definitions
- Revenue: `Revenue_INR` for delivered orders only.
- Profit: `Profit_INR` for delivered orders only.
- Profit margin: total profit / total revenue × 100.
- Units sold: sum of quantity for delivered orders.
- Delivered orders: count of rows with `Order_Status = Delivered`.

## Key findings from this sample
- Delivered orders: 438
- Units sold: 1,107
- Delivered revenue: ₹1,645,899.55
- Delivered profit: ₹494,586.00
- Profit margin: 30.05%

The detailed category, regional, channel, product, and monthly results are available in the Excel workbook and can be reproduced with the SQL/Python files. Since the data is synthetic, findings are only illustrative and should not be treated as actual market evidence.

## How to run the Python analysis
1. Install Python 3.10+.
2. Place `analyze_sales.py` and `ecommerce_sales_data.csv` in the same folder.
3. Run: `pip install pandas matplotlib`
4. Run: `python analyze_sales.py`

## How to load the data into MySQL
1. Create the database and table using `analysis_queries.sql`.
2. Import the CSV using MySQL Workbench's Table Data Import Wizard.
3. Run the queries in `analysis_queries.sql`.

## How to create the Power BI report
Follow `PowerBI_Dashboard_Guide.txt`. Save the final report as `Ecommerce_Sales_Analysis.pbix` after building the visuals in Power BI Desktop.

## Suggested 60-second project explanation
"I created an E-commerce Sales Analysis project to demonstrate how I would turn raw order data into business insights. I cleaned and explored a 500-row sample dataset, used SQL to aggregate sales and profit, used Excel for summary analysis, and prepared a Power BI dashboard plan with KPI cards, monthly trends, category, region, and channel comparisons. I also wrote Python code to reproduce the main summaries. The dataset is synthetic and is used only to demonstrate the analysis workflow."
