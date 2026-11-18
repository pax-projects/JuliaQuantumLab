module JuliaQuantumLab

using LinearAlgebra
using Random

# Quantum states
include("states/state.jl")
include("states/operations.jl")

# Quantum gates
include("gates/pauli.jl")
include("gates/hadamard.jl")
include("gates/controlled.jl")

# Quantum circuits
include("circuits/circuit.jl")

# Quantum simulator
include("simulator/simulator.jl")
include("simulator/measurement.jl")

# Public API
export QuantumState
export nqubits
export probabilities
export zero_state
export one_state
export basis_state

end
