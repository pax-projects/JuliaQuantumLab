"""
    QuantumCircuit(nqubits)

Represent a quantum circuit of n qubits.
All qubits are initialized to |0⟩.
"""
struct QuantumCircuit

    nqubits::UInt8

    function QuantumCircuit(nqubits::UInt8)
        new(nqubits)
    end

end
