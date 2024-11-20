import pandas as pd
from faker import Faker

fake = Faker()

num_teachers = 50

data = {
    "teacher_id": range(1, num_teachers + 1),
    "name": [fake.first_name() for _ in range(num_teachers)],
    "surname": [fake.last_name() for _ in range(num_teachers)],
    "address": [fake.address().replace("\n", ", ") for _ in range(num_teachers)]  # format address as a single line
}

df = pd.DataFrame(data)

output_file = "data/teachers_table.csv"
df.to_csv(output_file, index=False)

print(f"CSV file '{output_file}' has been generated.")