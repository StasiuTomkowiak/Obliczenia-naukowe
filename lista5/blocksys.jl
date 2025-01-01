#Stanisław Tomkowiak

module blocksys

using LinearAlgebra
using SparseArrays

export readA, readB, gaussianElimination, partialGaussianElimination 

function gaussianElimination(A::SparseMatrixCSC, b::Vector{Float64},l)::Vector{Float64}
    n = size(A, 1)
    x = zeros(Float64, n)

    # Tworzymy kopie, aby nie modyfikować oryginalnych macierzy
    A = deepcopy(A)
    b = deepcopy(b)

    # Eliminacja wierszy
    for k in 1:n-1
        for i in k+1:min(n, k+l-(k%l))
            if A[k, k] == 0
                throw(ErrorException("Dzielenie przez zero w eliminacji Gaussa"))
            end
            factor = A[i, k] / A[k, k]
            for j in k+1:min(n, k + l)
                A[i, j] -= factor * A[k, j]
            end
            b[i] -= factor * b[k]
        end
    end

    # Rozwiązanie równania macierzowego Ax = b
    for i in n:-1:1
        if A[i, i] == 0
            throw(ErrorException("Układ jest osobliwy lub ma nieskończenie wiele rozwiązań"))
        end

        # Bezpieczne sumowanie
        sum = Float64(0.0)
        for j = i+1:min(n, i + l)
            sum += A[i, j] * x[j]
        end

        x[i] = (b[i] - sum) / A[i, i]
    end

    return x
end

function partialGaussianElimination(A::SparseMatrixCSC, b::Vector{Float64},l)::Vector{Float64}
    n = size(A, 1)
    x = zeros(Float64, n)

    # Tworzymy kopie, aby nie modyfikować oryginalnych macierzy
    A = deepcopy(A)
    b = deepcopy(b)

    # Eliminacja wierszy z częściowym wybieraniem elementu głównego
    for k in 1:n-1
        # Wybór elementu głównego
        pivot_row = argmax(abs.(A[k:n, k])) + k - 1
        if A[pivot_row, k] == 0
            throw(ErrorException("Układ jest osobliwy lub nie ma jednoznacznego rozwiązania"))
        end

        # Zamiana wierszy w macierzy A i wektorze b
        if pivot_row != k
            A[k, :], A[pivot_row, :] = A[pivot_row, :], A[k, :]
            b[k], b[pivot_row] = b[pivot_row], b[k]
        end

        # Eliminacja
        for i in k+1:min(n, k+l-(k%l))
            if A[k, k] == 0
                throw(ErrorException("Dzielenie przez zero w eliminacji Gaussa"))
            end
            factor = A[i, k] / A[k, k]
            for j in k+1:min(n, k + 2*l)
                A[i, j] -= factor * A[k, j]
            end
            b[i] -= factor * b[k]
        end
    end

    # Rozwiązanie równania macierzowego Ax = b
    for i in n:-1:1
        if A[i, i] == 0
            throw(ErrorException("Układ jest osobliwy lub ma nieskończenie wiele rozwiązań"))
        end

        # Bezpieczne sumowanie
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

function main()
    println("Podaj nazwę pliku z macierzą A:")
    filenameA = readline()

    println("Podaj nazwę pliku z wektorem b:")
    filenameB = readline()

    try
        # Wczytanie macierzy A i wektora b
        matrixA = readA(filenameA)
        vectorB = readB(filenameB)

        println("Macierz A wczytana z pliku:")

        println("Wektor b wczytany z pliku:")

        println("Wybierz metodę eliminacji:")
        println("1 - Zwykła eliminacja Gaussa")
        println("2 - Eliminacja Gaussa z częściowym pivotingiem")
        method = parse(Int, readline())

        if method == 1
            elapsed_time = @elapsed solution = gaussianElimination(matrixA, vectorB,4)
            println("Rozwiązanie układu Ax = b (zwykła eliminacja):")
        elseif method == 2
            #solution = partialGaussianElimination(matrixA, vectorB,4)
            elapsed_time = @elapsed solution = partialGaussianElimination(matrixA, vectorB, 4)
            println("Rozwiązanie układu Ax = b (z częściowym pivotingiem):")
        else
            println("Niepoprawny wybór metody.")
            return
        end
        println("Czas obliczeń: $(elapsed_time) sekund")
        #println(solution)

    catch e
        println("Wystąpił błąd: ", e.msg)
    end
end


end # module BlockSys

using .blocksys

blocksys.main()
