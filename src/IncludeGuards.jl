"""
  Provides an include guard mechanism for julia.

  exports:

    * @includeonce
    * @reinclude
"""
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
	@debug "includeonce::"  __source__ __module__ locationkey
	if locationkey in GUARDS
		@debug "includeonce: skipping include:" filename
		return nothing
	end
	push!(GUARDS, locationkey)
	@debug "includeonce: including:" filename
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
