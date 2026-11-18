module JuliaQuantumLab

using LinearAlgebra
using Random

# Quantum gates
include("gates/abstract_gate.jl")
include("gates/pauli.jl")
include("gates/hadamard.jl")
include("gates/controlled.jl")

# Quantum states
include("states/state.jl")
include("states/operations.jl")

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

export I
export X
export Y
export Z
export H

export apply_gate

end
