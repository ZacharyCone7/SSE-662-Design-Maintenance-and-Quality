package functions

import (
	"bufio"
	"fmt"
	"os"
)

// Define colors
const (
	Reset = "\033[0m"
	Red   = "\033[31m"
	Green = "\033[32m"
)

// Define struct for holding task fields
type Task struct {
	ID          int
	Description string
	Status      string // Pending/Done
}

func UIpause() {
	//Reading input from user before next task prompt
	fmt.Println("Press enter to continue")
	bufio.NewReader(os.Stdin).ReadString('\n')
}

func ViewTask(tasks []Task) {
	color := Reset
	for i, element := range tasks { // Iterate over the tasks
		if element.Status == "Pending" { // If the task is pending
			color = Red // Set the color to red
		} else if element.Status == "Done" { // If the task is done
			color = Green // Set the color to green
		}
		fmt.Printf("%s%d.    %s%s   	%s%s\n", color, i+1, Reset, element.Status, Reset, element.Description) // Print the task
	}
}
