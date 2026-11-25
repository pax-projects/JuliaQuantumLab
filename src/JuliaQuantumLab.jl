module JuliaQuantumLab

using LinearAlgebra
using Random

# Quantum gates
include("gates/abstract_gate.jl")
include("gates/pauli.jl")
include("gates/hadamard.jl")
include("gates/controlled_gates.jl")

# Quantum states
include("states/state.jl")
include("states/operations.jl")
include("states/gate_application.jl")

# Quantum circuit
include("circuit/circuit.jl")
include("circuit/evolution.jl")

# Quantum simulator
include("simulator/simulator.jl")
include("simulator/measurement.jl")

# Public API
# States
export QuantumState
export zero_state
export one_state
export basis_state
export nqubits
export probabilities

# Gates
export I, X, Y, Z, H
export CNOT

# Gate operations
export apply_gate

# Circuits
export QuantumCircuit
export add_gate
export EvolutionIterator, evolve

# Simulation
export Simulator
export simulate
end
