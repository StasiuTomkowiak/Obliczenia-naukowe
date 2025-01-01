# Mikołaj Krupiński

module blocksys

using LinearAlgebra

export solveGaussianElimination, solveGaussianEliminationPartialPivoting, calculateLU, calculateLUPartialPivot, solveWithLU, relativeError, getVectorB, readMatrixA, readVectorB, writeVectorX, writeVectorXWithError

mutable struct MatrixA
    n::Int64
    l::Int64
    v::Int64                    # v = n / l
    A::Array{Matrix{Float64}}   # dense matrix, numerated from 1 to v
    B::Array{Vector{Float64}}   # non-zero elements in last column, numerated from 2 to v
    C::Array{Matrix{Float64}}   # non-zero elements on diagonal and later under the diagonal, numerated from 1 to v-1
end # mutable struct MatrixA

function createMatrixA(n::Int64, l::Int64)::MatrixA
    v = n / l
    A = [zeros(Float64, l, l) for _ in 1:v]
    B = [zeros(Float64, l) for _ in 1:v-1]
    C = [zeros(Float64, l, l) for _ in 1:v-1]
    return MatrixA(n, l, v, A, B, C)
end # function createMatrixA

function Base.getindex(matrixA::MatrixA, i::Int64, j::Int64)::Float64
    row = div((i - 1), matrixA.l) + 1
    localI = (i - 1) % matrixA.l + 1
    localJ = (j - 1) % matrixA.l + 1

    if (row - 1) * matrixA.l < j && j <= row * matrixA.l # submatrix A
        return matrixA.A[row][localI, localJ]
    elseif j == (row - 1) * matrixA.l # submatrix B (only non-zero elements)
        return matrixA.B[row-1][localI]
    elseif row * matrixA.l < j && j <= (row + 1) * matrixA.l # submatrix C
        return matrixA.C[row][localI, localJ]
    end
    return Float64(0.0)
end # function getindex

function Base.setindex!(matrixA::MatrixA, value::Float64, i::Int64, j::Int64)
    row = div((i - 1), matrixA.l) + 1
    localI = (i - 1) % matrixA.l + 1
    localJ = (j - 1) % matrixA.l + 1

    if (row - 1) * matrixA.l < j && j <= row * matrixA.l # submatrix A
        matrixA.A[row][localI, localJ] = value
    elseif j == (row - 1) * matrixA.l # submatrix B (only non-zero elements)
        matrixA.B[row-1][localI] = value
    elseif row * matrixA.l < j && j <= (row + 1) * matrixA.l # submatrix C
        matrixA.C[row][localI, localJ] = value
    end
end # function setindex

function solveGaussianElimination(AOriginal::MatrixA, bOriginal::Vector{Float64})::Vector{Float64}
    A = deepcopy(AOriginal) # copy not to change the original matrix
    b = deepcopy(bOriginal) # copy not to change the original vector
    n = A.n
    l = A.l
    for k = 1:n-1
        for i = k+1:min(n, k+l-(k%l))
            I_ik = A[i, k] / A[k, k]
            for j = k+1:min(n, k + l)
                A[i, j] -= I_ik * A[k, j]
            end
            b[i] -= I_ik * b[k]
        end
    end

    x = zeros(Float64, n)
    for k = n:-1:1
        sum = Float64(0.0)
        for j = k+1:min(n, k + l)
            sum += A[k, j] * x[j]
        end
        x[k] = (b[k] - sum) / A[k, k]
    end

    return x
end # function solveGaussianElimination

function solveGaussianEliminationPartialPivoting(AOriginal::MatrixA, bOriginal::Vector{Float64})::Vector{Float64}
    A = deepcopy(AOriginal) # copy not to change the original matrix
    b = deepcopy(bOriginal) # copy not to change the original vector
    n = A.n
    l = A.l
    rowPerm = collect(1:n) # row permutation vector, e.g. rowPerm[4]=11 => row 4 is now row 11
    for k = 1:n-1
        # Partial pivoting start
        biggestElement = abs(A[rowPerm[k], k])
        biggestIndex = k
        for l = k+1:min(n, k+l-(k%l))
            if abs(A[rowPerm[l], k]) > biggestElement
                biggestElement = abs(A[rowPerm[l], k])
                biggestIndex = l
            end
        end
        rowPerm[k], rowPerm[biggestIndex] = rowPerm[biggestIndex], rowPerm[k]
        # Partial pivoting end
        for i = k+1:min(n, k+l-(k%l))
            I_ik = A[rowPerm[i], k] / A[rowPerm[k], k]
            for j = k+1:min(n, k + 2*l)
                A[rowPerm[i], j] -= I_ik * A[rowPerm[k], j]
            end
            b[rowPerm[i]] -= I_ik * b[rowPerm[k]]
        end
    end

    x = zeros(Float64, n)
    for k = n:-1:1
        sum = Float64(0.0)
        for j = k+1:min(n, k + 2*l)
            sum += A[rowPerm[k], j] * x[rowPerm[j]]
        end
        x[rowPerm[k]] = (b[rowPerm[k]] - sum) / A[rowPerm[k], k]
    end

    return x
end # function solveGaussianEliminationPartialPivoting

function calculateLU(AOriginal::MatrixA)::MatrixA
    A = deepcopy(AOriginal) # copy not to change the original matrix
    n = A.n
    l = A.l
    for k = 1:n-1
        for i = k+1:min(n, k+l-(k%l))
            I_ik = A[i, k] / A[k, k]
            A[i, k] = I_ik
            for j = k+1:min(n, k + l)
                A[i, j] -= I_ik * A[k, j]
            end
        end
    end
    return A
