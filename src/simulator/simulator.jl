"""
    apply_gate(gate, state)

Apply gate to the state by creating a new state gate(state).
"""
function apply_gate(gate::AbstractGate, state::QuantumState)
    gate_matrix = matrix(gate)

    if size(gate_matrix, 2) != length(state.amplitudes)
        throw(DimensionMismatch("Gate and state dimensions do not match."))
    end

    transformed = gate_matrix * state.amplitudes

    return QuantumState(transformed)
end
