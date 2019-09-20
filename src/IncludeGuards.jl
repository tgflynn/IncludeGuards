module IncludeGuards

export @includeonce

GUARDS = Set{String}()

macro includeonce(filename)
	global GUARDS
	location = string(__source__.file, "-line:", __source__.line)
	if location in GUARDS
		return nothing
	end
	push!(GUARDS, location)
	return :( include($filename) )
end

function reinclude(filename::String)
	clear()
	include(filename)
end

function clear()
	empty!(GUARDS)
end

end # module
