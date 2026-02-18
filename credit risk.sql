CREATE DATABASE CreditRiskProject;
USE CreditRiskProject;

SELECT * FROM customers;
SELECT * FROM loans;
SELECT * FROM payments;


ALTER TABLE customers
ADD CONSTRAINT PK_customers PRIMARY KEY (customer_id);

ALTER TABLE loans
ADD CONSTRAINT PK_loans PRIMARY KEY (loan_id);

ALTER TABLE payments
ADD CONSTRAINT PK_payments PRIMARY KEY (payment_id);


ALTER TABLE loans
ADD CONSTRAINT FK_loans_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE payments
ADD CONSTRAINT FK_payments_loans
FOREIGN KEY (loan_id)
REFERENCES loans(loan_id);



CREATE TABLE customer_risk (
    customer_id VARCHAR(10),
    loan_id VARCHAR(10),
    missed_payments INT,
    income INT,
    loan_amount INT,
    credit_score INT,
    loan_income_ratio FLOAT,
    risk_level VARCHAR(20)
);


WITH payment_summary AS (
    SELECT 
        l.customer_id,
        l.loan_id,
        COUNT(CASE WHEN p.status = 'MISSED' THEN 1 END) AS missed_count
    FROM loans l
    JOIN payments p 
        ON l.loan_id = p.loan_id
    GROUP BY l.customer_id, l.loan_id
),

risk_base AS (
    SELECT
        ps.customer_id,
        ps.loan_id,
        ps.missed_count,
        c.income,
        l.loan_amount,
        c.credit_score,
        CAST(l.loan_amount AS FLOAT) / c.income AS ratio
    FROM payment_summary ps
    JOIN customers c ON ps.customer_id = c.customer_id
    JOIN loans l ON ps.loan_id = l.loan_id
)

INSERT INTO customer_risk
SELECT *,
    CASE
        WHEN missed_count >= 3 
             AND ratio > 6 
             AND credit_score < 620
        THEN 'HIGH'

        WHEN missed_count >= 1
        THEN 'MEDIUM'

        ELSE 'LOW'
    END AS risk_level
FROM risk_base;

SELECT 
    risk_level,
    COUNT(*) AS total_customers
FROM customer_risk
GROUP BY risk_level;


SELECT 
    loan_id,
    interest_rate,
    interest_rate + 2 AS new_interest_rate
FROM loans;


SELECT
    customer_id,
    income,
    income * 0.9 AS reduced_income
FROM customers;

SELECT
    cr.customer_id,
    cr.loan_id,
    cr.loan_amount,
    c.income * 0.9 AS reduced_income,
    CAST(cr.loan_amount AS FLOAT) / (c.income * 0.9) AS new_ratio
FROM customer_risk cr
JOIN customers c ON cr.customer_id = c.customer_id;


SELECT
    customer_id,
    loan_amount,
    RANK() OVER (ORDER BY loan_amount DESC) AS loan_rank
FROM loans;


SELECT
    l.customer_id,
    p.loan_id,
    p.month_no,
    p.status,
    SUM(CASE WHEN p.status = 'MISSED' THEN 1 ELSE 0 END)
        OVER (PARTITION BY l.customer_id ORDER BY p.month_no)
        AS cumulative_missed
FROM payments p
JOIN loans l ON p.loan_id = l.loan_id;

SELECT
    l.customer_id,
    p.loan_id,
    p.month_no,
    p.status,
    SUM(CASE WHEN p.status = 'MISSED' THEN 1 ELSE 0 END)
        OVER (PARTITION BY l.customer_id ORDER BY p.month_no)
        AS cumulative_missed
FROM payments p
JOIN loans l ON p.loan_id = l.loan_id;

SELECT * FROM customer_risk;








