
#include "cuda_runtime.h"
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

int main() {
	int deviceCount; // Variable to store the number of CUDA devices
	cudaError_t err; // Variable to store CUDA error codes

	// Get the number of CUDA devices available
	err = cudaGetDeviceCount(&deviceCount);
	// Check for errors
	checkCudaError(err, "Failed to get device count");

	// If no CUDA devices are available, print an error message
	if (deviceCount == 0) {
		cout << "No CUDA devices found." << endl;
		return 0;
	}

	// Print the total number of CUDA devices
	cout << "Number of CUDA devices: " << deviceCount << "\n" << endl;
	

	// Loop through each CUDA device and print its properties
	for (int device = 0; device < deviceCount; device++) {
		cudaDeviceProp deviceProp; // Variable to store device properties

		// Get the properties of the current CUDA device
		err = cudaGetDeviceProperties(&deviceProp, device);
		// Check for errors
		checkCudaError(err, "Failed to get device properties");

		// Print the properties of the current CUDA device
		cout << "Device " << device+1 << ": " << deviceProp.name << endl;
		cout << " Compute Capability: " << deviceProp.major << ", " << deviceProp.minor << endl;
		cout << " Multiprocessors: " << deviceProp.multiProcessorCount << endl;
		cout << " Max Threads per Multiprocessor: " << deviceProp.maxThreadsPerMultiProcessor << endl;
		cout << " Max Threads per Block: " << deviceProp.maxThreadsPerBlock << endl;
		cout << " Clock Rate: " << deviceProp.clockRate << " kHz" << endl;
		cout << " Memory Clock Rate: " << deviceProp.memoryClockRate << " MHz" << endl;
		cout << " Memory Bus Width: " << deviceProp.memoryBusWidth << " bits" << endl;
		cout << " Memory Bandwidth: " << 2.0 * deviceProp.memoryBusWidth * deviceProp.memoryClockRate / 1e6 << " GB/s" << endl;
		cout << "\n" << endl;
	}

	return 0;
}
