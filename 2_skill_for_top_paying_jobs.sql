/*
This Query to know which skill have a big salary on jobs.
I used JOINS (LEFT to know the company name) 
& (INNER to know the skills)
CTEs, I used to 
    -simplify complex queries.
    -avoid repetition of the same subquery within a larger query.
*/

WITH skills_top_paying as (

    SELECT 
        job_id,
        job_title_short,
        job_title,
        job_posted_date,
        job_work_from_home,
        salary_year_avg,
        job_country,
        -- company name from different table
        name as company_name
    FROM 
        job_postings_fact
    -- Doing JOIN to can see which company have a big salary
    LEFT JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
    WHERE 
        salary_year_avg is not NULL --removing null values
    ORDER BY 
        salary_year_avg DESC
    LIMIT 25
)
SELECT skills_top_paying.*,
       skills
from skills_top_paying
--Doing JOIN to see the skills
INNER JOIN skills_job_dim on skills_top_paying.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id 