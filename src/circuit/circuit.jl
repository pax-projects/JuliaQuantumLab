const CircuitGate   = Tuple{AbstractGate, Vector{Int}}
const CircuitLayer  = Vector{CircuitGate}
const CircuitLayers = Vector{CircuitLayer}


"""
    QuantumCircuit(nqubits)

Represent a quantum circuit of n qubits.
"""
struct QuantumCircuit

    nqubits::Int
    nbits  ::Int

    layers::CircuitLayers
    next_gate_layer::Vector{Int}

    function QuantumCircuit(nqubits::Int, nbits::Int)
        nqubits > 0 || throw(ArgumentError("nqubits must be positive"))
        nbits >= 0  || throw(ArgumentError("nbits must be positive"))

        new(
            nqubits,
            nbits,
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
function add_gate(
    circuit::QuantumCircuit,
    gate::AbstractGate,
    qubits::Vector{Int}
)::QuantumCircuit
    isempty(qubits) &&
        throw(ArgumentError("A gate must involve at least one qubit"))

    # Check qubit indices
    for q in qubits
        1 <= q <= circuit.nqubits ||
            throw(BoundsError(circuit.next_gate_layer, q))
    end

    # Get earliest available layer
    layer_idx = maximum(circuit.next_gate_layer[qubits])

    # Create gate
    circuit_gate = (gate, copy(qubits))

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


"""
    measure(circuit, qubit, bit)

Add a measure gate from qubit to bit.
In other words, the qubit parameter is measure and
its value is set into the bit parameter.
"""
function measure(
    circuit::QuantumCircuit,
    qubit::Int,
    bit::Int
)::QuantumCircuit
    throw(error("measure function not implemented"))

    return circuit
end

