#Stanisław Tomkowiak
#272345

using Polynomials

#wspolczynniki wielomianu
p=[1, -210.0, 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]

#obliczanie wartości P(zk)
function P(x)
    result =1.0
    for i in 1:20
        result *=(x-i)
    end
    return result
end

#główna funkcja do obliczania pierwaistków oraz zwracania wynikow abs p(zk) P(zk) oraz zk-k
function Zero(p)
    zero=roots(p)
    println("k;P(z_k);p(z_k);z_k-k;roots")
    for i in 1:20
        print(i)
        print("; ")
        print(abs(p(zero[i])))
        print("; ")
        print(abs(P(zero[i])))
        print("; ")
        print(abs(zero[i] - i))
        print("; ")
        print(zero[i])
        println()
    end
end
#podpunkt A
polynomial=Polynomial(reverse(p))
Zero(polynomial)


#podpunkt B
p[2] -= 2 ^ (-23)
polynomial=Polynomial(reverse(p))
Zero(polynomial)