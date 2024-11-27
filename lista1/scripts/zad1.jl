#Stanisław Tomkowiak

function macheps(T,start)
    macheps=T(1.0)
    while T(start) + (macheps / T(2.0)) > T(start)
        macheps /= T(2.0)
    end
    return macheps
end

function max(T)
    max=prevfloat(T(1.0))
    while !isinf(max*T(2.0))
        max*=T(2.0)
    end
    return max
end


# Podpunkt 1 (macheps)
macheps16=macheps(Float16,Float16(1.0))
println("Float16 iterative macheps = $macheps16")
macheps16=eps(Float16)
println("Float16 real macheps = $macheps16")

macheps32=macheps(Float32,Float32(1.0))
println("Float32 iterative macheps = $macheps32")
macheps64=eps(Float32)
println("Float32 real macheps = $macheps32")

macheps64=macheps(Float64,Float64(1.0))
println("Float64 iterative macheps = $macheps64")
macheps64=eps(Float64)
println("Float64 real macheps = $macheps64")

# Podpunkt 2 (eta)
println("")
eta16=macheps(Float16,Float16(0.0))
println("Float16 iterative eta = $eta16")
eta16=nextfloat(Float16(0.0))
println("Float16 real eta = $eta16")

eta32=macheps(Float32,Float32(0.0))
println("Float32 iterative eta= $eta32")
eta32=nextfloat(Float32(0.0))
println("Float32 real eta = $eta32")

eta64=macheps(Float64,Float64(0.0))
println("Float64 iterative eta = $eta64")
eta64=nextfloat(Float64(0.0))
println("Float64 real eta = $eta64")

# Podpunkt 3 (floatmin) 
println("")
floatmin_var=floatmin(Float32)
println("floatmin32: $floatmin_var")
floatmin_var=floatmin(Float64)
println("floatmin64: $floatmin_var")

#Podpunkt 4 (floatmax)
println("")
max_var=max(Float16)
println("Max16 iterative: $max_var")
max_var=floatmax(Float16)
println("Max16 real: $max_var")
max_var=max(Float32)
println("Max32 iterative: $max_var")
max_var=floatmax(Float32)
println("Max32 real: $max_var")
max_var=max(Float64)
println("Max64 iterative: $max_var")
max_var=floatmax(Float64)
println("Max64 real: $max_var")