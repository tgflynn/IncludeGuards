
using IncludeGuards

println("TestModuleWorking.jl, module = ", @__MODULE__)

@includeonce "ModB.jl"
@includeonce "ModA.jl"

module TestModuleWorking

using ..A
using ..B

p = A.Parameters(1)

b = B.BStruct(params = p)

B.g(b)

end # module
