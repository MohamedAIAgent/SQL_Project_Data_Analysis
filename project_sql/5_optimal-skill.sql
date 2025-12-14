WITH skills_demand AS(
    SELECT 
        skills_dim.skill_id,
        skills,
        COUNT(*) AS skill_count


    FROM skills_dim

    INNER JOIN skills_job_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg is not NULL
    AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills,
        skills_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary


    FROM skills_dim

    INNER JOIN skills_job_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg is not NULL
    AND job_work_from_home = TRUE
    GROUP BY 
       skills_dim.skill_id
)    

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skill_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON average_salary.skill_id = skills_demand.skill_id

ORDER BY 
    skill_count DESC,
    avg_salary DESC

LIMIT 25    