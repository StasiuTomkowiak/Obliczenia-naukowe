#Stanisław Tomkowiak
#272345

function rec(p,r,T)
    return T(p + T(r*T(p*T(1 - p))))
end

#podpunkt 1
p1=Float32(0.01)
p2=Float32(0.01)
r=Float32(3.0)
println("n;p1;p2")
for i in 1:40
    global p1=rec(p1,r,Float32)
    global p2=rec(p2,r,Float32)
    if i==10
        global p2= floor(p2, digits=3)
    end
    
    println(i,";", p1, ";",p2)
end

#podpunkt 2
p1=Float32(0.01)
p2=Float64(0.01)
r1=Float32(3.0)
r2=Float64(3.0)
println("n;p1;p2")
for i in 1:40
    global p1=rec(p1,r1,Float32)
    global p2=rec(p2,r2,Float64)
    println(i,";", p1, ";",p2)
end