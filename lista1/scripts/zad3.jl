#Stanisław Tomkowiak

function check_values(start, delta, func)
    for _ in 1:100
        if func(start) != start + delta
            return false
        end
        start = func(start)
    end
    return true
end

function delta(start,last)
    startdelta = SubString(bitstring(start), 2:12)
    lastdelta = SubString(bitstring(last), 2:12)
    if (startdelta!= lastdelta)
        return false
    end

    return ((2.0^(parse(Int, startdelta, base = 2) - 1023))*2.0^(-52))
end

# Sprawdzamy na początku przedziału [1, 2]
one = check_values(Float64(1.0), Float64(2^-52), nextfloat)
println("Czy na początku przedziału [1, 2] są równomiernie rozłożone: $one")

# Sprawdzamy na końcu przedziału [1, 2]
two = check_values(Float64(2.0), -Float64(2^-52), prevfloat)
println("Czy na końcu przedziału [1, 2] są równomiernie rozłożone: $two")

#Dwojkowe zapisy liczb 1.0 i najwiekszej liczby przed 1 i najmniejszej po 1
println("Dwojkowe zapisy liczb 1.0 i najwiekszej liczby przed 1 i najmniejszej po 1")
println(bitstring(prevfloat(Float64(1.0))))
println(bitstring(Float64(1.0)))
println(bitstring(nextfloat(Float64(1.0))))


##Sprawdzamy rozlozenie liczb w przedzialach [0.5, 1] 
delta_value = delta(Float64(0.5), prevfloat(Float64(1.0)))
println("Delta: $delta_value")

# Sprawdzamy na początku przedziału [0.5, 1] 
one = check_values(Float64(0.5), Float64(2^-53), nextfloat)
println("Czy na początku przedziału [0.5, 1] są równomiernie rozłożone: $one")

# Sprawdzamy na końcu przedziału [0.5, 1] 
two = check_values(Float64(1.0), -Float64(2^-53), prevfloat)
println("Czy na końcu przedziału [0.5, 1] są równomiernie rozłożone: $two")

##Sprawdzamy rozlozenie liczb w przedzialach [2.0, 4.0] 
delta_value = delta(Float64(2.0), prevfloat(Float64(4.0)))
println("Delta: $delta_value")

# Sprawdzamy na początku przedziału [2.0, 4.0] 
one = check_values(Float64(2.0), Float64(2^-51), nextfloat)
println("Czy na początku przedziału [2.0, 4.0]  są równomiernie rozłożone: $one")

# Sprawdzamy na końcu przedziału [2.0, 4.0] 
two = check_values(Float64(4.0), -Float64(2^-51), prevfloat)
println("Czy na końcu przedziału [2.0, 4.0]  są równomiernie rozłożone: $two")
