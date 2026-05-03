# 📊 Marketing Campaign Performance Analysis
**Tool:** MySQL | **Domain:** Marketing Analytics | **Dataset:** Customer Personality Analysis (Kaggle)

---

## 📁 Project Structure

```
sql-marketing-analysis/
│
├── README.md                  ← You are here (findings & recommendations)
├── data/
│   └── marketing_campaign.csv ← Raw dataset (2,240 customers)
├── queries/
│   └── analysis_queries.sql   ← All 10 SQL queries
└── visuals/
    └── screenshots/           ← Query output screenshots from MySQL Workbench
```

---

## 🎯 Project Objective

This project analyzes marketing campaign performance data for a retail business using SQL. The goal is to identify which customer segments respond best to campaigns, understand spending behavior, and provide data-driven recommendations to improve future campaign ROI.

---

## 📦 Dataset Overview

| Attribute | Detail |
|---|---|
| Source | [Kaggle – Customer Personality Analysis](https://www.kaggle.com/datasets/rodsaldanha/arketing-campaign) |
| Rows | 2,240 customers |
| Columns | 29 attributes |
| Coverage | Demographics, household, product spend, campaign responses |

---

## 🔍 Analysis & Findings

### Query 1 — Overall Campaign Performance

| Campaign | Customers Converted |
|---|---|
| Campaign 1 | 144 |
| Campaign 2 | 30 |
| Campaign 3 | 163 |
| Campaign 4 | 167 |
| Campaign 5 | 163 |
| **Last Campaign** | **334** |
| Total Customers | 2,240 |

**Finding:** The last campaign was the strongest performer with 334 conversions — more than double any individual earlier campaign. Campaign 2 was the weakest with only 30 conversions (1.3% of total customers). This suggests significant improvement in targeting or messaging over time.

---

### Query 2 — Conversion Rate by Education Level

| Education | Total Customers | Converted | Conversion Rate |
|---|---|---|---|
| PhD | 486 | 101 | **20.78%** |
| Master | 370 | 57 | 15.41% |
| Graduation | 1,127 | 152 | 13.49% |
| 2n Cycle | 203 | 22 | 10.84% |
| Basic | 54 | 2 | 3.70% |

**Finding:** PhD holders convert at 20.78% — nearly 6x the rate of customers with only basic education. Higher education correlates strongly with campaign responsiveness, likely reflecting higher income and purchasing power.

---

### Query 3 — Conversion Rate by Marital Status

| Marital Status | Total Customers | Converted | Conversion Rate |
|---|---|---|---|
| Widow | 77 | 19 | **24.68%** |
| Single | 480 | 106 | 22.08% |
| Divorced | 232 | 48 | 20.69% |
| Married | 864 | 98 | 11.34% |
| Together | 580 | 60 | 10.34% |

**Finding:** Single and widowed customers convert at roughly 2x the rate of married or partnered customers. This may indicate that customers without dependents have more disposable income and greater responsiveness to promotional offers.

---

### Query 4 — Average Spend by Product Category

| Category | Average Spend (USD) |
|---|---|
| 🍷 Wines | **$303.94** |
| 🥩 Meat Products | $166.95 |
| 🥇 Gold Products | $44.02 |
| 🐟 Fish Products | $37.53 |
| 🍬 Sweets | $27.06 |
| 🍎 Fruits | $26.30 |

**Finding:** Wines account for the largest share of customer spending at $303.94 average — nearly double the second-highest category (Meat at $166.95). Together, wines and meat represent over 75% of total average customer spend, making them the two most strategic product categories for upselling campaigns.

---

### Query 5 — Customer Value Segmentation

| Segment | Customers | Avg Income | Conversion Rate |
|---|---|---|---|
| High Value (spend ≥ $1,000) | 602 | $74,686 | **28.41%** |
| Mid Value (spend $500–$999) | 393 | $62,624 | 10.43% |
| Low Value (spend < $500) | 1,245 | $38,064 | 9.80% |

**Finding:** High-value customers convert at 28.41% — nearly 3x the rate of low-value customers. They also earn significantly more ($74,686 vs $38,064 average income). This segment, while only 27% of the customer base, is the most responsive and most profitable audience for campaigns.

---

### Query 6 — Conversion Rate by Income Group

| Income Group | Customers | Converted | Conversion Rate |
|---|---|---|---|
| High Income (≥ $70,000) | 508 | 142 | **27.95%** |
| Low Income (< $40,000) | 732 | 85 | 11.61% |
| Mid Income ($40,000–$69,999) | 976 | 106 | 10.86% |

**Finding:** High-income customers convert at 27.95% compared to 10.86% for mid-income customers. Interestingly, low-income customers slightly outperform mid-income ones (11.61% vs 10.86%), suggesting mid-income customers may be the hardest segment to activate with standard campaigns.

---

### Query 7 — Spending Behavior vs Campaign Efficiency

| Spender Type | Customers | Avg Purchases | Conversion Rate |
|---|---|---|---|
| High Spender (≥ $1,000 total) | 602 | 20.04 | **28.41%** |
| Low Spender (< $1,000 total) | 1,638 | 9.78 | 9.95% |

**Finding:** High spenders make an average of 20 purchases versus 9.78 for low spenders — and convert at nearly 3x the rate. This confirms that purchase frequency and campaign responsiveness are strongly correlated, making purchase history a reliable predictor of campaign success.

---

### Query 8 — Recency vs Campaign Response

| Recency Segment | Customers | Conversion Rate |
|---|---|---|
| Active (0–30 days) | 724 | **23.90%** |
| Warm (31–60 days) | 654 | 13.61% |
| Cooling (61–90 days) | 664 | 9.19% |
| Inactive (90+ days) | 198 | 5.56% |

**Finding:** Customers who purchased within the last 30 days convert at 23.90% — more than 4x the rate of inactive customers (90+ days). Recency is one of the strongest predictors of campaign response, reinforcing the RFM model principle.

---

### Query 9 — Ideal Customer Profile (Top Spenders)

| Education | Marital Status | Avg Income | Avg Total Spend | Customers |
|---|---|---|---|---|
| Graduation | Absurd | $79,244 | $1,216.00 | 1 |
| Master | Absurd | $65,487 | $1,169.00 | 1 |
| Master | Widow | $58,401 | $879.75 | 12 |
| PhD | Widow | $60,288 | $797.67 | 24 |
| Master | Single | $53,530 | $746.04 | 75 |

**Finding:** Statistically meaningful segments (n > 10) show that widowed customers with Master's or PhD degrees and single customers with Master's degrees represent the highest-spending profiles. The **Master's + Single** combination (75 customers, $746 avg spend) is the most scalable high-value segment to target.

---

### Query 10 — Churn Risk Segment

| Metric | Value |
|---|---|
| Churn Risk Customers | **1,631** |
| Average Income | $48,676 |
| Average Recency | 50.90 days |
| Average Total Spend | $458.11 |

**Finding:** 1,631 customers (72.8% of the total base) have never responded to any campaign. Despite spending an average of $458 and having mid-range income, they remain entirely unactivated. This is the largest untapped opportunity in the dataset.

---

## 💡 Business Recommendations

**1. Prioritize high-income, highly-educated segments.**
PhD and Master's degree holders convert at 15–21% compared to 3.7% for basic education customers. Future campaigns should be weighted toward this audience for maximum ROI.

**2. Re-engage recently active customers immediately.**
Customers active within 30 days convert at 23.9%. Triggered campaigns (within 1–2 weeks of last purchase) could significantly improve overall conversion rates.

**3. Launch a dedicated re-engagement campaign for the 1,631 churn-risk customers.**
This segment represents 72.8% of the customer base with zero campaign response history. A targeted offer — particularly on wines and meat products (top spend categories) — could recover a portion of this dormant base.

**4. Focus upselling on wines and meat products.**
These two categories account for over 75% of average customer spend. Bundling campaigns around these products would align with demonstrated purchase preferences.

**5. Deprioritize Campaign 2 strategy.**
With only 30 conversions (1.3% of customers), Campaign 2's approach was significantly underperforming. Its targeting logic or offer structure should be reviewed before reuse.

---

## 🛠️ Tools Used

- **MySQL** — database creation, data storage, querying
- **Python (pandas, sqlalchemy, pymysql)** — data import from CSV to MySQL
- **Jupyter Notebook** — data loading and connection scripting
- **MySQL Workbench** — query execution and result verification

---

## 👤 Author

**Swagata Barman**
BBA in Business Analytics & Marketing — United International University, Dhaka
📧 barmanswagata1@gmail.com
🌐 [swa34.wordpress.com](https://swa34.wordpress.com)
🔗 LinkedIn: [www.linkedin.com/in/swagata-barman-a904b5334/] (https://www.linkedin.com/in/swagata-barman-a904b5334/)
