module DN2

export integralski_sinus_trapezno
export integralski_sinus_simpson
export bezierova_krivulja

using Plots

"""
    f(x)

Pomožna funkcija, ki predstavlja funkcijo, ki jo integriramo. V našem primeru sin(x)/x.
"""

function f(x)
    if x == 0
        return 1
    else
        return sin(x) / x
    end
end


"""
    integralski_sinus_trapezno(x, n)

Funkcija, ki izračuna integral funkcije sin(t)/t na intervalu od 0 do x, v `n` točkah, z uporabo Trapezne metode. Rezultat 
izračuna na 10 decimalk, z relativno natančnostjo 10^(−10).

Primer: vhod: integralski_sinus_trapezno(0.5) 
        izhod: 0.493107418
"""

function integralski_sinus_trapezno(x, n = 500000)
    a = 0
    b = x
    h = (b − a)/n
    T = (f(a) + f(b))/2
    for i = 1 : n − 1
        c= i*h
        T = T + f(a + c)
    end
    T1 = T * h
    T = round(T1; digits = 10)
end



"""
    integralski_sinus_simpson(x, n)

Funkcija, ki izračuna integral funkcije sin(t)/t na intervalu od 0 do x, v `n` točkah, z uporabo Simpsonove metode. 
Rezultat izračuna na 10 decimalk, z relativno natančnostjo 10^(−10).

Primer: vhod: integralski_sinus_simpson(0.5) 
        izhod: 0.493107418
"""

function integralski_sinus_simpson(x, n = 10000)
    a = 0
    b = x
    h = (b − a)/(2 * n)
    S = f(a) + f(b) + 4 * f(a + h)
    for i = 1 : n − 1
        S = S + 2 * f(a + 2 * i * h) + 4 * f(a + 2 * i * h + h)
    end
    S = round(S * h/3; digits = 10)
end

"""
    izris_trapezna()

Funkcija, ki za dane vhodne vrednosti `x` preveri na koliko podintervalov (od danih možnosti) rabimo razdeliti dani 
interval, da dobimo rezultat z relativno natačnostjo `1e-10`. 
Uporablja trapezno metodo. 
Na koncu izriše graf odvisnosti števila podintervalov za vhodne vrednosti za trapezno metodo.
"""

function izris_trapezna()
    x_osa = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    rezultati = [0, 0.9460830704, 1.6054129768, 1.848652528, 1.7582031389, 1.5499312449, 1.4246875513, 1.4545966142, 1.5741868217, 1.6650400758, 1.6583475942]
    br = 0
    y_trapez = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for x in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        br = br + 1
        for n in [10, 100, 1000, 10000, 100000, 200000, 300000, 400000, 500000]
            #println(br)
            if isapprox(integralski_sinus_trapezno(x, n), rezultati[br], atol=1e-10)
                y_trapez[br] = n
                break
            end
        end
    end
    #println(y)
    #return y
    plot(x_osa, y_trapez, xlabel="vhodna vrednost", ylabel="število podintervalov (n)", title="Trapezna metoda: odvisnost števila podintervalov od vhodne vrednosti", titlefont = font(9))

end

"""
    izris_simpsonova()

Funkcija, ki za dane vhodne vrednosti `x` preveri na koliko podintervalov (od danih možnosti) rabimo razdeliti dani 
interval, da dobimo rezultat z relativno natačnostjo `1e-10`. 
Uporablja Simpsonovo metodo. 
Na koncu izriše graf odvisnosti števila podintervalov za vhodne vrednosti za Simpsonovo metodo.
"""

function izris_simpsonova()
    x_osa = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    rezultati = [0, 0.9460830704, 1.6054129768, 1.848652528, 1.7582031389, 1.5499312449, 1.4246875513, 1.4545966142, 1.5741868217, 1.6650400758, 1.6583475942]
    br = 0
    y_simpson = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for x in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        br = br + 1
        for n in [10, 100, 1000, 10000, 100000, 200000, 300000, 400000, 500000]
            if isapprox(integralski_sinus_simpson(x, n), rezultati[br], atol=1e-10)
                y_simpson[br] = n
                break
            end
        end
    end

    plot(x_osa, y_simpson, xlabel="vhodna vrednost", ylabel="število podintervalov (n)", title="Simpsonova metoda: odvisnost števila podintervalov od vhodne vrednosti", titlefont = font(9))

end


izris_trapezna()
izris_simpsonova()


"""
    bezierova_krivulja(t, tocke)

Funkcija, ki izračuna točko Bezierove krivulje (parametriranje) glede na kontrolni poligon in parameter t. 
`t` je parameter krivulje, ki je med 0 in 1. 

Primer: vhod: bezierova_krivulja(0.5, [[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]])
        izhod: 2-elementni vektor |0.5    |
                                  |3.28125|
"""

function bezierova_krivulja(t, tocke)
    n = length(tocke) - 1
    parametrizacija = zeros(2)
    for i = 0 : n
        parametrizacija = parametrizacija +  binomial(n, i) * (1 - t)^(n - i) * t^i * tocke[i + 1]
    end
    return parametrizacija
end

bezierova_krivulja(1, [[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]])


"""
    ploscina(kontrolne_tocek)

Funkcija, ki izračuna ploščino zanke, ki jo omejuje Bezierova krivulja dana s kontrolnim poligonom. 
Uporablja trapezno metodo, tako da med vsakim dvema zaporednima točkama na krivulji izračuna ploščino trapeza in 
potem sešteje ploščine vseh teh trapezov.

Primer: vhod: ploscina([[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]])
        izhod: 1.9666243931
"""

function ploscina(tocke)
    i = 0.01  
    povrsina = 0
    for t in 0:i:1
        tacka1 = bezierova_krivulja(t, tocke)
        tacka2 = bezierova_krivulja(t + i, tocke)
        h = (tacka1[1] - tacka2[1])
        trapez = (tacka1[2] + tacka2[2]) * h  / 2
        povrsina = povrsina + trapez
    end
    return round(povrsina; digits=10)
end

kontrolni_poligon = [[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]]
rezultat = ploscina(kontrolni_poligon)


end # module DN2
