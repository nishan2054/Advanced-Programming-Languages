package takeItAway;

import java.util.*;

public class EmployeeScheduler {

    private static final String[] DAYS = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
    private static final String[] SHIFTS = {"Morning", "Afternoon", "Evening"};
    private static final int MAX_DAYS = 5;
    private static final int MIN_EMPLOYEES_PER_SHIFT = 2;

    private static Map<String, String[]> preferences = new HashMap<>();
    private static Map<String, Integer> daysWorked = new HashMap<>();
    private static Map<String, Map<String, List<String>>> schedule = new LinkedHashMap<>();

    public static void main(String[] args) {
        // Sample input
        preferences.put("John", fillPrefs("Morning"));
        preferences.put("Bishal", fillPrefs("Afternoon"));
        preferences.put("Nishan", fillPrefs("Evening"));
        preferences.put("Manisha", fillPrefs("Morning"));
        preferences.put("Sunil", fillPrefs("Afternoon"));
        preferences.put("Sabrina", fillPrefs("Evening"));

        for (String emp : preferences.keySet()) {
            daysWorked.put(emp, 0);
        }

        for (String day : DAYS) {
            Map<String, List<String>> dayShifts = new LinkedHashMap<>();
            for (String shift : SHIFTS) {
                dayShifts.put(shift, new ArrayList<>());
            }
            schedule.put(day, dayShifts);
        }

        Random rand = new Random();

        for (int i = 0; i < DAYS.length; i++) {
            String day = DAYS[i];
            for (String emp : preferences.keySet()) {
                if (daysWorked.get(emp) >= MAX_DAYS) continue;

                String prefShift = preferences.get(emp)[i];
                List<String> currentShift = schedule.get(day).get(prefShift);
                if (currentShift.size() < MIN_EMPLOYEES_PER_SHIFT) {
                    if (!currentShift.contains(emp)) {
                        currentShift.add(emp);
                        daysWorked.put(emp, daysWorked.get(emp) + 1);
                        continue;
                    }
                }

                // Try alternative shifts today
                boolean assigned = false;
                for (String altShift : SHIFTS) {
                    if (!altShift.equals(prefShift) && schedule.get(day).get(altShift).size() < MIN_EMPLOYEES_PER_SHIFT) {
                        schedule.get(day).get(altShift).add(emp);
                        daysWorked.put(emp, daysWorked.get(emp) + 1);
                        assigned = true;
                        break;
                    }
                }

                // Try next day
                if (!assigned && i < DAYS.length - 1) {
                    String nextDay = DAYS[i + 1];
                    String nextPref = preferences.get(emp)[i + 1];
                    if (schedule.get(nextDay).get(nextPref).size() < MIN_EMPLOYEES_PER_SHIFT) {
                        schedule.get(nextDay).get(nextPref).add(emp);
                        daysWorked.put(emp, daysWorked.get(emp) + 1);
                    }
                }
            }
        }

        // Backfill under-staffed shifts
        for (String day : DAYS) {
            for (String shift : SHIFTS) {
                List<String> workers = schedule.get(day).get(shift);
                while (workers.size() < MIN_EMPLOYEES_PER_SHIFT) {
                    List<String> candidates = new ArrayList<>();
                    for (String emp : preferences.keySet()) {
                        if (daysWorked.get(emp) < MAX_DAYS && !workers.contains(emp)) {
                            candidates.add(emp);
                        }
                    }
                    if (candidates.isEmpty()) break;
                    String selected = candidates.get(rand.nextInt(candidates.size()));
                    workers.add(selected);
                    daysWorked.put(selected, daysWorked.get(selected) + 1);
                }
            }
        }

        // Output
        System.out.println("\n--- Print Final Weekly Schedule ---");
        for (String day : DAYS) {
            System.out.println("\n" + day + ":");
            for (String shift : SHIFTS) {
                List<String> workers = schedule.get(day).get(shift);
                System.out.println("  " + shift + ": " + String.join(", ", workers));
            }
        }
    }

   private static String[] fillPrefs(String shift) {
        String[] prefs = new String[7];
        Arrays.fill(prefs, shift);
        return prefs;
    }
}

