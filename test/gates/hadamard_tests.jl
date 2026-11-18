@testset "Hadamard Gate Tests" begin

    @testset "Hadamard" begin
        zero = zero_state()
        one  = one_state()

        H_zero = apply_gate(H, zero)
        H_one  = apply_gate(H, one)

        @test H_zero.amplitudes == (1 / sqrt(2)) * ComplexF64[1, 1]
        @test H_one.amplitudes  == (1 / sqrt(2)) * ComplexF64[1, -1]
    end

    @testset "Hadamard squared = Id" begin
        H_matrix = JuliaQuantumLab.matrix(H)

        @test isapprox(H_matrix ^ 2, Matrix{ComplexF64}(I, 2, 2); atol=1e-10)
    end

end
