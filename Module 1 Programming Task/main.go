package main

import (
	"bufio"
	"fmt"
	"os"
	"functions"
	)

	// Define struct for holding task fields
	type task struct{
		ID int
		Description string 
		Status string // Pending/Done
	}

	// Define colors
	const (
		Reset = "\033[0m"
		Red   = "\033[31m"
		Green = "\033[32m"
	)

func main() {
	var (
		choice      int    // Store user input
		description string // Store task description from user input
		flag        bool   = true
	)
	// Declaring new array of type task
	var assignTask []task

	// Print welcome message
	fmt.Println("Welcome to Task Manager")

	for{
		fmt.Println("What would action would you like to perform?")
		fmt.Println("1.) Add Task")
		fmt.Println("2.) List Task")
		fmt.Println("3.) Mark Task")
		fmt.Println("4.) Delete Task")
		fmt.Println("5.) Help/Usage")
		fmt.Println("6.) Exit")

		fmt.Scanln(&choice) // 

		switch choice{
			case 1: //Add Task
			reader := bufio.NewReader(os.Stdin)
				fmt.Println("You selected Add task, what task do you want added?")
			input, _ := reader.ReadString('\n')
			description = input[:len(input)-1]

				// Creating a new task
				newTask := task{
					ID:				len(assignTask) + 1, // Auto-increment ID based on length of array
					Description: 	description, // Add description
					Status: 		"Pending", // Set status
				}
			// Add task to array
			assignTask = append(assignTask, newTask)

				// Print confirmation message
				fmt.Println("Task \"", newTask.description, "\" added")
				functions.UIpause() // Wait for user input before continuing
			
			case 2: //List Task
				fmt.Println("You selected List task, here are all of your tasks")
			if assignTask == nil {
				fmt.Println("No tasks found")
			} else {
				functions.ViewTask(assignTask)
				}
				functions.UIpause()

			case 3: //Mark Task
				fmt.Println("You selected Mark task, which task would you like to change the status of?")
			functions.ViewTask(assignTask)
				fmt.Scan(&choice)

			if choice < 1 || choice > len(assignTask) {
				fmt.Println("Invalid task ID.")
				return
			}
				// Change status of selected task
				assignTask[choice-1].Status = "Done"
			fmt.Println("Task \"", assignTask[choice-1].ID, "\" marked as completed")
				functions.UIpause()

			case 4: //Delete Task
			if len(assignTask) == 0 {
				fmt.Println("No tasks found")
				break
			}
				fmt.Println("Which task would you like to delete?")
			functions.ViewTask(assignTask)
				fmt.Scan(&choice)

				// Check if ID is valid
				if choice < 1 || choice > len(assignTask) {
					fmt.Println("Invalid task ID.")
					functions.UIpause()
					break // Exit the case block
				}

			assignTask = append(assignTask[:choice-1], assignTask[choice:]...) // Remove task from array
			for i := range assignTask {
				assignTask[i].ID = i + 1
					}
				
				// Print confirmation messsage
			fmt.Println("Task \"", choice, "\" is deleted")
				

			case 6: //Exit
				flag = false

			default: //Help/Usage
			list, err := os.ReadFile("HowToUse.txt")
			if err != nil {
				fmt.Println("Help file not found")
			} else {
				fmt.Println(string(list))
			}
		}

		if !flag {
			break // Break out of continuous for loop
		}
	}
}