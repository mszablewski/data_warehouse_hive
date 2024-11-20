CREATE DATADASE warehouse_project;

-- create grading table 
CREATE TABLE IF NOT EXISTS grading(grading_id int, student_id int, teacher_id int,date_id int, group_id int,percentage_of_points float);

-- load data into grading table (internal table)
LOAD DATA LOCAL INPATH 'Grading.csv'
OVERWRITE INTO TABLE Grading

-- create group table (external table)
CREATE EXTERNAL TABLE Groups(group_id int, group_name string, starting_year int)
LOCATION 'hdfs:///user/andb44/database/groups';

-- create course table (external table)
CREATE TABLE IF NOT EXISTS Courses_tmp(course_id int, name_of_course string, course_year string)
LOAD DATA LOCAL INPATH 'courses.csv'
OVERWRITE INTO TABLE Courses_tmp

CREATE EXTERNAL TABLE Courses(course_id int, name_of_course string, course_year string)
PARTITIONED BY (course_year string)
LOCATION 'hdfs:///user/andb44/database/courses';

-- load partitioned data to courses table
INSERT INTO Courses
SELECT * FROM Courses_tmp WHERE course_year = "first year" PARTITION (course_year="first year");

INSERT INTO Courses
SELECT * FROM Courses_tmp WHERE course_year = "second year" PARTITION (course_year="second year");

INSERT INTO Courses
SELECT * FROM Courses_tmp WHERE course_year = "third year" PARTITION (course_year="third year");

INSERT INTO Courses
SELECT * FROM Courses_tmp WHERE course_year = "fourth year" PARTITION (course_year="fourth year");

-- create date table (external table)
CREATE EXTERNAL TABLE Dates(date_id int, full_date date, year int, month string, month_no int)
LOCATION 'hdfs:///user/andb44/database/dates';