# Stanisław Tomkowiak
#272345
module Interpolacja

using Plots

export ilorazyRoznicowe,warNewton,naturalna,rysujNnfx

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

function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    len = length(fx)  
    a=copy(fx)

    for i in (len-1):-1:1
        a[i]=fx[i]-a[i+1]*x[i]
        for j in (i+1):len-1
            a[j] = a[j] - a[j+1]*x[i]
        end
    end   
    return a  # Zwróć współczynniki postaci naturalnej
end
function rysujNnfx(f,a::Float64,b::Float64,n::Int)
      
    step = (b - a) / n
    xnodes = [a + i * step for i in 0:n]
    ynodes = f.(xnodes)
    coefnodes = ilorazyRoznicowe(xnodes, ynodes)
    nodes = [warNewton( xnodes,coefnodes, x) for x in xnodes]  

    step = (b-a)/500
    xstep= [a + i * step for i in 0:500]
    ystep_real = f.(xstep)  
    ystep_inter = [warNewton( xnodes,coefnodes, x) for x in xstep]

    plot(xstep, ystep_real, label="f(x) (dokładna)")
    plot!(xstep, ystep_inter, label="Wielomian interpolacyjny", lw=2, linestyle=:dash, color=:red)
    scatter!(xnodes, nodes, label="Węzły interpolacyjne",color=:black, marker=:circle, ms=4)
    savefig("z6_2_$n.pdf")
end
end
