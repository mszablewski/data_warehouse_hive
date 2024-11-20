import pandas as pd
from datetime import datetime, timedelta

start_date = datetime(2023, 1, 1)
end_date = datetime(2024, 12, 31)

date_list = [start_date + timedelta(days=x) for x in range((end_date - start_date).days + 1)]

data = {
    "data_id": range(1, len(date_list) + 1),
    "day": [date.day for date in date_list],
    "year": [date.year for date in date_list],
    "month": [date.strftime('%B') for date in date_list],
    "month_number": [date.month for date in date_list]
}

df = pd.DataFrame(data)

output_file = "data/date_table.csv"
df.to_csv(output_file, index=False)

print(f"CSV file '{output_file}' has been generated.")