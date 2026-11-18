# Identity I
struct Identity <: AbstractGate end

const I = Identity()

function matrix(::I)
    return ComplexF64[
        1 0
        0 1
    ]
end

