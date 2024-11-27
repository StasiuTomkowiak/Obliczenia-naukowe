#Stanisław Tomkowiak

function kahan_epsilon(T)
    return T(3.0) * (T(4.0) / T(3.0) - T(1.0)) - T(1.0)
end

println("Kahan epsilon for Float16: ", kahan_epsilon(Float16))
println("Machine epsilon for Float16: ", eps(Float16))

println("Kahan epsilon for Float32: ", kahan_epsilon(Float32))
println("Machine epsilon for Float32: ", eps(Float32))

println("Kahan epsilon for Float64: ", kahan_epsilon(Float64))
println("Machine epsilon for Float64: ", eps(Float64))

