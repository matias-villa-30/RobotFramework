import csv
import random  # <--- Step 1: Import random

age_groups = ['Adult', 'Child']
heart_rates = [60, 80, 110, 130]
temps = [36.5, 37.2, 37.8, 38.5]
stds = [5, 10, 15, 20]

# Step 2: Create a list to hold all your data rows
data_rows = []

for age in age_groups:
    for hr in heart_rates:
        hr_tag = 'Low' if hr < 100 else 'High'
        for t in temps:
            for s in stds:
                current_tags = f"{age},{hr_tag}"
                test_name = f"Test-{age}-HR{hr}-T{t}-S{s}"
                # Append each row to our list instead of writing it yet
                data_rows.append([test_name, age, hr, t, s, current_tags])

# Step 3: SHUFFLE the list!
random.shuffle(data_rows)

with open('fluke.csv', 'w', newline='') as f:
    writer = csv.writer(f, delimiter=';')
    
    # Write the header first
    writer.writerow([
        '*** Test Cases ***',
        '${age_group}',
        '${Hear_Rate}',
        '${body_temp}',
        '${std_deviation}',
        '[Tags]'
    ])
    
    # Step 4: Write the shuffled rows
    writer.writerows(data_rows)

print("fluke.csv generated in RANDOM order.")
