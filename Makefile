.PHONY: compile test bell_state

compile:
	julia --project=. -e 'using Pkg; Pkg.instantiate(); using JuliaQuantumLab'

test:
	julia --project=. -e 'using Pkg; Pkg.test()'

# Examples
bell_state:
	julia --project=. examples/bell_state.jl
