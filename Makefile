.PHONY: compile

compile:
	julia --project=. -e 'using Pkg; Pkg.instantiate(); using JuliaQuantumLab'
