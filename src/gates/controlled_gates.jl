# Controlled-NOT CNOT
struct ControlledNOT <: AbstractGate end

const CNOT = ControlledNOT()

function matrix(::ControlledNOT)
    return ComplexF64[
        1 0 0 0
        0 1 0 0
        0 0 0 1
        0 0 1 0
    ]
end

