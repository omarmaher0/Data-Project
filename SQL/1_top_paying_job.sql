/*
This Query to know which job have a big salary & the company name of it.
Note.. I used limit to speed up my query.
*/

SELECT 
    job_id,
    job_title_short,
    job_title,
    job_posted_date,
    job_work_from_home,
    salary_year_avg,
    job_location,
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
LIMIT 25;