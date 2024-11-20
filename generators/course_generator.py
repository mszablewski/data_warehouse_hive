import pandas as pd
import random
from faker import Faker

fake = Faker()

num_courses = 50

course_names = [
    "Mathematics", "Physics", "Chemistry", "Biology", "History",
    "Geography", "Computer Science", "Literature", "Philosophy", "Economics",
    "Engineering", "Medicine", "Arts", "Music", "Law",
    "Business", "Psychology", "Sociology", "Education", "Political Science"
]

data = {
    "course_id": range(1, num_courses + 1),
    "course_year": [random.choice(range(2000, 2025)) for _ in range(num_courses)],
    "course_name": [random.choice(course_names) for _ in range(num_courses)]
}

# Create DataFrame
df = pd.DataFrame(data)

# Save to CSV
output_file = "data/course_table.csv"
df.to_csv(output_file, index=False)

print(f"CSV file '{output_file}' has been generated.")