const Controllers   = Vector{Int}
const Targets       = Vector{Int}

const CircuitGate   = Tuple{AbstractGate, Controllers, Targets}
const CircuitLayer  = Vector{CircuitGate}
const CircuitLayers = Vector{CircuitLayer}


"""
    QuantumCircuit(nqubits)

Represent a quantum circuit of n qubits.
All qubits are initialized to |0⟩.
"""
struct QuantumCircuit

    nqubits::Int
    layers::CircuitLayers
    next_gate_layer::Vector{Int}

    function QuantumCircuit(nqubits::Int)
        nqubits > 0 || throw(ArgumentError("nqubits must be positive"))

        new(
            nqubits,
            CircuitLayer[],
            ones(Int, nqubits)
        )
    end

end

"""
    add_gate!(circuit, gate, ctrls, trgts)

Add a gate to the circuit.
The gate is automatically placed in the earliest available layer.
"""
function add_gate!(
    circuit::QuantumCircuit,
    gate::AbstractGate,
    ctrls::Controllers,
    trgts::Targets
) :: QuantumCircuit
    # Get involved qubits
    qubits = union(ctrls, trgts)

    isempty(qubits) &&
        throw(ArgumentError("A gate must involve at least one qubit"))

    # Check qubit indices
    for q in qubits
        1 <= q <= circuit.nqubits ||
            throw(BoundsError(circuit.next_gate_layer, q))
    end

    # Check duplicate qubits
    length(qubits) == length(ctrls) + length(trgts) ||
        throw(ArgumentError("Duplicate qubit indices"))

    # Get earliest available layer
    layer_idx = maximum(circuit.next_gate_layer[qubits])

    # Create gate
    circuit_gate = (gate, copy(ctrls), copy(trgts))

    # Create a new layer if necessary
    if layer_idx > length(circuit.layers)
        push!(circuit.layers, CircuitLayer[])
    end

    # Insert gate into layer
    push!(circuit.layers[layer_idx], circuit_gate)

    # Update next available layer for involved qubits
    circuit.next_gate_layer[qubits] .= layer_idx + 1

    return circuit
end

