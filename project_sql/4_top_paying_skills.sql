SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary


FROM skills_dim

INNER JOIN skills_job_dim ON skills_job_dim.skill_id = skills_dim.skill_id
INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE job_title_short = 'Data Analyst'
AND salary_year_avg is not NULL
GROUP BY 
    skills_dim.skills
ORDER BY avg_salary DESC

LIMIT 5
