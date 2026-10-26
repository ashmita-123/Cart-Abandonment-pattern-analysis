# CartWise Commerce — Cart Abandonment Pattern Analysis

An end-to-end data analytics portfolio project using SQL, Python, and Power BI to understand shopping cart abandonment, identify patterns in customer behavior, and recommend improvements to the checkout experience.

## Project Overview

CartWise Commerce is a fictional e-commerce business used for this portfolio case study. The project analyzes shopping sessions to understand why customers leave without completing a purchase.

The analysis covers customer segments, device types, product categories, shipping costs, payment methods, discount levels, checkout behavior, and abandonment reasons.

**Note:** This project uses synthetic data created for educational and portfolio purposes. It does not contain real customer information.

## Business Objectives

- Calculate the overall cart abandonment and conversion rates.
- Identify device types and product categories associated with higher abandonment.
- Analyze the relationship between shipping costs and cart abandonment.
- Compare abandonment rates across payment methods and customer segments.
- Identify the most common reasons for abandoned carts.
- Examine monthly abandonment trends and cart value patterns.
- Build an interactive dashboard to support data-driven business recommendations.

## Dataset Description

The project uses two CSV datasets covering January to September 2026.

| Dataset | Records | Columns | Primary Key |
|---|---:|---:|---|
| Customers | 2,500 | 7 | `customer_id` |
| Shopping Sessions | 10,000 | 14 | `session_id` |

### Customers Dataset

Contains customer attributes such as:

- Customer segment
- Device type
- Acquisition channel
- Region
- Age group
- Loyalty membership

### Shopping Sessions Dataset

Contains session-level information such as:

- Session and customer IDs
- Session date
- Product category
- Cart value and number of items
- Discount percentage
- Shipping cost type
- Checkout status and duration
- Payment method
- Session outcome
- Abandonment reason

The datasets are connected through `customer_id`, allowing customer attributes to be analyzed alongside shopping sessions.

## Tools and Technologies

| Tool / Technology | Purpose |
|---|---|
| PostgreSQL | Database creation, data validation, joins, aggregations, and business queries |
| SQL | Answering business questions and calculating key metrics |
| Python | Exploratory data analysis, data cleaning, and visualization |
| pandas | Data loading, transformation, merging, and aggregation |
| NumPy | Numerical operations and value grouping |
| Matplotlib | Data visualization |
| Seaborn | Statistical charts |
| Jupyter Notebook | Executing and documenting Python analysis |
| Power BI Desktop | Interactive dashboards, DAX measures, and data modeling |

## Project Workflow

1. Define the business problem and analytical questions.
2. Create PostgreSQL tables for customers and shopping sessions.
3. Import the CSV files and validate the data.
4. Check record counts, unique IDs, missing values, and relationships.
5. Use SQL queries to analyze abandonment patterns.
6. Perform exploratory data analysis using Python.
7. Calculate key performance indicators and create visualizations.
8. Build an interactive Power BI dashboard.
9. Compare results across SQL, Python, and Power BI.
10. Develop recommendations and document project limitations.

## Key Performance Indicators

The main KPIs used in the project are:

- **Total Sessions:** Total number of shopping sessions.
- **Abandoned Sessions:** Sessions that ended without a purchase.
- **Converted Sessions:** Sessions that resulted in a completed purchase.
- **Abandonment Rate:** Abandoned sessions divided by total sessions.
- **Conversion Rate:** Converted sessions divided by total sessions.
- **Average Cart Value:** Average cart value across sessions.
- **Average Checkout Duration:** Average checkout duration for sessions that started checkout.

## Key Findings

The analysis produced the following results from the synthetic dataset:

| Metric | Result |
|---|---:|
| Total Sessions | 10,000 |
| Abandoned Sessions | 5,716 |
| Converted Sessions | 4,284 |
| Overall Abandonment Rate | 57.16% |
| Overall Conversion Rate | 42.84% |
| Mobile Abandonment Rate | 60.78% |
| Desktop Abandonment Rate | 51.55% |
| Paid-Shipping Abandonment Rate | 62.35% |
| Electronics Abandonment Rate | 58.25% |
| Net Banking Abandonment Rate | 58.00% |
| March 2026 Abandonment Rate | 59.18% |

Additional findings:

- Unexpected shipping cost was recorded for 1,061 sessions.
- Mobile sessions had a higher abandonment rate than desktop sessions.
- Monthly abandonment fluctuated between 54.93% in January and 59.18% in March, without a sustained upward or downward trend.
- The ₹10,000-and-above cart value group had an abandonment rate of 66.67%, but contained only 12 sessions. This result should be interpreted cautiously.

These findings describe patterns in the synthetic dataset and do not, by themselves, establish causal relationships.

## Power BI Dashboard

The interactive dashboard is organized into three pages.

### Page 1 — Overview & Navigation

Provides a summary of the project through KPI cards, a session outcome donut chart, and a monthly abandonment rate line chart.

