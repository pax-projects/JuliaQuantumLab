"""
    apply_gate(state, gate, targets)

Apply gate to the state by creating a new state gate(state).

Algorithm idea from:
https://www.cda.cit.tum.de/images/mqsf2025/talks/10_Khaldoon_Ghanem_NVIDIA.pdf
"""
function apply_gate(state, gate, targets)::QuantumState

    groups = substate_indices(state.nqubits, targets)

    new_state = similar(state.amplitudes)

    for indices in groups

        # Gather
        substate = state.amplitudes[indices]

        # Compute
        result = matrix(gate) * substate

        # Scatter
        new_state[indices] = result

    end

    return QuantumState(new_state)
end
