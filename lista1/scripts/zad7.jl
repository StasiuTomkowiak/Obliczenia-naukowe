#Stanisław Tomkowiak

function derivative(x, h)
    return (Float64(sin(x+h))+Float64(cos(Float64(3.0)*(x+h)))-(Float64(sin(x))+Float64(cos(Float64(3.0)*x))))/h
end

function real_derivative(x)
    return Float64(cos(x))-Float64(3.0)*Float64(sin(Float64(3.0)*x))
end

println("n  h    h+1     derivative          error")

real=real_derivative(Float64(1.0))
for n in 1:54
    h=Float64(2.0^-n)
    df=derivative(Float64(1.0),h)
    error=abs(real-df)
    println("$n $h  $(h+1)   $df     $error")
end