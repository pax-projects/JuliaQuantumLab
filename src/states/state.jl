"""
    QuantumState(amplitudes)

Represent a pure quantum state using a state vector.

The state vector must:
- Have a power-of-two dimension.
- Contain finite complex amplitudes.
- Be normalized (unit norm).
"""
struct QuantumState

    nqubits::Int
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

        new(
            floor(Int, log2(length(amplitudes))),
            state_vector
        )
    end
end


"""
    substate_indices(n::Int, targets::Vector{Int}) -> Vector{Vector{Int}}

Generate groups of global state-vector indices according to the qubits targeted by a gate.

The function partitions the indices of a state vector of size `2^n` into
`2^(n-m)` groups, where `m` is the number of targeted qubits.

Each group contains `2^m` indices corresponding to all possible combinations
of the targeted qubits, while the non-targeted qubits remain fixed.

The indices follow these conventions:
- Qubits are numbered from `1` to `n`.
- Qubit `1` corresponds to the most significant bit (MSB).
- Qubit `n` corresponds to the least significant bit (LSB).
- Returned indices use Julia's 1-based indexing.
- The order of `targets` determines the bit ordering within each group.

# Arguments
- `n::Int`: Total number of qubits in the state vector.
- `targets::Vector{Int}`: Qubits targeted by the gate, in the order
  expected by its matrix representation.

# Returns
- `Vector{Vector{Int}}`: A collection of index groups.
  Each inner vector contains the global indices of the amplitudes
  belonging to one substate.

Every global index appears exactly once across all groups.

# Examples
```julia
julia> substate_indices(3, [1, 3])
2-element Vector{Vector{Int64}}:
 [1, 2, 5, 6]
 [3, 4, 7, 8]
```

For three qubits and targets `[1, 3]`, qubit `2` is not targeted.
Consequently, the first group corresponds to `q₂ = 0` and the second
to `q₂ = 1`.

The corresponding substates are:

```julia
v₀ = state.amplitudes[[1, 2, 5, 6]]
v₁ = state.amplitudes[[3, 4, 7, 8]]
```

# Throws
- `AssertionError`: If the number of targets exceeds the number of qubits,
  if a target is outside `1:n`, or if targets contain duplicates.

See also: `apply_gate`
"""
function substate_indices(n::Int, targets::Vector{Int})

    m = length(targets)

    @assert n >= m "More target qubits than available qubits"
    @assert all(q -> 1 <= q <= n, targets) "Invalid target qubit"
    @assert length(unique(targets)) == m "Duplicate target qubits"

    non_targets = filter(q -> !(q in targets), 1:n)

    # Groups allocation
    groups = [
        Vector{Int}(undef, 1 << m)
        for _ in 1:(1 << (n-m))
    ]

    # Position of each qubits in its respective group
    target_positions = Dict(q => j for (j, q) in enumerate(targets))
    non_target_positions = Dict(q => j for (j, q) in enumerate(non_targets))

    function aux(
        q::Int,
        global_index::Int,
        group_index::Int,
        local_index::Int
    )

        # All qubits have been processed
        if q > n
            groups[group_index + 1][local_index + 1] = global_index + 1
            return
        end

        # Targetted qubit
        if haskey(target_positions, q)

            j = target_positions[q]

            for bit in 0:1
                aux(
                    q + 1,
                    global_index | (bit << (n-q)),
                    group_index,
                    local_index | (bit << (m-j))
                )
            end

        # Non-targetted qubit
        else

            j = non_target_positions[q]

            for bit in 0:1
                aux(
                    q + 1,
                    global_index | (bit << (n-q)),
                    group_index | (bit << (n-m-j)),
                    local_index
                )
            end

        end
    end

    aux(1, 0, 0, 0)

    return groups
end


# ============================================================
# Pretty printing
# ------------------------------------------------------------
function Base.show(io::IO, state::QuantumState)

    println(io, "QuantumState($(nqubits(state))-qubit):")

    for (i, amplitude) in enumerate(state.amplitudes)
        println(io, "   |$(string(i - 1, base=2, pad=nqubits(state)))⟩ : $amplitude")
    end
end
