
include("ModB.jl")
include("ModA.jl")

module TestModuleBroken

using ..A
using ..B

p = A.Parameters(1)

b = B.BStruct(params = p)

B.g(b)

end # module
