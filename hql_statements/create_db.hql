-- TODO add different storing types
CREATE DATABASE warehouse_project;

-- create grading table 
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;

CREATE TABLE IF NOT EXISTS Grading_tmp(grading_id int, student_id int, teacher_id int,date_id int, group_id int,percentage_of_points float)
LOAD DATA LOCAL INPATH 'Grading.csv'
OVERWRITE INTO TABLE Grading_tmp;

CREATE TABLE IF NOT EXISTS Grading(grading_id int, student_id int, teacher_id int,date_id int, group_id int,percentage_of_points float)
PARTITIONED BY (group_id int)
CLUSTERED BY (student_id) INTO 4 BUCKETS;

INSERT OVERWRITE TABLE Grading 
PARTITION(group_id)

SELECT * FROM Grading_tmp

-- create groups table (external table)
CREATE EXTERNAL TABLE Groups(group_id int, group_name string, starting_year int)
LOCATION 'hdfs:///user/andb44/database/groups';

-- create courses table (external table)
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

-- create dates table (external table)
CREATE EXTERNAL TABLE Dates(date_id int, full_date date, year int, month string, month_no int)
LOCATION 'hdfs:///user/andb44/database/dates';

-- create teachers table (external table)
CREATE EXTERNAL TABLE Teachers(teacher_id int, name string, surnames MAP<string, string>, address string)
ROW FORMAT DELIMETED 
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED '|'
MAP KEYS TERMINATED BY ':'
LOCATION 'hdfs:///user/andb44/database/teachers';

-- create students table (external table)
CREATE EXTERNAL TABLE Students(student_id int, name string, surname string)
LOCATION 'hdfs:///user/andb44/database/students';