using Test, DN2

@testset "trapezna_metoda" begin 
    @test isapprox(integralski_sinus_trapezno(0), 0, atol=1e-10)
    @test isapprox(integralski_sinus_trapezno(0.5), 0.49310741804, atol=1e-10)
    @test isapprox(integralski_sinus_trapezno(1.0), 0.94608307037, atol=1e-10)
    @test isapprox(integralski_sinus_trapezno(1.5), 1.3246835312, atol=1e-10)
    @test isapprox(integralski_sinus_trapezno(5.0), 1.5499312449, atol=1e-10)
    @test isapprox(integralski_sinus_trapezno(8.0), 1.5741868217, atol=1e-10)
end


@testset "simpsonova_metoda" begin 
    @test isapprox(integralski_sinus_simpson(0), 0, atol=1e-10)
    @test isapprox(integralski_sinus_simpson(0.5), 0.49310741804, atol=1e-10)
    @test isapprox(integralski_sinus_simpson(1.0), 0.94608307037, atol=1e-10)
    @test isapprox(integralski_sinus_simpson(1.5), 1.3246835312, atol=1e-10)
    @test isapprox(integralski_sinus_simpson(5.0), 1.5499312449, atol=1e-10)
    @test isapprox(integralski_sinus_simpson(8.0), 1.5741868217, atol=1e-10)
end


@testset "bezierove točke" begin
    kontrolni_poligon = [[0,0],[1,1],[2,3],[1,4],[0,4],[-1,3],[0,1],[1,0]]
    v1 = [0, 0]
    v2 = [1, 0]

    @test isapprox(bezierova_krivulja(0, kontrolni_poligon), v1, atol=1e-10)
    @test isapprox(bezierova_krivulja(1, kontrolni_poligon), v2, atol=1e-10)
end