#Stanisław Tomkowiak
#272345

x = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

function zadA(T, n)
    S = T(0.0)
    for i in 1:n
        S += T(x[i]) * T(y[i])
    end
    return S
end

function zadB(T, n)
    S = T(0.0)
    for i in n:-1:1
        S += T(x[i]) * T(y[i])
    end
    return S
end

function zadC(T, n)
 
    sums = [T(x[i]) * T(y[i]) for i in 1:n]

    pos_sum = T(sum(sort([s for s in sums if s >= 0], rev=true)))
    neg_sum = T(sum(sort([s for s in sums if s < 0])))

    return pos_sum + neg_sum
end

function zadD(T, n)
   
    sums = [T(x[i]) * T(y[i]) for i in 1:n]

    pos_sum = T(sum(sort([s for s in sums if s >= 0])))
    neg_sum = T(sum(sort([s for s in sums if s < 0], rev=true)))

    return pos_sum + neg_sum
end

println("Float32")
println("prawdziwe -1.00657107000000e-11")
A = Float32(zadA(Float32, 5))
println("W przod Float32: $A")
B = Float32(zadB(Float32, 5))
println("W tyl Float32: $B")
C= Float32(zadC(Float32, 5))
println("C Float32: $C")
D= Float32(zadD(Float32, 5))
println("D Float32: $D")

println("")
println("Float64")
println("prawdziwe -1.00657107000000e-11")
A = Float64(zadA(Float64, 5))
println("W przod Float64: $A")
B = Float64(zadB(Float64, 5))
println("W tyl Float64: $B")
C= Float64(zadC(Float64, 5))
println("C Float64: $C")
D= Float64(zadC(Float64, 5))
println("D Float64: $D")