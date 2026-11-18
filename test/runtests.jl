using Test
using JuliaQuantumLab

@testset "JuliaQuantumLab Tests" begin

    # QuantumState
    include("states/state_tests.jl")

    # Quantum Gates
    include("gates/pauli_tests.jl")
    include("gates/hadamard_tests.jl")

    # Quantum Circuits
    include("circuits/circuit_tests.jl")

    # Quantum Simulator
    include("simulator/simulator_tests.jl")
end
