-- CREATE DATABASE warehouse_project_44_29;
-- USE warehouse_project_44_29;

-- create grading table 
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;

CREATE TABLE IF NOT EXISTS Grading_tmp(
    student_id int, 
    course_id int, 
    teacher_id int,
    date_id int, 
    percentage_of_points ARRAY<float>, 
    group_id int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '|'
STORED AS TEXTFILE;

CREATE TABLE IF NOT EXISTS Grading(
    student_id int, 
    course_id int, 
    teacher_id int, 
    date_id int, 
    percentage_of_points ARRAY<float>)
PARTITIONED BY (group_id int)
CLUSTERED BY (student_id) INTO 4 BUCKETS
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
COLLECTION ITEMS TERMINATED BY '|'
STORED AS ORC;

-- create groups table (external table)
CREATE EXTERNAL TABLE Groups(group_id int, group_name string, starting_year int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE
LOCATION 'hdfs:///user/andb44/database/groups/';

-- create courses table (external table)
CREATE EXTERNAL TABLE Courses(course_id int, name_of_course string)
PARTITIONED BY (course_year string)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE
LOCATION 'hdfs:///user/andb44/database/courses/';

-- create dates table (external table)
CREATE EXTERNAL TABLE Dates(date_id int, full_date date, year int, month string, month_no int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///user/andb44/database/date/';

-- create teachers table (external table)
CREATE EXTERNAL TABLE Teachers(teacher_id int, name string, surnames MAP<string, string>, address string)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY ':'
STORED AS TEXTFILE
LOCATION 'hdfs:///user/andb44/database/teachers/';

-- create students table (external table)
CREATE TABLE IF NOT EXISTS Students_tmp(
  student_id INT, 
  name STRING, 
  surname STRING
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

CREATE EXTERNAL TABLE Students(student_id int, name string, surname string)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS PARQUET
LOCATION 'hdfs:///user/andb44/database/students/';