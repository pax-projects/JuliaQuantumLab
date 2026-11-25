# ============================================================
# Type structure
# ------------------------------------------------------------
struct EvolutionIterator
    circuit::QuantumCircuit
    base_state::QuantumState
    start_layer::Int
    end_layer::Int
end

# ============================================================
# Main logic
# ------------------------------------------------------------
"""
"""
function apply_layer(
    layer::CircuitLayer,
    state::QuantumState
)::QuantumState

    for (gate, involved_qubits) in layer
        state = apply_gate(state, gate, involved_qubits)
        println("Applying $gate on qubits: $involved_qubits")
    end

    return state
end


"""
"""
function evolve(
    circuit::QuantumCircuit,
    base_state::QuantumState;
    start_layer::Int = 1,
    end_layer::Int = length(circuit.layers)
)::EvolutionIterator

    return EvolutionIterator(
        circuit,
        base_state,
        start_layer,
        end_layer
    )
end


# ============================================================
# Iterators
# ------------------------------------------------------------
"""
"""
function Base.iterate(iter::EvolutionIterator)

    iter.start_layer > iter.end_layer && return nothing

    state = deepcopy(iter.base_state)

    # Precedent layers calculation
    for i in 1:(iter.start_layer - 1)
        state = apply_layer(iter.circuit.layers[i], state)
    end

    # Computing first required layer
    state = apply_layer(
        iter.circuit.layers[iter.start_layer],
        state
    )

    return deepcopy(state), (iter.start_layer + 1, state)
end


"""
"""
function Base.iterate(iter::EvolutionIterator, cursor)

    layer_index, state = cursor

    layer_index > iter.end_layer && return nothing

    state = apply_layer(
        iter.circuit.layers[layer_index],
        state
    )

    return deepcopy(state), (layer_index + 1, state)
end

