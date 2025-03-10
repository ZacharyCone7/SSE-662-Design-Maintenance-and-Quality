#include <iostream>
#include <vector>
#include <cstdint>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <chrono>

using namespace std;

// Constants for shared memory size and array size
#define SHMEM_SIZE 256 * 4  // Shared memory size for the reduction kernel
#define SIZE 256            // Size of each block (number of threads per block)

__global__ void reduceKernel(int* inputArray, int* outputArray, int arraySize);

// Function to check for CUDA errors and print error messages
void checkCudaError(cudaError_t err, const char* msg) {
    if (err != cudaSuccess) {
        cerr << "Error: " << msg << " - " << cudaGetErrorString(err) << endl;
        exit(EXIT_FAILURE);
    }
}

// xorshift128+ generator for random numbers
int xorshift128plus(uint64_t s[2]) {
    uint64_t x = s[0];
    uint64_t y = s[1];
    s[0] = y;
    x ^= x << 23;
    s[1] = x ^ y ^ (x >> 17) ^ (y >> 26);
    uint64_t result = s[1] + y;

    // Cast to int (ensure it fits in the int range)
    return static_cast<int>(result & 0x7FFFFFFF); // Mask to ensure positive 32-bit int
}

// Generate random array using xorshift128+
vector<int> generateRandomArray(uint64_t s[2], size_t size) {
    vector<int> random_array(size);
    for (size_t i = 0; i < size; i++) {
        random_array[i] = xorshift128plus(s); // Generate random number for each element
    }
    return random_array;
}

// Initialize a vector with a specific value (for debugging or testing)
void initialize_vector(vector<int>& v, int n) {
    for (size_t i = 0; i < v.size(); i++) {
        v[i] = n;  // Set each element to the value n
    }
}

// Launch the reduction kernel with the given block size and grid size
void launchReduceKernel(int* dev_array, int* dev_output, int array_size, int blockSize, int numBlocks) {
    reduceKernel << <numBlocks, blockSize, blockSize * sizeof(int) >> > (dev_array, dev_output, array_size);  // Launch the kernel
}

// Memory management for device allocation and data transfer
void allocateAndCopyMemory(int** dev_array, int** dev_result, const vector<int>& random_array, size_t array_size) {
    cudaError_t err = cudaMalloc(dev_array, array_size * sizeof(int));
    checkCudaError(err, "cudaMalloc failed!");

    err = cudaMalloc(dev_result, sizeof(int) * ((array_size + 255) / 256));
    checkCudaError(err, "cudaMalloc failed!");

    err = cudaMemcpy(*dev_array, random_array.data(), array_size * sizeof(int), cudaMemcpyHostToDevice);
    checkCudaError(err, "cudaMemcpy failed!");
}

// Cleanup CUDA resources
void cleanup(int* dev_array, int* dev_result) {
    cudaFree(dev_array);
    cudaFree(dev_result);
}

// Timing and result verification
void timeAndVerifyResults(int* dev_result, const vector<int>& random_array, int numBlocks, int array_size) {
    vector<int> host_result(numBlocks);
    cudaMemcpy(host_result.data(), dev_result, sizeof(int) * numBlocks, cudaMemcpyDeviceToHost);

    int gpu_result = 0;
    for (const auto& block_sum : host_result) {
        gpu_result += block_sum;
    }

    int cpu_result = 0;
    auto cpu_start = chrono::high_resolution_clock::now();
    for (const auto& num : random_array) {
        cpu_result += num;
    }
    auto cpu_end = chrono::high_resolution_clock::now();
    chrono::duration<float, std::milli> cpu_elapsed = cpu_end - cpu_start;

    if (gpu_result == cpu_result) {
        cout << "Results match! Sum: " << gpu_result << endl;
    }
    else {
        cout << "Results do not match! GPU Sum: " << gpu_result << ", CPU Sum: " << cpu_result << endl;
    }
    cout << "CPU Execution Time: " << cpu_elapsed.count() << " ms" << endl;
}

int main() {
    uint64_t state[2] = { 123456789, 987654321 };  // Seed for the random number generator
    size_t array_size = 4096;
    vector<int> random_array = generateRandomArray(state, array_size);

    int* dev_array;
    int* dev_result;
    allocateAndCopyMemory(&dev_array, &dev_result, random_array, array_size);

    float elapsedTime = 0.0f;
    //-------------- Test Case 1: Fixed Block Size, Varying Grid Size
    int blockSize = 256;
    for (int numBlocks = 1; numBlocks <= (array_size + 255) / 256; numBlocks *= 2) {
        cudaEvent_t start, stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);

        cudaEventRecord(start);
        launchReduceKernel(dev_array, dev_result, array_size, blockSize, numBlocks);
        cudaEventRecord(stop);

        cudaEventSynchronize(stop);
        cudaEventElapsedTime(&elapsedTime, start, stop);

        cout << "Grid Size: " << numBlocks << ", Block Size: " << blockSize << ", Execution Time: " << elapsedTime << " ms" << endl;

        cudaEventDestroy(start);
        cudaEventDestroy(stop);

        timeAndVerifyResults(dev_result, random_array, numBlocks, array_size);
    }

    //-------------- Test Case 2: Fixed Grid Size, Varying Block Size
    int numBlocks = (array_size + 1024 - 1) / 1024;
    for (blockSize = 128; blockSize <= 1024; blockSize *= 2) {
        cudaEvent_t start, stop;
        cudaEventCreate(&start);
        cudaEventCreate(&stop);

        cudaEventRecord(start);
        launchReduceKernel(dev_array, dev_result, array_size, 256, numBlocks);
        cudaEventRecord(stop);

        cudaEventSynchronize(stop);
        cudaEventElapsedTime(&elapsedTime, start, stop);

        cout << "Grid Size: " << numBlocks << ", Block Size: " << blockSize << ", Execution Time: " << elapsedTime << " ms" << endl;

        cudaEventDestroy(start);
        cudaEventDestroy(stop);

        timeAndVerifyResults(dev_result, random_array, numBlocks, array_size);
    }

    cleanup(dev_array, dev_result);
    return 0;
}