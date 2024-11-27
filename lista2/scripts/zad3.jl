#Stanisław Tomkowiak
#272345

include("hilb.jl")
include("matcond.jl")

function gauss(A,b,X)
    xGauss = A \ b
    return norm(xGauss - X) / norm(X)
end

function invr(A,b,X)
    xInv = inv(A) * b
    return norm(xInv - X) / norm(X)
end
function solveA(n)
    A = hilb(n)
    X = ones(n)
    b = A * X

    #eliminacja gaussa
    relErrGauss = gauss(A,b,X)

    #inv
    relErrInv = invr(A,b,X)

    #wskaźnik uwarunkowania
    condA = cond(A)

    #wyświetlenie wyników
    println("$n;$relErrGauss;$relErrInv;$condA")
end

function solveB(n,c)
    A = matcond(n,c)
    X = ones(n)
    b = A * X

    #eliminacja gaussa
    relErrGauss = gauss(A,b,X)

    #inv
    relErrInv = invr(A,b,X)

    #wyświetlenie wyników
    println("$n;$c;$relErrGauss;$relErrInv")
end

println("Podpunkt A")
println("n;relErrGaus;relErrInv;cond")
for n in 2:20
    solveA(n)
end
println()

println("Podpunkt B")
println("n;c;relErrGaus;relErrInv")
for n in [5, 10, 20]
    for c in [1.0, 10.0, 1.0e3, 1.0e7, 1.0e12, 1.0e16]
        solveB(n, c)
    end
end
