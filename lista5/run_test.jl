#stanisław Tomkowiak 272345
include("blocksys.jl")
include("matrixgen.jl")
using LinearAlgebra
using SparseArrays
using Statistics
using .matrixgen
using .blocksys

function run_tests()
    sizes = 1000:1000:15000
    l = 4
    ck = 10.0

    # Output files for time and memory results
    error_file = open("error_results.txt", "w")
    time_file = open("time_results.txt", "w")
    memory_file = open("memory_results.txt", "w")

    for n in sizes
        println("Processing size: $n")

        # Generate matrix A and save it in the 'matrix' directory
        matrix_file = "matrix/matrix_$n.txt"
        blockmat(n, l, ck, matrix_file)
        A = readA(matrix_file)

        # Generate vector b
        b = getB(A, l)

        # Prepare output variables
        algorithms = ["Gaussian", "Partial_Gaussian", "LU", "Partial_LU"]
        errors = Dict{String, Float64}()
        times = Dict{String, Float64}()
        memories = Dict{String, Float64}()

        # Loop over each algorithm
        for algo in algorithms
            total_time = 0.0
            total_memory = 0
            total_error = 0.0
            x = Vector{Float64}()

            for i in 1:3
                # Benchmark each algorithm 3 times
                time_elapsed = 0.0
                memory_allocated = 0

                if algo == "Gaussian"
                    time_elapsed = @elapsed memory_allocated = @allocated begin
                        x = gaussianElimination(A, b, l)
                    end
                    total_error += errorRelative(x)
                elseif algo == "Partial_Gaussian"
                    time_elapsed = @elapsed memory_allocated = @allocated begin
                        x = partialGaussianElimination(A, b, l)
                    end
                    total_error += errorRelative(x)
                elseif algo == "LU"
                    time_elapsed = @elapsed memory_allocated = @allocated begin
                        LU = calculateLU(A, l)
                        x = solveLU(LU, deepcopy(b), l)
                    end
                    total_error += errorRelative(x)
                elseif algo == "Partial_LU"
                    time_elapsed = @elapsed memory_allocated = @allocated begin
                        LU, pivot = partialCalculateLU(A, l)
                        x = partialSolveLU(LU, b, pivot, l)
                    end
                    total_error += errorRelative(x)
                end

                # Accumulate time and memory usage
                total_time += time_elapsed
                total_memory += memory_allocated
            end

            # Average the results over 3 iterations
            avg_time = total_time / 3
            avg_memory = total_memory / 3 / 1024  # Convert to KB
            avg_error = total_error / 3

            # Store averaged results for each algorithm
            times[algo] = avg_time
            memories[algo] = avg_memory
            errors[algo] = avg_error

            # Write results to file for each algorithm after the 3 runs
            writeXError("$(algo)/x_$(algo)_$(n).txt", x, avg_error)
        end

        # Append averaged results to time, memory, and error files
        write(error_file, "$n\t$(join([errors[algo] for algo in algorithms], "\t"))\n")
        write(time_file, "$n\t$(join([times[algo] for algo in algorithms], "\t"))\n")
        write(memory_file, "$n\t$(join([memories[algo] for algo in algorithms], "\t"))\n")
    end

    close(error_file)
    close(time_file)
    close(memory_file)

    println("All tests completed.")
end

run_tests()
