#Stanisław Tomkowiak

#zachowanie przedzialow z zadania (1<x<2)
x=nextfloat(Float64(1.0))

#sprawdzenanie kolejnych liczb
while(x*(1/x)==1 && x<Float64(2.0))
    global x=nextfloat(Float64(x))
end

#zwrocenie najmniejszej liczby z warunkow zadania (takeij ktora pomnozona przez odwrotnosc nie jest rowna 1)
println(x)
#zwrocenie odwrotnosci
println(1/x)
#sprawdzenie czy faktycznie liczba jezt rozna od 1
println(x*(1/x))