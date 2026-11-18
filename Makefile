.PHONY: compile test

compile:
	julia --project=. -e 'using Pkg; Pkg.instantiate(); using JuliaQuantumLab'

test:
	julia --project=. -e 'using Pkg; Pkg.test()'
