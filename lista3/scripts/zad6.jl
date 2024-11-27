#Stanisław Tomkowiak
#272345

include("ZeroFinding.jl")
using .ZeroFinding

#podpunkt 1
println("e^(1 - x) - 1 = 0")
println("Bisekcja: ", mbisekcji(x -> MathConstants.e^(1 - x) - 1, 0.0, 3.0, 1.0e-4, 1.0e-4))
println("Styczne: ", mstycznych(x -> MathConstants.e^(1 - x) - 1, x -> -MathConstants.e^(1 - x), 0.5, 1.0e-4, 1.0e-4, 20))
println("Sieczne: ", msiecznych(x -> MathConstants.e^(1 - x) - 1, 0.0, 2.0, 1.0e-4, 1.0e-4, 20))

#podpunkt 2
println("x * e^-x = 0")
println("Bisekcja: ", mbisekcji(x -> x * MathConstants.e^(-x), -0.5, 1.0, 1e-5, 1e-5))
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 0.5, 1e-5, 1e-5, 20))
println("Sieczne: ", msiecznych(x -> x * MathConstants.e^(-x), -0.5, 1.0, 1e-5, 1e-5, 20))

#podpunkt 3
println("e^(1 - x) - 1 = 0")
println("Metoda stycznych: ", mstycznych(x -> MathConstants.e^(1 - x) - 1, x -> -MathConstants.e^(1 - x), 1.5, 1.0e-4, 1.0e-4, 200))
println("Metoda stycznych: ", mstycznych(x -> MathConstants.e^(1 - x) - 1, x -> -MathConstants.e^(1 - x), 3.0, 1.0e-4, 1.0e-4, 200))
println("Metoda stycznych: ", mstycznych(x -> MathConstants.e^(1 - x) - 1, x -> -MathConstants.e^(1 - x), 5.0, 1.0e-4, 1.0e-4, 200))
println("Metoda stycznych: ", mstycznych(x -> MathConstants.e^(1 - x) - 1, x -> -MathConstants.e^(1 - x), 7.5, 1.0e-4, 1.0e-4, 200))
println("Metoda stycznych: ", mstycznych(x -> MathConstants.e^(1 - x) - 1, x -> -MathConstants.e^(1 - x), 10.0, 1.0e-4, 1.0e-4, 200))
println("Metoda stycznych: ", mstycznych(x -> MathConstants.e^(1 - x) - 1, x -> -MathConstants.e^(1 - x), 20.0, 1.0e-4, 1.0e-4, 200))


#podpunkt 4
println("x * e^-x = 0")
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 1.5, 1e-5, 1e-5, 200))
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 3.0, 1e-5, 1e-5, 200))
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 5.0, 1e-5, 1e-5, 200))
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 7.5, 1e-5, 1e-5, 200))
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 8.0, 1e-5, 1e-5, 200))
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 100.0, 1e-5, 1e-5, 200))
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 500.0, 1e-5, 1e-5, 200))


#podpunkt 5
println("x * e^-x = 0, x_0=1.0")
println("Styczne: ", mstycznych(x -> x * MathConstants.e^(-x), x -> MathConstants.e^(-x) - x * MathConstants.e^(-x), 1.0, 1e-5, 1e-5, 200))
