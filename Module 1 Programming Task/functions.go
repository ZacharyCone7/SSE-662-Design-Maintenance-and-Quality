package functions

import (
	"bufio"
	"fmt"
	"os"
)

func UIpause(){
	//Reading input from user before next task prompt
	fmt.Println("Press enter to continue")
	bufio.NewReader(os.Stdin).ReadString('\n')
	}
	
func ViewTask(tasks []task) {
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
