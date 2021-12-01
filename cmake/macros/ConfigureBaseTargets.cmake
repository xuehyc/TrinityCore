# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

# An interface library to make the target com available to other targets
add_library(mobius-compile-option-interface INTERFACE)

# Use -std=c++11 instead of -std=gnu++11
set(CXX_EXTENSIONS OFF)

# An interface library to make the target features available to other targets
add_library(mobius-feature-interface INTERFACE)

target_compile_features(mobius-feature-interface
  INTERFACE
    cxx_alias_templates
    cxx_auto_type
    cxx_constexpr
    cxx_decltype
    cxx_decltype_auto
    cxx_final
    cxx_lambdas
    cxx_generic_lambdas
    cxx_variadic_templates
    cxx_defaulted_functions
    cxx_nullptr
    cxx_trailing_return_types
    cxx_return_type_deduction)

# An interface library to make the warnings level available to other targets
# This interface taget is set-up through the platform specific script
add_library(mobius-warning-interface INTERFACE)

# An interface used for all other interfaces
add_library(mobius-default-interface INTERFACE)
target_link_libraries(mobius-default-interface
  INTERFACE
    mobius-compile-option-interface
    mobius-feature-interface)

# An interface used for silencing all warnings
add_library(mobius-no-warning-interface INTERFACE)

if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  target_compile_options(mobius-no-warning-interface
    INTERFACE
      /W0)
else()
  target_compile_options(mobius-no-warning-interface
    INTERFACE
      -w)
endif()

# An interface library to change the default behaviour
# to hide symbols automatically.
add_library(mobius-hidden-symbols-interface INTERFACE)

# An interface amalgamation which provides the flags and definitions
# used by the dependency targets.
add_library(mobius-dependency-interface INTERFACE)
target_link_libraries(mobius-dependency-interface
  INTERFACE
    mobius-default-interface
    mobius-no-warning-interface
    mobius-hidden-symbols-interface)

# An interface amalgamation which provides the flags and definitions
# used by the core targets.
add_library(mobius-core-interface INTERFACE)
target_link_libraries(mobius-core-interface
  INTERFACE
    mobius-default-interface
    mobius-warning-interface)
