#Stanisław Tomkowiak

module blocksys

using LinearAlgebra
using SparseArrays

export readA, readB, gaussianElimination, partialGaussianElimination,calculateLU, LUSolve, partialcalculateLU, writeX, writeXError, errorRelative, getB


function gaussianElimination(A::SparseMatrixCSC, b::Vector{Float64},l)::Vector{Float64}
    n = size(A, 1)
    x = zeros(Float64, n)

    A = deepcopy(A)
    b = deepcopy(b)

    for k in 1:n-1
        for i in k+1:min(n, k+l+1)
            if A[k, k] == 0
                throw(ErrorException("Dzielenie przez zero w eliminacji Gaussa"))
            end
            factor = A[i, k] / A[k, k]
            for j in k+1:min(n, k + l+1)
                A[i, j] -= factor * A[k, j]
            end
            b[i] -= factor * b[k]
        end
    end

    for i in n:-1:1
        if A[i, i] == 0
            throw(ErrorException("Układ jest osobliwy lub ma nieskończenie wiele rozwiązań"))
        end

        sum = Float64(0.0)
        for j = i+1:min(n, i + l+2)
            sum += A[i, j] * x[j]
        end

        x[i] = (b[i] - sum) / A[i, i]
    end

    return x
end

function partialGaussianElimination(A::SparseMatrixCSC, b::Vector{Float64},l)::Vector{Float64}
    n = size(A, 1)
    x = zeros(Float64, n)

    A = deepcopy(A)
    b = deepcopy(b)

    for k in 1:n-1
        pivot_row = argmax(abs.(A[k:n, k])) + k - 1
        if A[pivot_row, k] == 0
            throw(ErrorException("Układ jest osobliwy lub nie ma jednoznacznego rozwiązania"))
        end

        if pivot_row != k
            A[k, :], A[pivot_row, :] = A[pivot_row, :], A[k, :]
            b[k], b[pivot_row] = b[pivot_row], b[k]
        end

        for i in k+1:min(n, k + l + 1)
            if A[k, k] == 0
                throw(ErrorException("Dzielenie przez zero w eliminacji Gaussa"))
            end
            factor = A[i, k] / A[k, k]
            for j in k+1:min(n, k + 2* l)
                A[i, j] -= factor * A[k, j]
            end
            b[i] -= factor * b[k]
        end
    end

    for i in n:-1:1
        if A[i, i] == 0
            throw(ErrorException("Układ jest osobliwy lub ma nieskończenie wiele rozwiązań"))
        end

        sum = Float64(0.0)
        for j = i+1:min(n, i + 2*l)
            sum += A[i, j] * x[j]
        end
        x[i] = (b[i] - sum) / A[i, i]
    end

    return x
end

function readA(filename::String)

    lines = (x for x in eachline(filename))
    header = iterate(lines)[1]

    n, l = [parse(Int, x) for x in split(header)]

    if n % l != 0
        throw(ErrorException("`n` is not divisible by `l`"))
    end

    let matrix
    end

    matrix = spzeros(n, n)

    i = 1
    for line in lines

        x, y, v = [parse(Float64, i) for i in split(line)]
        x = Int(x)
        y = Int(y)
        matrix[x,y] = v

        i += 1
    end

    return matrix

end

function readB(filename::String)::Vector{Float64}

    lines = (x for x in eachline(filename))
    header = iterate(lines)[1]

    n = parse(Int, header)
    b = []

    for line in lines
        append!(b, [parse(Float64, line)])
    end
    return b

end

function getB(A::SparseMatrixCSC,l)::Vector{Float64}
    n = size(A, 1)
    vectorB = zeros(Float64, n)
    for i = 1:n
        for j = max(1, i-(2 + l)):min(n, i + l)
            vectorB[i] += A[i, j]
        end
    end
    return vectorB
end 

function errorRelative(result::Vector{Float64})::Float64
    expected = ones(Float64, length(result))
    return abs(norm(result - expected)) / norm(expected)
end 

function writeX(outFileName::String, x::Vector{Float64})
    outFile = open(outFileName, "w")

    for i = 1:length(x)
        println(outFile, x[i])
    end

    close(outFile)
end

function writeXError(outFileName::String, x::Vector{Float64}, error::Float64)
    outFile = open(outFileName, "w")

    println(outFile, error)
    for i = 1:length(x)
        println(outFile, x[i])
    end

    close(outFile)
end

end 

