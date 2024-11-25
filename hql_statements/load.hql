USE warehouse_project_44_29;

-- load data into temp table for grading table
LOAD DATA LOCAL INPATH 'Grading.csv'
OVERWRITE INTO TABLE Grading_tmp;

-- load data from temp table into grading table
INSERT OVERWRITE TABLE Grading 
PARTITION(group_id)
SELECT * FROM Grading_tmp;

-- load partitioned data to courses table
LOAD DATA LOCAL INPATH 'Courses1.csv'
INTO TABLE Courses PARTITION (course_year="first year");

LOAD DATA LOCAL INPATH 'Courses2.csv'
INTO TABLE Courses PARTITION (course_year="second year");

LOAD DATA LOCAL INPATH 'Courses3.csv'
INTO TABLE Courses PARTITION (course_year="third year");

LOAD DATA LOCAL INPATH 'Courses4.csv'
INTO TABLE Courses PARTITION (course_year="fourth year");

-- load data into temp table for students table
LOAD DATA LOCAL INPATH 'Students.csv'
OVERWRITE INTO TABLE Students_tmp;

-- load data from temp table into students table
INSERT INTO Students SELECT * FROM Students_tmp;