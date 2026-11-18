struct Hadamard <: AbstractGate end

const H = Hadamard()

function matrix(::Hadamard)
    return (1 / sqrt(2)) * ComplexF64[
        1 1
        1 -1
    ]
end
