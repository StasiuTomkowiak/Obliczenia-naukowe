#Stanisław Tomkowiak
#272345

include("interpolacja.jl")
using .Interpolacja


println(ilorazyRoznicowe([0.0, 1.0], [0.0, 1.0]))
println(ilorazyRoznicowe([3.0, 1.0, 5.0,6.0], [1.0, -3.0, 2.0,4.0]))
println(ilorazyRoznicowe([-1.0, 0.0, 1.0,2.0], [2.0, 1.0, 2.0,-7.0]))

println(warNewton([-1.0, 0.0, 1.0,2.0], [2.0, -1.0, 1.0, -2.0],0.0))
println(warNewton([-1.0, 0.0, 1.0,2.0], [2.0, -1.0, 1.0, -2.0],1.0))
println(warNewton([-1.0, 0.0, 1.0,2.0], [2.0, -1.0, 1.0, -2.0],2.0))
println(warNewton([-1.0, 0.0, 1.0,2.0], [2.0, -1.0, 1.0, -2.0],-1.0))

println(warNewton([1.0, 2.0, 3.0], [1.0, 4.0, 9.0], 2.0))
println(warNewton([3.0, 1.0, 5.0], [1.0, -3.0, 2.0], 2.0))


println(naturalna([0.0, 2.0, 3.0,4.0,6.0], [1.0, 1.0, -0.66,0.66,-0.22]))
println(naturalna([3.0, 1.0, 5.0,6.0], [1.0, 2.0, -0.375, 0.175]))
println(naturalna([1.0, 2.0, 3.0], [1.0, 4.0, 9.0]))
println(naturalna([3.0, 1.0, 5.0], [1.0, -3.0, 2.0]))


