create database bank_loan_Project;
use bank_loan_project;

select count(*) from finance_1;
select count(*) from finance_2;

select * from finance_1 limit 39717;
select * from finance_2 limit 39717;

/*
-- KPI List
-- 1. Year wise loan amount
-- 2.Grade-Subgrade wise revolution balance
-- 3.Total Payment For Verified Status Vs Non verified Status
-- 4.State wise Last credit pull Wise Loan Status
-- 5. Home Ownership Vs Last Payment Date Status.

*/

-- KPI 1**YEAR WISE LOAN AMOUNT STATS//

select year(issue_d) as Year_of_issue_d , sum(loan_amnt) as Total_loan_amnt
from finance_1 
group by Year_of_issue_d 
order by Year_of_issue_d
limit 39717;

-- KPI 2**GRADE AND SUBGRADE WISE REVOL_BAL//

select 
grade , sub_grade , sum(revol_bal) as total_revol_bal
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by grade , sub_grade 
order by grade , sub_grade
limit 39717;


-- KPI 3**TOTAL PAYMENT FOR VERIFIED AND NON-VERIFIED STATUS//

select verification_status ,
concat("$",format(round(sum(total_pymnt)/1000000,2),2),"M") as total_payment

from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by verification_status
limit 39717; 

select * from finance_1;

-- KPI 4**STATE WISE AND LAST_CREDIT_PULL_D WISE LOAN STATUS//

select addr_State, last_Credit_pull_D , loan_Status
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)

group by addr_State , last_Credit_pull_D, loan_Status
order by last_Credit_pull_D
limit 39717;

-- KPI 5**HOMEOWNERSHIP VS LAST PAYMENT DATE STATS//

SELECT 
    home_ownership, 
    last_pymnt_d,
    CONCAT('$', FORMAT(ROUND(SUM(last_pymnt_amnt) / 1000, 2), 2), 'K') AS total_amount
FROM
    finance_1 
INNER JOIN 
    finance_2 ON finance_1.id = finance_2.id
GROUP BY 
    home_ownership, last_pymnt_d
ORDER BY
    last_pymnt_d DESC, home_ownership DESC
limit 39717;