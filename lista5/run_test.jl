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
        algorithms = ["Gaussian", "Partial Gaussian", "LU", "Partial LU"]
        errors = Dict{String, Float64}()
        times = Dict{String, Float64}()
        memories = Dict{String, Float64}()

        for algo in algorithms
            # Benchmark each algorithm
            x = Vector{Float64}()
            time_elapsed = 0.0
            memory_allocated = 0

            if algo == "Gaussian"
                time_elapsed = @elapsed memory_allocated = @allocated begin
                    x = gaussianElimination(A, b, l)
                    errors[algo] = errorRelative(x)
                end
                writeXError("Gaussian/x_Gaussian_$(n).txt", x, errors[algo])

            elseif algo == "Partial Gaussian"
                time_elapsed = @elapsed memory_allocated = @allocated begin
                    x = partialGaussianElimination(A, b, l)
                    errors[algo] = errorRelative(x)
                end
                writeXError("Partial_Gaussian/x_Partial_Gaussian_$(n).txt", x, errors[algo])

            elseif algo == "LU"
                time_elapsed = @elapsed memory_allocated = @allocated begin
                    LU = calculateLU(A, l)
                    x = solveLU(LU, deepcopy(b), l)
                    errors[algo] = errorRelative(x)
                end
                writeXError("LU/x_LU_$(n).txt", x, errors[algo])

            elseif algo == "Partial LU"
                time_elapsed = @elapsed memory_allocated = @allocated begin
                    LU, pivot = partialCalculateLU(A, l)
                    x = partialSolveLU(LU, b, pivot, l)
                    errors[algo] = errorRelative(x)
                end
                writeXError("Partial_LU/x_Partial_LU_$(n).txt", x, errors[algo])
            end

            # Store runtime and memory usage for each algorithm
            times[algo] = time_elapsed
            memories[algo] = memory_allocated / 1024  # Convert to KB
        end

        # Append results to time, memory, and error files
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
