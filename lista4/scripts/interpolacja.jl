# Stanisław Tomkowiak
#272345
module Interpolacja


export ilorazyRoznicowe,warNewton

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

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    
    len=length(x)
    nt=fx[len]
    for i in (len)-1:-1:1
        nt=nt*(t-x[i])+fx[i] 
    end
    return nt
end
end

