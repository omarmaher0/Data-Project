/*
This Query to know top skills based on salary for Data Engineer.
I used ROUND() function to remove decimal values.
*/

SELECT skills,
        --to know the count of each skill (count with job_id using intercept table)
       ROUND(AVG(salary_year_avg),0) as avg_salary
from job_postings_fact
--Doing JOIN to see the skills
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id 
WHERE
    job_title_short = 'Data Engineer' 
    AND salary_year_avg is NOT NULL --remove null values
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 20;