
using IncludeGuards

@includeonce("ModA.jl")

module B

using ..A

ParametersType = Union{Nothing,A.Parameters}

mutable struct BStruct
	params::ParametersType

	function BStruct(; params::ParametersType = nothing )
		new(params)
	end
end

function f(;p::ParametersType = nothing)
	isnothing(p) ? println("nothing") : println("a = ", p.a)
end	

function g(a::BStruct)
	f(p=a.params)
end

end # module

