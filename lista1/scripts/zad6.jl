#Stanisław Tomkowiak

function f(x)
    return sqrt(Float64(x^2)+Float64(1.0))-Float64(1.0)
end
function g(x)
    return Float64(x^2)/(sqrt(Float64(x^2)+Float64(1.0))+Float64(1.0))
end

for i in 1:200
    x=Float64(8.0)^(-i)
    fx=f(x)
    gx=g(x)
    println("i = ", i, " x = ", x, " f(x) = ", fx, " g(x) = ", gx)
end