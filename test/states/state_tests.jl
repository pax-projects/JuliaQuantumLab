@testset "QuantumState Tests" begin

    @testset "QuantumState construction" begin

        state = QuantumState([1, 0])

        @test state.amplitudes == ComplexF64[1, 0]
        @test nqubits(state) == 1

    end

    @testset "Basis states" begin

        state_0 = zero_state()
        state_1 = one_state()

        @test state_0.amplitudes == ComplexF64[1, 0]
        @test state_1.amplitudes == ComplexF64[0, 1]

    end

    @testset "Multiple qubits" begin

        state = basis_state(2, 2)

        @test nqubits(state) == 2
        @test state.amplitudes == ComplexF64[0, 0, 1, 0]

    end

    @testset "Normalization" begin

        amplitudes = ComplexF64[
            1 / sqrt(2),
            1 / sqrt(2)
        ]

        state = QuantumState(amplitudes)

        @test sum(probabilities(state)) ≈ 1.0

    end

    @testset "Invalid states" begin

        @test_throws ArgumentError QuantumState([1, 1])
        @test_throws ArgumentError QuantumState([1, 0, 0])
        @test_throws ArgumentError QuantumState([0, 0])
        @test_throws ArgumentError basis_state(2, 4)

    end

end
