Overview
========

This is a very small package which provides an include guard mechanism for julia.
It serves a similar purpose to include guards in C or C++ but leverages julia's 
powerful macros to automate the entire process.

The primary features it provides are the following two macro calls:

 * `@includeonce "file"`

    Ensures that file will be included once and only once within this module.

 * `@reinclude "file"`
   
    Overrides the includeonce mechanism to allow loading modified code from the REPL.

Why would I want to use this ?
------------------------------

Modules are the primary mechanism provided by julia for organizing code within a package
or application and enforcing a degree of separation of concerns.  However effectively using modules
in julia can be tricky.  The reason is that if you want to use a module defined in another file
within your project you first need to include that other file.  Each time you do this julia creates a 
new version of the defined module.  These versions look identical but julia actually considers objects
defined in the module to be different between each subsequent time that it was loaded.

But why would you want to load a module multiple times ?  Well suppose you have 3 modules: A, B and C.
Now suppose A defines some type which is used in B and also some functions that are used in C.  This
creates a dependency graph that looks like this:

         -> B ---
         |      |
    C -> |      -> A
         |      |
         --------

If you want to be able to compile and partially test A, B and C individually then both B and C will
need to include A.  Now if you include C in some other location this will also cause A and B to be
reincluded.  This has several effects.  First julia will give you a warning message about modules 
being replaced.  This warning is probably familiar if you use a REPL based workflow because you will
see it every time you reload a module for testing using an include.  Nonetheless the warning is a bit 
unpleasant and probably isn't something you want your code to be generating in production and it's
an indication that some unexpected things may happen.

For one thing you have to careful that all of your code always includes modules in the same order.  
Otherwise you may find that your code is using different and incompatible versions of types in different
places.  To see an example of this sort of thing you can try running: 

```include("test/runbroken.jl")```

from this package's directory.

IncludeGuards provides a workaround for this problem by giving you a way to ensure that your modules are 
loaded once and only once within each module (this will be Main, if you aren't nesting modules).

Usage
=====

This package isn't currently registered in the global julia registry so to add it you'll need to specify
it's github location like this:

```julia
julia> ]
(environment) pkg> add https://github.com/tgflynn/IncludeGuards.git
```

Once installed you will need a 

```julia
using IncludeGuards
```

line in every file in which you wish to use it.  Then simply replace any `include("file.jl")` calls that you want to occur
only once with the macro call: `@includeonce "file.jl"`.

If you're working from the REPL and want to force new code to be loaded make sure you've loaded the module 
(ie. `using IncludeGuards` and then instead of typing `include("toplevel.jl")`, type `@reinclude "toplevel.jl"`.
