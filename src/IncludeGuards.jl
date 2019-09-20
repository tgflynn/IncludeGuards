module IncludeGuards

export @includeonce, @reinclude

GUARDS = Set{String}()

"""
  Usage: `@includeonce "filename"`

  Use instead of include to ensure that the file is included once and only once
  within this module.
"""
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

"""
  Usage: `@reinclude "filename"`

  For use during development from the REPL.  Resets all include guards so that
  modified code gets reloaded.
"""
macro reinclude(filename::String)
	clear()
	return :( Base.include($__module__, $filename) )
end

function clear()
	empty!(GUARDS)
end

end # module
