#Stanisław Tomkowiak 272345

include("blocksys.jl")
using .blocksys

function main()
    println("Podaj nazwę pliku z macierzą A:")
    filenameA = readline()

    println("Podaj nazwę pliku z wektorem b:")
    filenameB = readline()

    try
        # Wczytanie macierzy A i wektora b
        matrixA = readA(filenameA)
        #vectorB = getB(matrixA,4)
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
        relErr = errorRelative(solution)
            writeX( "x.txt", solution)
            writeXError("xerr.txt", solution, relErr)
    catch e
        println("Wystąpił błąd: ", e.msg)
    end
end

main()