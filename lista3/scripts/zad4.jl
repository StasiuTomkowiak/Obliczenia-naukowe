#Stanisław Tomkowiak
#272345

include("ZeroFinding.jl")
using .ZeroFinding

println("sin(x) - (1/2 x)^2 = 0")
println("Bisekcjia: ", mbisekcji(x -> sin(x) - (0.5 * x)^2, 1.5, 2.0, 0.5e-5, 0.5e-5))
println("Styczne: ", mstycznych(x -> sin(x) - (0.5 * x)^2, x -> cos(x) - 0.5 * x, 1.5, 0.5e-5, 0.5e-5, 64))
println("Sieczne: ", msiecznych(x -> sin(x) - (0.5 * x)^2, 1.0, 2.0, 0.5e-5, 0.5e-5, 64))