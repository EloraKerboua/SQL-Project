USE bootcamps;

/* Ranking for each course */
SELECT DISTINCT course
FROM all_bootcamps;

SELECT ranking, bootcamp_name FROM all_bootcamps
WHERE course = 'Data Analytics';

SELECT ranking, bootcamp_name FROM all_bootcamps
WHERE course = 'Cyber Security';

SELECT ranking, bootcamp_name FROM all_bootcamps
WHERE course = 'Coding';

SELECT ranking, bootcamp_name FROM all_bootcamps
WHERE course = 'Web Design';



/* Check the position of ironhack in the rankings for  Data Analytics, Coding, Cyber Security and Web Design Bootcamps */

WITH 
UniqueCourses AS (
    SELECT DISTINCT course
    FROM all_bootcamps
),
IronhackRanking AS (
    SELECT course, ranking
    FROM all_bootcamps
    WHERE bootcamp_name = 'Ironhack'
)

SELECT
    ac.course,
    ir.ranking
FROM
    UniqueCourses ac
LEFT JOIN
    IronhackRanking ir
ON
    ac.course = ir.course;


/* Cyber Security programs in top ranking + ironhack */
SELECT school, AVG(overallScore) AS averageScore
FROM reviews
WHERE LOWER(program) LIKE '%cyber%security%'
GROUP BY school
ORDER BY averageScore ASC;

/* Overall Score by school and program*/
SELECT school, program, ROUND(AVG(overallScore),2) AS averageScore
FROM reviews
WHERE LOWER(program) LIKE '%cyber%security%' 
GROUP BY school, program
ORDER BY averageScore ASC;

/* Verified comments for ironhack after 2019 */
SELECT 
    COUNT(CASE WHEN name != 'Anonymous' THEN id END) AS non_anonymous_reviews
FROM 
    reviews
WHERE 
    LOWER(program) LIKE '%cyber%security%'
    AND createdAt > '2019-12-31'
    AND school = 'ironhack';

/* Bootcamp Locations */
SELECT 
    city_name,
    id,
    country_name,
    COUNT(*) AS counts
FROM 
    locations
WHERE 
    school = 'ironhack'
GROUP BY 
    city_name, id, country_name;

/* Cybersecurity Badges */
SELECT
    COUNT(DISTINCT name) AS total_unique_badges,
    SUM(CASE WHEN school = 'ironhack' THEN 1 ELSE 0 END) AS ironhack_badges
FROM
    badges;
    
/* Missing badges for ironhack */
SELECT DISTINCT name
FROM badges
WHERE school != 'ironhack'
AND name NOT IN (
    SELECT DISTINCT name
    FROM badges
    WHERE school = 'ironhack'
);

/* Analyzing the prices */
SELECT
    'All Schools' AS school,
    COUNT(*) AS total_records,
    AVG(priceMin) AS avg_priceMin,
    AVG(priceMax) AS avg_priceMax,
    MIN(priceMin) AS min_priceMin,
    MIN(priceMax) AS min_priceMax,
    MAX(priceMin) AS max_priceMin,
    MAX(priceMax) AS max_priceMax
FROM
    prices;






