# Device Properties Retrieval Program

### Description:
This program retrieves and displays the properties of all available CUDA devices
on the system. It handles scenarios with 0, 1, or multiple devices and provides additional
information about the device such as name, compute capability, number of multiprocessors, and more.

### Prerequisites:
1. CUDA Toolkit installed
2. A CUDA-capable GPU
3. A compatible C++ compiler

### Steps to Compile and Run:

**Using the Command Line:**
1. Open a terminal or command prompt.
2. Navigate to the directory containing `device_properties.cu`.
3. Compile the program using the following command:
```
nvcc device_properties.cu -o device_properties
```
- This will create an executable file named `device_properties`.
4. Run the program
```
./device_properties.exe
```

**Using Visual Studio:**
1. Open the project containing the `device_properties.cu` file in Visual Studio
2. Ensure the file is included in your project.
3. Build the project
   -From the menu, select **Build** -> **Build Solution**
   -The executable will be generated in the project's `Debug` or `Releasae` folder.
4. Run the porgram:
   -From the menu, select **Debug** -> **Start Without Debugging**.

#### Notes:
-If no CUDA devices are found, the program will display: "No CUDA devices found."
-For multiple devices, the program iterates through and displays properties for each device.
