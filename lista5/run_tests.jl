#Stanisław Tomkowiak

include("blocksys.jl")
using LinearAlgebra
using SparseArrays
using .blocksys
using Glob

function test_blocksys_functions()
    test_folders = glob("tests/*")
    for folder in test_folders
        if isdir(folder)
            println("Running tests in folder: $folder")
            A_file = joinpath(folder, "A.txt")
            b_file = joinpath(folder, "b.txt")
            
            if !(isfile(A_file) && isfile(b_file))
                println("Missing A.txt or b.txt in $folder. Skipping...")
                continue
            end
            
            A = readA(A_file)
            b = readB(b_file)
            l = 4
            
            functions = [
                ("gaussianElimination", gaussianElimination),
                ("partialGaussianElimination", partialGaussianElimination),
                ("calculateLU + solveLU", (A, b, l) -> solveLU(calculateLU(A, l), deepcopy(b), l)),
                ("partialCalculateLU + partialSolveLU", (A, b, l) -> begin
                    LU, pivots = partialCalculateLU(A, l)
                    partialSolveLU(LU, b, pivots, l)
                end)
            ]
            
            execution_times = []
            memory_usages = []

            for (name, func) in functions
                try
                    elapsed_time = @elapsed memory_alloc = @allocated solution = if typeof(func) <: Function
                        func(A, b, l)
                    else
                        func(A, deepcopy(b), l)
                    end

                    error = errorRelative(solution)

                    output_file = joinpath(folder, "xerror_$name.txt")
                    writeXError(output_file, solution, error)

                    push!(execution_times, (name, elapsed_time))
                    push!(memory_usages, (name, memory_alloc))
                    
                    println("Test for $name in $folder passed. Results written to $output_file.")
                catch e
                    println("Test for $name in $folder failed: $e")
                end
            end

            exec_time_file = joinpath(folder, "execution_time.txt")
            open(exec_time_file, "w") do io
                for (func_name, time) in execution_times
                    println(io, "$func_name: $time seconds")
                end
            end
            println("Execution times written to $exec_time_file.")

            memory_usage_file = joinpath(folder, "memory_usage.txt")
            open(memory_usage_file, "w") do io
                for (func_name, memory) in memory_usages
                    println(io, "$func_name: $memory bytes")
                end
            end
            println("Memory usage written to $memory_usage_file.")
        end
    end
end

# Run the test script
test_blocksys_functions()
