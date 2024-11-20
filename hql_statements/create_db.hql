CREATE DATADASE warehouse_project;

CREATE TABLE IF NOT EXISTS grading(Number grading_id, Number student_id, Number teacher_id, Number date_id, Number group_id, Number percentage_of_points);

LOAD DATA LOCAL INPATH 'Grading.csv'
OVERWRITE INTO TABLE grading