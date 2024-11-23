-- USE warehouse_project_44_29;

-- NOTES
-- As we used dates from the 2020/2021 query for last month/ year results in empty response.
-- Change last month for September 2020

-- For every grading fact there is a possibility for more than one percentage_points value as 
-- multiple attempts are possible for every grade obtained. In such cases the last percentage_points are taken into 
-- considerations (if not specified otherwise)


-- 1. Average grading for each group last month
-- SELECT group_id, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
-- FROM Grading
-- JOIN Dates ON Grading.date_id = Dates.date_id
-- WHERE month_no = MONTH(ADD_MONTHS(CURRENT_DATE, -1))
--   AND year = YEAR(ADD_MONTHS(CURRENT_DATE, -1))
-- GROUP BY group_id;

SELECT group_id, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
FROM Grading
JOIN Dates ON Grading.date_id = Dates.date_id
WHERE month_no = 9
  AND year = 2020
GROUP BY group_id;


-- 2. Top 5 students with the best average points
SELECT student_id, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
FROM Grading
GROUP BY student_id
ORDER BY avg_percentage_of_points DESC
LIMIT 5;


-- 3. Bottom 10 students with the lowest average points
SELECT student_id, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
FROM Grading
GROUP BY student_id
ORDER BY avg_percentage_of_points ASC
LIMIT 10;


-- 4. Teachers with the best average points for students last month
SELECT teacher_id, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
FROM Grading
JOIN Dates ON Grading.date_id = Dates.date_id
WHERE month_no = 9
  AND year = 2020
GROUP BY teacher_id
ORDER BY avg_percentage_of_points DESC
LIMIT 5;

-- 5. Average performance by month for selected student
SELECT student_id, year, month_no, month, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
FROM Grading
JOIN Dates ON Grading.date_id = Dates.date_id
WHERE student_id = 43
GROUP BY student_id, year, month_no, month;


-- 6. Group with the best average points
SELECT group_id, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
FROM Grading
GROUP BY group_id
ORDER BY avg_percentage_of_points DESC
LIMIT 1;


-- 7. Average percentage points for each academic year
SELECT course_year, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
FROM Grading
JOIN Courses ON Grading.course_id = Courses.course_id
GROUP BY course_year;


-- 8. Distribution of students across academic years
SELECT course_year, COUNT(DISTINCT student_id) AS student_count
FROM Grading
JOIN Courses ON Grading.course_id = Courses.course_id
GROUP BY course_year;


-- 9. Average grading of groups over the last year (monthly trend)
SELECT group_id, year, month_no, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_percentage_of_points
FROM Grading
JOIN Dates ON Grading.date_id = Dates.date_id
WHERE year = 2020
GROUP BY group_id, year, month_no
ORDER BY group_id, year, month_no;


-- 10. Teachers ordered by the most courses taught and their students average performance
SELECT teacher_id, COUNT(DISTINCT course_id) AS courses_taught, AVG(percentage_of_points[SIZE(percentage_of_points) - 1]) AS avg_student_performance
FROM Grading
GROUP BY teacher_id
ORDER BY courses_taught DESC, avg_student_performance DESC;