### Page 2 — Abandonment Patterns

Examines abandonment rates across:

- Device type
- Product category
- Shipping cost type
- Payment method
- Customer segment
- Acquisition channel
- Discount percentage

Interactive slicers allow users to explore results by month, region, device, customer segment, product category, and shipping cost type.

### Page 3 — Checkout & Reason Analysis

Focuses on abandonment reasons, payment methods, checkout status, cart value, checkout duration, and session-level details. Cart value bands are used to make value-based analysis easier to interpret.

The dashboard uses DAX measures and a date table so that KPIs update according to the selected filters.

## Business Recommendations

Based on the patterns observed in the synthetic dataset, the project proposes the following actions for further testing:

1. **Improve mobile checkout:** Review page speed, form usability, autofill, and mobile payment options.
2. **Improve shipping cost transparency:** Display shipping charges earlier and test free-shipping thresholds while monitoring margins and average order value.
3. **Improve payment reliability:** Monitor payment failures, provide retry options, and offer alternative payment methods.
4. **Simplify checkout:** Test guest checkout to reduce friction during account creation.
5. **Build trust with new customers:** Make reviews, return policies, and secure-payment information more visible.
6. **Recover abandoned carts:** Test reminder messages or emails with cart details and relevant offers.
7. **Use targeted discounts:** Evaluate offers carefully rather than relying only on broad discounts.

These are hypotheses for business improvement, not proven causal effects. Controlled experiments should be used to measure their impact.

## SQL Analysis

SQL is used to answer questions such as:

- What is the overall abandonment rate?
- Which devices have the highest abandonment rate?
- Which product categories experience more abandonment?
- Is paid shipping associated with higher abandonment?
- Which payment methods have higher abandonment rates?
- What are the most common abandonment reasons?
- How do customer segments compare?
- How does abandonment change month by month?
- Does abandonment vary by discount percentage?
- How does abandonment relate to cart value?

The analysis uses joins, filtering, grouping, aggregation, conditional logic, and date-based analysis.

## Python Analysis

Python is used for:

- Loading and validating CSV datasets
- Merging customer and session records
- Checking data quality and key uniqueness
- Calculating KPIs
- Comparing abandonment rates across categories
- Analyzing monthly trends
- Creating cart value bands
- Visualizing results with Matplotlib and Seaborn
- Exporting analysis outputs for reuse

## Data Validation and Reproducibility

The project includes checks for record counts, duplicate identifiers, missing values, invalid values, orphan customer references, and consistency between session outcomes and abandonment reasons.

Selected results were reconciled across SQL, Python, and Power BI. The documented comparisons agreed, including the overall abandonment rate of 57.16%.

## How to Run the Project

### 1. Set Up PostgreSQL

- Install PostgreSQL and open pgAdmin.
- Create a database, for example, `cartwise`.
- Create the customer and session tables using the SQL scripts.
- Import the two CSV files into their corresponding tables.
- Run the validation queries and business analysis queries.

### 2. Run the Python Analysis

Install the required libraries:

```bash
pip install pandas numpy matplotlib seaborn jupyter
```

Place the two CSV files in the locations expected by the notebook. Open Jupyter Notebook, open `cart_abandonment_eda.ipynb`, and run the cells in order.

### 3. Open the Power BI Dashboard

- Open the `.pbix` file in Power BI Desktop.
- If the CSV file locations have changed, update the paths in **Transform data → Data source settings**.
- Confirm the relationships between the customer, session, and date tables.
- Refresh the data and verify the KPIs and visuals.

**Note:** The exact filenames and database connection settings may need to be adjusted to match your local setup.

## Limitations

- The data is synthetic and may not represent real e-commerce behavior.
- Observed associations do not establish causation.
- Some categories, especially very high cart values, contain few observations.
- Recommendations should be validated with real business data and controlled experiments before implementation.

## Future Enhancements

- Analyze combinations such as device type and shipping cost.
- Estimate potential revenue recovery from abandoned carts.
- Add more detailed checkout funnel analysis.
- Test targeted cart recovery campaigns.
- Extend the dashboard with additional customer and time-based comparisons.
- Evaluate recommendations using A/B testing and appropriate statistical methods.

## Skills Demonstrated

SQL | PostgreSQL | Python | pandas | NumPy | Data Cleaning | Exploratory Data Analysis | Data Visualization | Power BI | DAX | Data Modeling | Business Analysis | Dashboard Development

## Conclusion

The CartWise Commerce Cart Abandonment Pattern Analysis project demonstrates an end-to-end analytics workflow, from raw data validation and SQL analysis to Python exploration and interactive Power BI reporting. It translates session-level data into measurable findings and practical hypotheses for improving the shopping and checkout experience.

---

**Project:** Cart Abandonment Pattern Analysis  
**Organization:** CartWise Commerce (fictional case study)  
**Prepared by:** Ashmita Karmakar  
**Period analyzed:** January–September 2026  
**Data type:** Synthetic, for educational and portfolio purposes
