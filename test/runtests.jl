
using Test
using IncludeGuards

@testset "Working tests" begin

	@includeonce "TestModuleWorking.jl"

	@test true

	show( IOContext( stdout, :limit => false ), IncludeGuards.GUARDS )
	println()

	@includeonce "TestModuleWorking.jl"

end

@testset "Broken tests" begin

	#@test_throws LoadError include("TestModuleBroken.jl")

end
