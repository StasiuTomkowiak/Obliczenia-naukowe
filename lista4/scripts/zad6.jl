#Stanisław Tomkowiak
#272345

include("interpolacja.jl")
using .Interpolacja

#rysujNnfx(x -> abs(x), -1.0, 1.0, 5)
#rysujNnfx(x -> abs(x), -1.0, 1.0, 10)
#rysujNnfx(x -> abs(x), -1.0, 1.0, 15)


rysujNnfx(x -> 1/(1+x*x), -5.0, 5.0, 5)
rysujNnfx(x -> 1/(1+x*x), -5.0, 5.0, 10)
rysujNnfx(x -> 1/(1+x*x), -5.0, 5.0, 15)