end # function calculateLU

function calculateLUPartialPivot(AOriginal::MatrixA)::Tuple{MatrixA,Array{Int64}}
    A = deepcopy(AOriginal) # copy not to change the original matrix
    n = A.n
    l = A.l
    rowPerm = collect(1:n) # row permutation vector, e.g. rowPerm[4]=11 => row 4 is now row 11
    for k = 1:n-1
        # Partial pivoting start
        biggestElement = abs(A[k, k])
        biggestIndex = k
        for l = k+1:min(n, k + l)
            if abs(A[l, k]) > biggestElement
                biggestElement = abs(A[l, k])
                biggestIndex = l
            end
        end
        if k != biggestIndex
            rowPerm[k], rowPerm[biggestIndex] = rowPerm[biggestIndex], rowPerm[k]
            for i = max(1, k - l):min(n, biggestIndex + 2 * l)
                A[k, i], A[biggestIndex, i] = A[biggestIndex, i], A[k, i]
            end
        end
        # Partial pivoting end
        for i = k+1:min(n, k+l-(k%l))
            I_ik = A[i, k] / A[k, k]
            A[i, k] = I_ik
            for j = k+1:min(n, k + 2*l)
                A[i, j] -= I_ik * A[k, j]
            end
        end
    end
    return A, rowPerm
end # function calculateLUPartialPivot

function solveWithLU(A::MatrixA, bOriginal::Vector{Float64}, rowPerm=Nothing)::Vector{Float64}
    n = A.n
    l = A.l

    if rowPerm != Nothing # apply row permutation on vector b
        b = zeros(Float64, n)
        for i = 1:n
            b[i] = bOriginal[rowPerm[i]]
        end
    else
        b = deepcopy(bOriginal) # copy not to change the original vector
    end

    # adjust vector b to the LU decomposition
    for k = 1:n-1
        for i = k+1:min(n, k+l-(k%l))
            b[i] -= A[i, k] * b[k]
        end
    end

    x = zeros(Float64, n)
    for k = n:-1:1
        sum = Float64(0.0)
        for j = k+1:min(n, k + 2*l)
            sum += A[k, j] * x[j]
        end
        x[k] = (b[k] - sum) / A[k, k]
    end

    return x
end # function solveWithLU

function relativeError(result::Vector{Float64})::Float64
    expected = ones(Float64, length(result))
    return abs(norm(result - expected)) / norm(expected)
end # function relativeError

function getVectorB(A::MatrixA)::Vector{Float64}
    n = A.n
    l = A.l
    vectorB = zeros(Float64, n)
    for i = 1:n
        row = div((i - 1), l) + 1
        for j = max(1, (row - 1) * l):min(n, (row + 1) * l)
            vectorB[i] += A[i, j]
        end
    end
    return vectorB
end # function getVectorB

function readMatrixA(inFileName::String)::MatrixA
    inFile = open(inFileName, "r")

    line = readline(inFile)
    dims = split(line, " ")
    n = parse(Int64, dims[1])
    l = parse(Int64, dims[2])

    matrixA = createMatrixA(n, l)

    while !eof(inFile)
        line = readline(inFile)
        row = split(line, " ")
        i = parse(Int64, row[1])
        j = parse(Int64, row[2])
        value = parse(Float64, row[3])
        matrixA[i, j] = value
    end

    close(inFile)

    return matrixA
end # function readAMatrix

function readVectorB(inFileName::String)::Vector{Float64}
    inFile = open(inFileName, "r")

    line = readline(inFile)
    dims = split(line, " ")
    n = parse(Int64, dims[1])

    vectorB = zeros(Float64, n)

    for i = 1:n
        line = readline(inFile)
        vectorB[i] = parse(Float64, line)
    end

    close(inFile)

    return vectorB
end # function readVectorB

function writeVectorX(outFileName::String, x::Vector{Float64})
    outFile = open(outFileName, "w")

    for i = 1:length(x)
        println(outFile, x[i])
    end

    close(outFile)
end # function writeVectorX

function writeVectorXWithError(outFileName::String, x::Vector{Float64}, error::Float64)
    outFile = open(outFileName, "w")

    println(outFile, error)
    for i = 1:length(x)
        println(outFile, x[i])
    end

    close(outFile)
end # function writeVectorXWithError
function main()
    println("Podaj nazwę pliku z macierzą A:")
    filenameA = readline()

    println("Podaj nazwę pliku z wektorem b:")
    filenameB = readline()

    try
        # Wczytanie macierzy A i wektora b
        matrixA = readMatrixA(filenameA)
        vectorB = readVectorB(filenameB)


        println("Wybierz metodę eliminacji:")
        println("1 - Zwykła eliminacja Gaussa")
        println("2 - Eliminacja Gaussa z częściowym pivotingiem")
        method = parse(Int, readline())

        if method == 1
            solution = solveGaussianElimination(matrixA, vectorB)
            println("Rozwiązanie układu Ax = b (zwykła eliminacja):")
        elseif method == 2
            solution = solveGaussianEliminationPartialPivoting(matrixA, vectorB)
            println("Rozwiązanie układu Ax = b (z częściowym pivotingiem):")
        else
            println("Niepoprawny wybór metody.")
            return
        end

        println(solution)

    catch e
        println("Wystąpił błąd: ", e.msg)
    end
end
end # module BlockSys

using .blocksys

blocksys.main()
