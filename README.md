#  Credit Risk Identification Pipeline

##  Project Overview

This project demonstrates an end-to-end Credit Risk Identification system using:

- Microsoft SQL Server
- Scenario Modeling
- Power BI Dashboard
- Excel Analysis

The objective is to classify customers into LOW, MEDIUM and HIGH risk categories based on financial behavior and loan exposure.

---

##  Business Problem

Banks must identify customers who are likely to default.

This project evaluates:

- Missed payment behavior
- Loan-to-Income ratio
- Credit score impact
- Risk clustering patterns

---

##  Dataset Structure

### Customers Data
- Customer ID
- Income
- Credit Score

### Loans Data
- Loan ID
- Loan Amount

### Payment Behavior
- Missed Payments

### Calculated Metrics
- Loan Income Ratio
- Risk Level

---

##  Risk Classification Logic

HIGH RISK:
- Missed Payment >= 3
- Credit Score < 620
- High Loan-Income Ratio

MEDIUM RISK:
- 1–2 missed payments

LOW RISK:
- No missed payments
- Strong credit score

---

##  Power BI Dashboard Includes

✔ Risk Distribution Overview  
✔ Loan vs Income Scatter Analysis  
✔ Average Credit Score by Risk Level  
✔ Missed Payment Impact  
✔ High Risk Customer Watchlist  

---

##  Key Insights

- High-risk customers have significantly lower credit scores.
- Loan-to-income ratio strongly correlates with risk.
- Repeated missed payments increase risk probability.

---

##  Tools Used

- SQL Server
- Power BI
- Excel
- GitHub

---
