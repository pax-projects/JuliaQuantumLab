using JuliaQuantumLab

circuit = QuantumCircuit(2, 0)
base_state = zero_state(2)

JuliaQuantumLab.add_gate(circuit, H, [1])
JuliaQuantumLab.add_gate(circuit, CNOT, [1, 2])

# Circuit evolution through layers
evolution::JuliaQuantumLab.EvolutionIterator = evolve(circuit, deepcopy(base_state))

println(base_state)

for state in evolution
    println(state)
end

# TODO:
"""
# Circuit simulation through multiple shots
simulator = Simulator(zero_state(2), shots = 512)

# println(probabilities(circuit.current_state))
# post_sim_state = simulate(circuit)
#
# probs = probabilities(post_sim_state)
# println(probs)
"""

