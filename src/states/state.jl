"""
    QuantumState(amplitudes)

Represent a pure quantum state using a state vector.

The state vector must:
- Have a power-of-two dimension.
- Contain finite complex amplitudes.
- Be normalized (unit norm).
"""
struct QuantumState

    amplitudes::Vector{ComplexF64}

    function QuantumState(amplitudes::AbstractVector{<:Number})

        # Convert amplitudes to ComplexF64
        state_vector = ComplexF64.(amplitudes)

        # Check vector dimension
        dimension = length(state_vector)

        if dimension < 2 || !ispow2(dimension)
            throw(ArgumentError(
                "State vector dimension must be a power of 2 and at least 2."
            ))
        end

        # Check finite amplitudes
        if !all(isfinite, state_vector)
            throw(ArgumentError(
                "State amplitudes must be finite."
            ))
        end

        # Check normalization
        state_norm = sum(abs2, state_vector)

        if !isapprox(state_norm, 1.0; atol=1e-10, rtol=1e-10)
            throw(ArgumentError(
                "Quantum state must be normalized. Squared norm = $state_norm"
            ))
        end

        new(state_vector)
    end
end
