﻿#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <iostream>

using namespace std;

// Function to check for CUDA errors and print error messages
void checkCudaError(cudaError_t err, const char* msg) {
	if (err != cudaSuccess) {
		cerr << "Error: " << msg << " - " << cudaGetErrorString(err) << endl;
		exit(EXIT_FAILURE);
	}
}

// Function to print device properties in a readable format
void printDeviceProperties(const cudaDeviceProp& deviceProp, int deviceId) {
		
		// Print the properties of the current CUDA device
		cout << "Here are your Cuda device specifications" << endl;
		cout << "-----------------------------------------" << endl;
		cout << "Device " << deviceId + 1 << ": " << deviceProp.name << endl;
		cout << " Compute Capability: " << deviceProp.major << ", " << deviceProp.minor << endl;
		cout << " Multiprocessors: " << deviceProp.multiProcessorCount << endl;
		cout << " Max Threads per Multiprocessor: " << deviceProp.maxThreadsPerMultiProcessor << endl;
		cout << " Max Threads per Block: " << deviceProp.maxThreadsPerBlock << endl;
		cout << " PCI Bus ID: " << deviceProp.pciBusID << endl;
		cout << " PCI Device ID: " << deviceProp.pciDeviceID << endl;
		cout << " PCI Domain ID: " << deviceProp.pciDomainID << endl;
		cout << " Clock Rate: " << deviceProp.clockRate << " kHz" << endl;
		cout << " Memory Clock Rate: " << deviceProp.memoryClockRate << " MHz" << endl;
		cout << " Memory Bus Width: " << deviceProp.memoryBusWidth << " bits" << endl;
}

// Function to display information about CUDA devices
void displayCudaDeviceInfo(){
	int deviceCount; // Variable to store the number of CUDA devices
	cudaError_t err; // Variable to store CUDA error codes

	// Step 1: Get the number of CUDA devices available
	err = cudaGetDeviceCount(&deviceCount);
	checkCudaError(err, "Failed to get device count");

	// Step 2: If no CUDA devices are available, print an error message and exit
	if (deviceCount == 0) {
		cout << "No CUDA devices found." << endl;
		exit(EXIT_FAILURE);
	}

	// Step 3: Print the total number of CUDA devices
	cout << "Number of CUDA devices: " << deviceCount << "\n" << endl;
	

	// Step 4: Loop through each CUDA device and print its properties
	for (int device = 0; device < deviceCount; device++) {
		cudaDeviceProp deviceProp; // Variable to store the properties of each device

		// Get the properties of the current CUDA device
		err = cudaGetDeviceProperties(&deviceProp, device);
		checkCudaError(err, "Failed to get device properties");

		// Print the properties of the current CUDA device
        printDeviceProperties(deviceProp, device);

	}
}

int main(){
	// Call the Device Info function to display CUDA information
	displayCudaDeviceInfo();

	system("pause");
	
	return 0;
}