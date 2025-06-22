import java.io.*;
import java.util.*;
import java.util.concurrent.*;
public class RideSharingSystem {
    private static final int NUM_WORKERS = 4;
    private static final int NUM_TASKS = 10;
    private static final String OUTPUT_FILE = "output_java.txt";

    public static void main(String[] args) throws InterruptedException, IOException {
        BlockingQueue<Task> taskQueue = new LinkedBlockingQueue<>();
        List<String> results = Collections.synchronizedList(new ArrayList<>());

        // Add tasks to the queue
        for (int i = 1; i <= NUM_TASKS; i++) {
            taskQueue.add(new Task(i));
        }

        ExecutorService executor = Executors.newFixedThreadPool(NUM_WORKERS);
        for (int i = 0; i < NUM_WORKERS; i++) {
            executor.submit(new Worker(taskQueue, results));
        }

        executor.shutdown();
        executor.awaitTermination(1, TimeUnit.MINUTES);

        // Write results to output file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(OUTPUT_FILE))) {
            for (String result : results) {
                writer.write(result);
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing to file: " + e.getMessage());
        }
    }

    static class Task {
        private final int id;

        public Task(int id) {
            this.id = id;
        }

        public int getId() {
            return id;
        }
    }

    static class Worker implements Runnable {
        private final BlockingQueue<Task> taskQueue;
        private final List<String> results;

        public Worker(BlockingQueue<Task> queue, List<String> results) {
            this.taskQueue = queue;
            this.results = results;
        }

        @Override
        public void run() {
            while (true) {
                try {
                    Task task = taskQueue.poll(1, TimeUnit.SECONDS);
                    if (task == null) break;

                    // Simulate work
                    Thread.sleep(1000);
                    String result = "Processed task: " + task.getId() + " by " + Thread.currentThread().getName();
                    results.add(result);

                    System.out.println("INFO: " + result);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    System.err.println("Thread interrupted: " + e.getMessage());
                    break;
                } catch (Exception e) {
                    System.err.println("Exception occurred: " + e.getMessage());
                }
            }
        }
    }
}

