@testset "Pauli Gates Tests" begin

    @testset "PauliX" begin
        zero = zero_state()
        one  = one_state()

        X_zero = apply_gate(X, zero)
        X_one  = apply_gate(X, one)

        @test X_zero.amplitudes == ComplexF64[0, 1]
        @test X_one.amplitudes  == ComplexF64[1, 0]
    end

    @testset "PauliY" begin
        zero = zero_state()
        one  = one_state()

        Y_zero = apply_gate(Y, zero)
        Y_one  = apply_gate(Y, one)

        @test Y_zero.amplitudes == ComplexF64[0, im]
        @test Y_one.amplitudes  == ComplexF64[-im, 0]
    end

    @testset "PauliZ" begin
        zero = zero_state()
        one  = one_state()

        Z_zero = apply_gate(Z, zero)
        Z_one  = apply_gate(Z, one)

        @test Z_zero.amplitudes == ComplexF64[1, 0]
        @test Z_one.amplitudes  == ComplexF64[0, -1]
    end

end
