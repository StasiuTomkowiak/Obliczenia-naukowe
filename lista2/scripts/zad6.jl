#Stanisław Tomkowiak
#272345

function func(c, x)
    x1 = x
    for i in 1:40
        x1 = Float64(x1^ 2) + c
        print(x1)
        println()
    end
end

println("iterations A")
func(Float64(-2.0), Float64(1.0))

println("iterations B")
func(Float64(-2.0), Float64(2.0))

println("iterations C")
func(Float64(-2.0), Float64(1.99999999999999))

println("iterations D")
func(Float64(-1.0), Float64(1.0))

println("iterations E")
func(Float64(-1.0), Float64(-1.0))

println("iterations F")
func(Float64(-1.0), Float64(0.75))

println("iterations G")
func(Float64(-1.0), Float64(0.25))
