# Stanisław Tomkowiak
#272345
module Interpolacja


export ilorazyRoznicowe

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})

    fx=copy(f)
    len=length(x)
    for j in 1:(len)
        for i in (len):-1:j+1
            fx[i] = (fx[i] - fx[i-1]) / (x[i] - x[i-j])
        end
    end

    
return fx
end
end

