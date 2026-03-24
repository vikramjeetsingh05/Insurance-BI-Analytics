# Insurance BI Analytics — Risk, Fraud & Revenue Analysis

A full end-to-end business intelligence project on a simulated motor insurance portfolio of 1 million customers.
I built the dataset from scratch in Python, ran financial analysis in SQL Server, and visualised everything in a Jupyter notebook.

The goal was to answer one business question — **is this portfolio making money or losing it, and why?**

---

## What This Project Covers

- Simulated 1,000,000 insurance policies with realistic risk-based pricing
- Generated 49,367 claims across 2025 and early 2026
- Ran 12 SQL queries covering loss ratios, fraud detection, earned premium, and future liability
- Built a Python EDA notebook with charts for every key finding

---

## Key Findings

| Finding | Number |
|---------|--------|
| Total Premium Collected | Rs. 2.93 Billion |
| Total Claims Paid | Rs. 5.49 Billion |
| Portfolio Loss Ratio | 187.66% |
| Fraud Claims | 967 (1.96% of claims) |
| Fraud Amount | Rs. 82.6 Crore (15% of total payout) |
| Future Claim Liability | Rs. 1,060 Crore |

**The portfolio is deeply unprofitable.** For every Rs. 1 collected in premium, Rs. 1.87 is paid out in claims.
The biggest problems are Luxury vehicle underpricing and 4-year tenure long tail liability.

---

## Project Structure

```
Insurance-BI-Analytics/
│
├── phase1_simulation.py          # Data generation — 1M policies + 49K claims
├── Insurance_BI_Analytics.ipynb  # Full EDA with charts and insights
├── insurance_analysis.sql        # 12 SQL queries on SQL Server
└── README.md
```

---

## Data Simulation

I simulated the data myself instead of using a Kaggle dataset. The goal was to make it realistic enough to run meaningful financial analysis on.

**Policy Table — 1,000,000 rows**

| Column | Logic |
|--------|-------|
| Customer Age | Random 18–70 |
| City Tier | 1 = Metro (40%), 2 = Mid-size (35%), 3 = Small town (25%) |
| Vehicle Category | Hatchback, Sedan, SUV, Luxury with realistic market distribution |
| Vehicle Value | Fixed by category — Hatchback Rs. 5L to Luxury Rs. 25L |
| Premium | Risk-based — adjusted for age, city tier, and vehicle type |
| Policy Tenure | 1–4 years with weighted distribution |

**Claims Table — 49,367 rows**

- 2025 claims — 30% of vehicles purchased on weekly dates (7, 14, 21, 28) filed a claim on policy start date
- 2026 claims — 10% of 4-year tenure vehicles filed claims in Jan–Feb 2026
- Claim amounts follow a **log-normal distribution** centered at 10% of vehicle value
- 2% of claims flagged as fraudulent with amounts set to 90% of vehicle value

---

## SQL Analysis — 12 Queries

All queries run on Microsoft SQL Server against two tables — `policy` and `claims`.

| # | Query | Concept Used |
|---|-------|-------------|
| 1 | Portfolio Loss Ratio | Aggregation |
| 2 | Loss Ratio by Policy Tenure | GROUP BY |
| 3 | Loss Ratio by Vehicle Category | JOIN + GROUP BY |
| 4 | Loss Ratio by City Tier | JOIN + GROUP BY |
| 5 | Monthly Claim Trend | YEAR() MONTH() functions |
| 6 | Overall Fraud Impact | CASE WHEN conditionals |
| 7 | Fraud by Vehicle Category | CASE WHEN + JOIN |
| 8 | Fraud by City Tier | CASE WHEN + JOIN |
| 9 | Fraud by Age Group | CASE WHEN bucketing |
| 10 | Claim Frequency by Age Group | COUNT DISTINCT |
| 11 | Earned Premium | DATEDIFF date calculations |
| 12 | Future Claim Liability | LEFT JOIN + NULL check |

---

## Selected Insights

**Luxury vehicles are the biggest problem**
Luxury has the fewest claims — only 4,913 — but the highest loss ratio at 408%.
This is a severity problem not a frequency problem. Each Luxury claim averages Rs. 2.25L vs Rs. 50K for a Hatchback.
Luxury premiums need a 4-5x increase to reach a sustainable loss ratio.

**4-year tenure carries hidden liability**
4-year policies look manageable upfront but second-cycle claims hit in 2026 and caused a 60% spike in monthly claim costs.
This is long tail liability — premium collected in 2024 but claims arriving in 2026 and beyond.

**Fraud is disproportionate**
Fraud is 1.96% of claims by count but 15% of total claim payout.
Metro cities (Tier 1) have the highest fraud rate at 2.13%.
The 26-40 age group has the highest fraud rate at 2.07% — consistent with global insurance fraud patterns.

**The pricing structure is not viable**
At 187% loss ratio the company is losing Rs. 0.87 on every rupee collected.
No insurance company can survive this without major repricing across all segments.

---

## Tools Used

- **Python** — Pandas, NumPy, Matplotlib, Seaborn
- **SQL** — Microsoft SQL Server, SSMS
- **Jupyter Notebook**

---

## How to Run

**Data Simulation**
```bash
python phase1_simulation.py
```
Generates `policy_enhanced.csv` and `claims_enhanced.csv`

**SQL Queries**
- Load both CSVs into SQL Server using SSMS Import Flat File
- Run `insurance_analysis.sql` against the `InsuranceBI_Enhanced` database

**Python Notebook**
```bash
jupyter notebook Insurance_BI_Analytics.ipynb
```
Update the file paths in Cell 3 to match your local directory.

---

## About

Built by Vikramjeet — originally started as a BI internship assignment, then extended independently to include risk-based pricing, variable claim distributions, fraud detection, and advanced SQL analysis.

Connect with me on [GitHub](https://github.com/vikramjeetsingh05)
