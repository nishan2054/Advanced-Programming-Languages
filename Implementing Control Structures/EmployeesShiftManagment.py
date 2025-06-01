import random
from collections import defaultdict

DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
SHIFTS = ["Morning", "Afternoon", "Evening"]
MAX_DAYS = 5
MIN_EMPLOYEES_PER_SHIFT = 2

# Sample input
employees = {
    "John": ["Morning"] * 7,
    "Bishal": ["Afternoon"] * 7,
    "Nishan": ["Evening"] * 7,
    "Manisha": ["Morning"] * 7,
    "Sunil": ["Afternoon"] * 7,
    "Sabrina": ["Evening"] * 7
}

# Track scheduled shifts
schedule = {day: {shift: [] for shift in SHIFTS} for day in DAYS}
employee_days_worked = defaultdict(int)

def assign_shift(day, shift, employee):
    if employee_days_worked[employee] < MAX_DAYS:
        if employee not in schedule[day][shift]:
            schedule[day][shift].append(employee)
            employee_days_worked[employee] += 1
            return True
    return False

# Scheduling
for day_idx, day in enumerate(DAYS):
    for employee, prefs in employees.items():
        if employee_days_worked[employee] >= MAX_DAYS:
            continue
        preferred_shift = prefs[day_idx]
        if len(schedule[day][preferred_shift]) < MIN_EMPLOYEES_PER_SHIFT:
            assigned = assign_shift(day, preferred_shift, employee)
            if not assigned:
                # Try another shift today
                for alt_shift in SHIFTS:
                    if alt_shift != preferred_shift:
                        if assign_shift(day, alt_shift, employee):
                            break
                else:
                    # Try next day
                    if day_idx + 1 < len(DAYS):
                        assign_shift(DAYS[day_idx + 1], preferred_shift, employee)

# Backfill if any shift has fewer than 2 employees
for day in DAYS:
    for shift in SHIFTS:
        while len(schedule[day][shift]) < MIN_EMPLOYEES_PER_SHIFT:
            candidates = [e for e in employees if employee_days_worked[e] < MAX_DAYS]
            if not candidates:
                break
            chosen = random.choice(candidates)
            assign_shift(day, shift, chosen)

# Output
print("\n--- Print Final Weekly Schedule ---")
for day in DAYS:
    print(f"\n{day}:")
    for shift in SHIFTS:
        assigned = ", ".join(schedule[day][shift]) or "No employees"
        print(f"  {shift}: {assigned}")