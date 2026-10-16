"""
E-commerce Sales Analysis
Run: pip install pandas matplotlib
     python analyze_sales.py
Input: ecommerce_sales_data.csv in the same folder.
"""
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("ecommerce_sales_data.csv", parse_dates=["Order_Date"])
print("Rows:", len(df))
print("\nMissing values:\n", df.isna().sum())

delivered = df[df["Order_Status"] == "Delivered"].copy()
monthly = delivered.assign(Month=delivered["Order_Date"].dt.to_period("M").astype(str)).groupby("Month", as_index=False).agg(
    Revenue_INR=("Revenue_INR", "sum"),
    Profit_INR=("Profit_INR", "sum"),
    Orders=("Order_ID", "count")
)
category = delivered.groupby("Category", as_index=False).agg(
    Revenue_INR=("Revenue_INR", "sum"),
    Profit_INR=("Profit_INR", "sum"),
    Units_Sold=("Quantity", "sum")
).sort_values("Revenue_INR", ascending=False)
region = delivered.groupby("Region", as_index=False)["Revenue_INR"].sum().sort_values("Revenue_INR", ascending=False)

total_revenue = delivered["Revenue_INR"].sum()
total_profit = delivered["Profit_INR"].sum()
margin = (total_profit / total_revenue * 100) if total_revenue else 0

print(f"\nDelivered orders: {len(delivered)}")
print(f"Revenue: ₹{total_revenue:,.2f}")
print(f"Profit: ₹{total_profit:,.2f}")
print(f"Profit margin: {margin:.2f}%")
print("\nMonthly summary:\n", monthly.to_string(index=False))
print("\nCategory summary:\n", category.to_string(index=False))
print("\nRegional revenue:\n", region.to_string(index=False))

monthly.to_csv("monthly_summary.csv", index=False)
category.to_csv("category_summary.csv", index=False)
region.to_csv("region_summary.csv", index=False)

plt.figure(figsize=(10, 5))
plt.plot(monthly["Month"], monthly["Revenue_INR"], marker="o")
plt.title("Monthly Revenue (Delivered Orders)")
plt.xlabel("Month")
plt.ylabel("Revenue (INR)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("monthly_revenue.png", dpi=160)
print("\nSaved monthly_revenue.png and summary CSV files.")
