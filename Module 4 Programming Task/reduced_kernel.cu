#include <cuda_runtime.h>
#include <device_launch_parameters.h>

// Define the kernel for parallel reduction
__global__ void reduceKernel(int* inputArray, int* outputArray, int arraySize) {
    extern __shared__ int shared_sum[];  // Shared memory to hold partial sums

    // Calculate thread index
    int tid = blockIdx.x * blockDim.x + threadIdx.x; // Global thread index
    int stride = blockDim.x * gridDim.x; // Stride: the step size by which a thread advances through the data

    // Initialize partial sum for each thread
    int partial_sum = 0;
    // Perform reduction across threads
    for (int i = tid; i < arraySize; i += stride) {
        partial_sum += inputArray[i];  // Accumulate data into partial sum
    }

    // Store partial sum in shared memory
    shared_sum[threadIdx.x] = partial_sum;
    // Synchronize threads within the block before proceeding
    __syncthreads();

    // Perform block-level reduction: combine the partial sums in shared memory
    for (int i = blockDim.x / 2; i > 0; i /= 2) {
        if (threadIdx.x < i) {
            shared_sum[threadIdx.x] += shared_sum[threadIdx.x + i]; // Combine results from threads
        }
        // Synchronize threads again before the next reduction step
        __syncthreads();
    }

    // Write the final result from the block (first thread in the block) to global memory
    if (threadIdx.x == 0) {
        outputArray[blockIdx.x] = shared_sum[0];
    }
}