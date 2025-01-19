# SSE-662-Design-Maintenance-and-Quality
# Go Task Application

This is a command-line project written in Go that allows a user to manage tasks. This application allows the user to add, 
view, manage, and delete tasks. It uses basic array manipulation for data storage and offers an easy-to-use 
interface for managing your task list from within the executable.

## Features
* Add tasks: Add a task with a simple description
* View tasks: Displays all tasks with their descriptions
* Update tasks: Updates task with colored pending or done tag
* Delete tasks: Remove tasks from your list
* Data storage: Tasks are saved and stored in app 
* When a task is marked done, it turns green. When it is pending, it turns red

## Installation
Build Task-App from source:

### Prerequisites

Install the latest version of Go. You can download and install it from the official [Go website](https://go.dev/).

1. Clone the repository

Download the project files from GitHub:
```
git clone https://github.com/ZacharyCone7/SSE-662-Design-Maintenance-and-Quality/tree/main
```
2. Navigate to repository location
```
cd "Module 1 Programming Task"
```

3. Build the executable
```
go build -o Taskapp.exe
```
4. Verify the executable is located in your folder path
```
\SSE-662-Design-Maintenance-and-Quality\Module 1 Programming Task\Taskapp.exe
```
5. Open executable application
```
*Double click the Taskapp*
```
If installed correctly, the user inteface will be displayed

## Usage

### Available Commands
1. *Add Task* Add a new task to the list
```
Press option 1
```
2. *List Tasks* View all tasks
```
Press option 2
```
3. *Mark task* Mark task done
```
Press option 3
```
4. *Delete task* Delete task by ID
```
Press option 4
```
5. *Help/Usage* Displays help screen to aid user
```
Press option 5
```