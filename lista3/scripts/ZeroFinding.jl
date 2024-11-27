# Stanisław Tomkowiak
#272345
module ZeroFinding

export mbisekcji,mstycznych,msiecznych
ITERATIONS = 10^9
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    if b < a
        a, b = b, a
    end

    u = f(a)
    v = f(b)
    if sign(u)==sign(v)
        return 0.0, 0.0, 0, 1
    end
    k=0
    c=0
    w=0
    e=b-a
    for k in 1:ITERATIONS
        e=e/2
        c=a+e
        w=f(c)
        if abs(e)<delta || abs(w)<epsilon
            return c,w,k,0
        end
        if sign(w)!=sign(u)
            b=c
            v=w
        else
            a=c
            u=w
        end    
    end   
    return c, w, k, 0        
end
function mstycznych(f,pf,x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    v=f(x0)
    if abs(v)<epsilon
        return x0,v,0,0
    end

    k=0
    xn=x0
    x1=x0
    for k in 1:maxit
        
        if abs(pf(x0)) < eps(Float64)
            return 0.0, 0.0, 0, 2
        end
        x1=x0-(v/pf(x0))
        v=f(x1)
        
        if abs(x1-x0)<delta || abs(v)<epsilon
            return x1,v,k,0
        end
    x0=x1
    end
    return x1,v,k,1
end
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    fa=f(x0)
    fb=f(x1)
    
    k=0
    for k in 1:maxit
        if abs(fa)>abs(fb)
            x0,x1=x1,x0
            fa,fb=fb,fa
        end
        s=(x1-x0)/(fb-fa)
        x1=x0
        fb=fa
        x0=x0-(fa*s)
        fa=f(x0)
        if abs(x1-x0)<delta || abs(fa)<epsilon
            return x0,fa,k,0
        end
    end
    return x0,fa,k,1
end
end
