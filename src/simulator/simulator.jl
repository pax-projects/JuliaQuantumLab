struct Simulator

    current_state::QuantumState

    shots::Int

    seed::Int

    function Simulator(base_state::QuantumState, shots::Int; seed::Int = 42)
        new(
            base_state,
            shots,
            seed
        )
    end
end


"""
    simulate(circuit)

Simulate a circuit.
"""
function simulate(
    simulator::Simulator,
    circuit::QuantumCircuit
)::QuantumState

    for layer in circuit.layers
        # TODO Multithread this loop
        for gate in layer
            current_state = apply_gate(gate[1], current_state)
        end
    end

    return current_state
end
