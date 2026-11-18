# Pauli X
struct PauliX <: AbstractGate end

const X = PauliX()

function matrix(::PauliX)
    return ComplexF64[
        0 1
        1 0
    ]
end

# Pauli Y
struct PauliY <: AbstractGate end

const Y = PauliY()

function matrix(::PauliY)
    return ComplexF64[
        0 -im
        im 0
    ]
end

# Pauli Z
struct PauliZ <: AbstractGate end

const Z = PauliZ()

function matrix(::PauliZ)
    return ComplexF64[
        1 0
        0 -1
    ]
end

