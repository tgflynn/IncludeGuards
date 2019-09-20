
using IncludeGuards

@includeonce "TestModule.jl"

show( IOContext( stdout, :limit => false ), IncludeGuards.GUARDS )
println()

@includeonce "TestModule.jl"
