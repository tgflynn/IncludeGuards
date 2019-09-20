module IncludeGuards

export @includeonce, @reinclude

GUARDS = Set{String}()

macro includeonce(filename)
	global GUARDS
	locationkey = string( "module:", 
			     __module__,
			     "-include:",
			     filename)
	println("__source__ = ", __source__, ", __module__ = ", __module__, ", locationkey = ", locationkey)
	if locationkey in GUARDS
		println("skipping include:", filename)
		return nothing
	end
	push!(GUARDS, locationkey)
	println("including:", filename)
	return :( Base.include($__module__, $filename) )
end

macro reinclude(filename::String)
	clear()
	return :( Base.include($__module__, $filename) )
end

function clear()
	empty!(GUARDS)
end

end # module
