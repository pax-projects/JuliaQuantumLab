using Test
using JuliaQuantumLab

@testset "JuliaQuantumLab Tests" begin

    @testset "Quantum States" begin
        include("states/state_tests.jl")
    end

    @testset "Quantum Gates" begin
        include("gates/pauli_tests.jl")
        include("gates/hadamard_tests.jl")
    end

    @testset "Quantum Circuits" begin
        include("circuits/circuit_tests.jl")
    end

    @testset "Quantum Simulator" begin
        include("simulator/simulator_tests.jl")
    end

end
