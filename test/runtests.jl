
using Test
using IncludeGuards

@testset "Working tests" begin

	@includeonce "TestModuleWorking.jl"

	@test true

	@debug "runtests: GUARDS = " IncludeGuards.GUARDS
	println()

	@includeonce "TestModuleWorking.jl"

end
