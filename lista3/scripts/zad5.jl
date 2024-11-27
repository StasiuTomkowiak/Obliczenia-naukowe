#Stanisław Tomkowiak
#272345

include("ZeroFinding.jl")
using .ZeroFinding

println("e^x = 3x")
println("Bisekcja miejsce pierwsze: ", mbisekcji(x -> 3 * x - MathConstants.e^x, 0.0, 1.0, 1.0e-4, 1.0e-4))
println("Bisekcja miejsce drugie: ", mbisekcji(x -> 3 * x - MathConstants.e^x, 1.0, 2.0, 1.0e-4, 1.0e-4))