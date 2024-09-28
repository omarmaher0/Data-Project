/*
This Query to know top demand skills for specific job (Data Scientist)
-You can change in Query to know in different job (WHERE job_title_short = 'job').
*/

SELECT skills,
        --to know the count of each skill (count with job_id using intercept table)
       COUNT(skills_job_dim.job_id) as demand_skills
from job_postings_fact
--Doing JOIN to see the skills
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id 
WHERE
    job_title_short = 'Data Scientist' 
GROUP BY
    skills
ORDER BY
    demand_skills DESC
LIMIT 20;