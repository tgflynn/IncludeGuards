module IncludeGuards

export @includeonce, reinclude

GUARDS = Set{String}()

macro includeonce(filename)
	global GUARDS
	locationkey = string(__source__.file, "-module:", __module__)
	if locationkey in GUARDS
		return nothing
	end
	push!(GUARDS, locationkey)
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
