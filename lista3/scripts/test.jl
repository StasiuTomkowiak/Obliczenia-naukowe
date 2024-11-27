# Stanisław Tomkowiak
#272345
include("ZeroFinding.jl")
using .ZeroFinding

println("x^2 - 1")
println("Bisekcja: ", mbisekcji(x -> x^2 - 1, 0.0, 7.0, 1.0e-10, 1.0e-10))
println("Styczne: ", mstycznych(x -> x^2 - 1, x-> 2 * x, 2.0, 1.0e-10, 1.0e-10, 20))
println("Sieczne: ", msiecznych(x -> x^2 - 1, 0.0, 7.0, 1.0e-10, 1.0e-10, 20))

println("x^2 - 2")
println("Bisekcja: ", mbisekcji(x -> x^2 - 2, 0.0, 2.0, 1.0e-10, 1.0e-10))
println("Styczne: ", mstycznych(x -> x^2 - 2, x-> 2 * x, 2.0, 1.0e-10, 1.0e-10, 20))
println("Sieczne: ", msiecznych(x -> x^2 - 2, 0.0, 10.0, 1.0e-10, 1.0e-10, 20))
