/*
This Query to know Most skills to learn (high demand & high paying) for Data Engineering
I used CTEs and combine them to have that beautiful output.
*/
WITH skills_demand AS (
        SELECT 
            skills_dim.skills,
            skills_dim.skill_id,
            COUNT (skills_job_dim.job_id) as demand_skills 
    from job_postings_fact
    --INNER JOIN to take the intercept between them (skills)
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Engineer'
        AND salary_year_avg is not null 
    GROUP BY
        skills_dim.skill_id
),
average_salary as(
        SELECT 
            skills_job_dim.skill_id,
            ROUND(AVG(salary_year_avg),0) as avg_salary
    from job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Engineer' 
        AND salary_year_avg is not null 
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_skills,
    avg_salary
FROM
    skills_demand
--combine them 
INNER JOIN average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_skills > 20 -- to know highest skills with highest salary
ORDER BY
    avg_salary DESC,
    demand_skills DESC

