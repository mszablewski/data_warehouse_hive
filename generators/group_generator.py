import pandas as pd

group_names = [
    "Alpha Scholars", "Bright Minds", "Academic Explorers", "Knowledge Seekers", 
    "Learning Legends", "Future Innovators", "Visionary Thinkers", "Creative Geniuses", 
    "Stellar Learners", "Rising Stars", "Discovery Pioneers", "Logic Builders", 
    "Science Enthusiasts", "Humanities Champs", "Language Masters", "History Buffs", 
    "Math Wizards", "Artistic Minds", "Tech Titans", "Biology Bees", "Chemistry Crew", 
    "Physics Force", "Geography Gurus", "Literature Lovers", "Debate Champions", 
    "Ethical Leaders", "Business Builders", "Engineering Elites", "Environmental Advocates", 
    "Music Maestros"
]

num_groups = 30

data = {
    "group_id": range(1, num_groups + 1),
    "group_name": group_names
}

df = pd.DataFrame(data)

output_file = "data/group_table.csv"
df.to_csv(output_file, index=False)

print(f"CSV file '{output_file}' has been generated.")