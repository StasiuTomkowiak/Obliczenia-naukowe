#Stanisław Tomkowiak
#272345

include("interpolacja.jl")
using .Interpolacja

rysujNnfx(x -> MathConstants.e^x, 0.0, 1.0, 5)
rysujNnfx(x -> MathConstants.e^x, 0.0, 1.0, 10)
rysujNnfx(x -> MathConstants.e^x, 0.0, 1.0, 15)

#rysujNnfx(x -> sin(x)*x*x, -1.0, 1.0, 5)
#rysujNnfx(x -> sin(x)*x*x, -1.0, 1.0, 10)
#rysujNnfx(x -> sin(x)*x*x, -1.0, 1.0, 15)
