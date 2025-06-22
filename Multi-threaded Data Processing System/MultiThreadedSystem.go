// Go Implementation of Ride Sharing Data Processing System
package main

import (
	"fmt"
	"log"
	"os"
	"sync"
	"time"
)

type Task struct {
	ID int
}

func worker(id int, tasks <-chan Task, results *[]string, mu *sync.Mutex, wg *sync.WaitGroup) {
	defer wg.Done()
	for task := range tasks {
		time.Sleep(1 * time.Second) // Simulate processing time
		result := fmt.Sprintf("Processed task: %d by worker-%d", task.ID, id)
		mu.Lock()
		*results = append(*results, result)
		mu.Unlock()
		log.Println("INFO:", result)
	}
}

func main() {
	numWorkers := 4
	numTasks := 10
	taskChan := make(chan Task, numTasks)
	var results []string
	var mu sync.Mutex
	var wg sync.WaitGroup

	// Start workers
	for i := 1; i <= numWorkers; i++ {
		wg.Add(1)
		go worker(i, taskChan, &results, &mu, &wg)
	}

	// Add tasks to the channel
	for i := 1; i <= numTasks; i++ {
		taskChan <- Task{ID: i}
	}
	close(taskChan)

	wg.Wait()

	// Write results to file
	file, err := os.Create("output_go.txt")
	if err != nil {
		log.Fatalf("Error creating file: %v", err)
	}
	defer file.Close()

	for _, result := range results {
		_, err := fmt.Fprintln(file, result)
		if err != nil {
			log.Printf("Error writing to file: %v", err)
		}
	}
}
