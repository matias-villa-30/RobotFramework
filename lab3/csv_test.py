import csv

age_groups = ['Adult', 'Child']
heart_rates = [60, 80, 110, 130]
temps = [36.5, 37.2, 37.8, 38.5]
stds = [5, 10, 15, 20]

with open('fluke.csv', 'w', newline='') as f:
    writer = csv.writer(f, delimiter=';')
    
    # CRITICAL: Use '[Tags]' instead of '${tag_list}'
    # This allows DataDriver to 'see' the tags for filtering
    writer.writerow([
        '*** Test Cases ***',
        '${age_group}',
        '${Hear_Rate}',
        '${body_temp}',
        '${std_deviation}',
        '[Tags]'
    ])
    
    for age in age_groups:
        for hr in heart_rates:
            hr_tag = 'Low' if hr < 100 else 'High'
            
            for t in temps:
                for s in stds:
                    # Comma-separated tags: e.g., "Adult,Low"
                    current_tags = f"{age},{hr_tag}"
                    
                    test_name = f"Test-{age}-HR{hr}-T{t}-S{s}"
                    writer.writerow([test_name, age, hr, t, s, current_tags])

print("fluke.csv generated with magic [Tags] header.")
