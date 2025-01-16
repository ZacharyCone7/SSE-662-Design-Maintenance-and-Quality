package main

import (
	"fmt"
	"bufio"
	"os"
	)

func main(){


	var(
		choice int 			// Store user input
		description string // Store task description from user input
		flag bool 		  // Exit flag
	)

	// Define struct for holding task fields
	type  task struct{
		ID int
		Description string 
		Status string // Pending/Done
	}

	// Declaring new array of type task
	assignTask []task

	fmt.Println("Welcome to Task Manager")

	for{
		fmt.Println("What would action would you like to perform?")
		fmt.Println("1.) Add Task")
		fmt.Println("2.) List Task")
		fmt.Println("3.) Mark Task")
		fmt.Println("4.) Delete Task")
		fmt.Println("5.) Help/Usage")
		fmt.Println("6.) Exit")

		fmt.Scanln(&choice)

		switch choice{
			case 1: //Add Task
				fmt.Println("You selected Add task, what task do you want added?")
				fmt.Scan(&description)

				// Creating a new task
				newTask := task{
					ID:				len(assignTask) + 1, // Auto-increment ID based on length of array
					Description: 	description, // Add description
					Status: 		"Pending", // Set status
				}

				//Creating and Writing to a file to store tasks
				f, _ := os.Create("Task List.txt")
				defer f.Close()
				newTask, _ = f.WriteString(newTask)

				// Print confirmation message
				fmt.Println("Task \"", newTask.description, "\" added")
				UIpause() // Wait for user input before continuing
			
			case 2: //List Task
				fmt.Println("You selected List task, here are all of your tasks")
				viewTask()
				UIpause()

			case 3: //Mark Task
				fmt.Println("You selected Mark task, which task would you like to change the status of?")
				viewTask()
				fmt.Scan(&choice)

				// Change status of selected task
				assignTask[choice-1].Status = "Done"
				fmt.Println("Task \"", assignTask[choice].ID, "\" marked as completed")
				UIpause()

			case 4: //Delete Task
				fmt.Println("Which task would you like to delete?")
				viewTask()
				fmt.Scan(&choice)

				j:=0 // Used to update task IDs after deletion
				for(_, element:=range assignTask){
					if(element.ID != choice){
						append(element,tempTask[]) // Add task to new slice
						tempTask[j].ID = j+1 // Update task IDs in new slice
						j++ // Increment j
					}
				}
				
				// Print confirmation messsage
				fmt.Println("Task \"", assignTask[choice].ID, "\" is deleted")
				
				// Update assignTask slice
				assignTask = []task{}
				copy(tempTask, assignTask)

			case 6: //Exit
				flag = false

			default: //Help/Usage
				list, _ := os.ReadFile("HowToUse.txt")
				fmt.Println(string(list))
		}

		if(flag == false){
			break // Break out of continuous for loop
		}
	}
}

func UIpause(){
	reader := bufio.NewReader(os.Stdin)
	//Reading input from user before next task prompt
	input, _ := reader.ReadString('\n') 
	if input == "\n" {
		continue
	}
}

func viewTask(){
	//Reads from written file and displays contents
	list, _ := os.ReadFile("Task List.txt")
	fmt.Println(string(list))
}
// Add Task: Allow users to add new tasks with a brief description.
// List Tasks: Display all existing tasks with their status (Pending/Done).
// Mark Task as Done: Enable users to mark a specific task as done by its task number.
// Delete Task: Permit deletion of a task by its task number.
// Help/Usage: Provide a help menu that outlines how to use each command.