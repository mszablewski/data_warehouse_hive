import pandas as pd
import random
from faker import Faker

fake = Faker()

num_students = 100

data = {
    "student_id": range(1, num_students + 1),
    "name": [fake.first_name() for _ in range(num_students)],
    "sur_name": [fake.last_name() for _ in range(num_students)],
    "second_name": [fake.first_name() if random.random() > 0.3 else None for _ in range(num_students)],
    "address": [fake.address().replace("\n", ", ") if random.random() > 0.5 else None for _ in range(num_students)]
}

df = pd.DataFrame(data)

output_file = "data/students_table.csv"
df.to_csv(output_file, index=False)

print(f"CSV file '{output_file}' has been generated.")