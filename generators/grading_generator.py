import csv
import random

# Sample data for student, course, teacher, group IDs
students = [i for i in range(1, 101)]
courses = [i for i in range(1, 51)]
teachers = [i for i in range(1, 51)]
groups = [i for i in range(1, 31)]
dates = [i for i in range(1, 733)]

def generate_grading_data(num_records):
    for _ in range(num_records):
        student_id = random.choice(students)
        course_id = random.choice(courses)
        teacher_id = random.choice(teachers)
        group_id = random.choice(groups)
        date_id = random.choice(dates)
        
        grade1 = random.randint(50, 100)
        grade2 = random.choice([random.randint(50, 100), None])
        grade = [grade1, grade2]
        
        time_percentage_used = round(random.uniform(0, 100), 2)
        percentage_of_points = round(random.uniform(0, 100), 2)

        yield {
            'student_id': student_id,
            'course_id': course_id,
            'teacher_id': teacher_id,
            'date_id': date_id,
            'group_id': group_id,
            'grade': grade,
            'time_percentage_used': time_percentage_used,
            'percentage_of_points': percentage_of_points
        }

def write_grading_to_csv(filename, num_records):
    fieldnames = [
        'student_id', 'course_id', 'teacher_id', 'date_id', 'group_id', 'grade', 
        'time_percentage_used', 'percentage_of_points'
    ]
    
    with open(filename, mode='w', newline='') as file:
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        
        for record in generate_grading_data(num_records):
            record['grade'] = str(record['grade'])
            writer.writerow(record)

write_grading_to_csv('data/grading_data.csv', 100)