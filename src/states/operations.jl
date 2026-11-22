"""
    nqubits(state::QuantumState)

Return the number of qubits represented by the state.
"""
function nqubits(state::QuantumState)
    return trailing_zeros(length(state.amplitudes))
end


"""
    probabilities(state::QuantumState)

Return the measurement probabilities of each computational basis state.
"""
function probabilities(state::QuantumState)
    return abs2.(state.amplitudes)
end


"""
    zero_state(nqubits=1)

Create the |00...0⟩ computational basis state.
"""
function zero_state(n::Integer=1)

    if n < 1
        throw(ArgumentError("Number of qubits must be positive."))
    end

    amplitudes = zeros(ComplexF64, 2^n)
    amplitudes[1] = 1.0 + 0.0im

    return QuantumState(amplitudes)
end


"""
    one_state()

Create the |1⟩ computational basis state.
"""
function one_state()

    amplitudes = ComplexF64[0, 1]

    return QuantumState(amplitudes)
end


"""
    basis_state(nqubits, index)

Create a computational basis state.

The index uses zero-based computational basis notation.
"""
function basis_state(n::Integer, index::Integer)

    if n < 1
        throw(ArgumentError("Number of qubits must be positive."))
    end

    if index < 0 || index >= 2^n
        throw(ArgumentError("Basis index is out of range."))
    end

    amplitudes = zeros(ComplexF64, 2^n)
    amplitudes[index + 1] = 1.0 + 0.0im

    return QuantumState(amplitudes)
end

