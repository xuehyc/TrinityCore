/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef MobiusCore_Optional_h__
#define MobiusCore_Optional_h__

#include <boost/optional.hpp>
#include <boost/utility/in_place_factory.hpp>

 //! Optional helper class to wrap optional values within.
template <typename T>
using Optional = boost::optional<T>;

#endif // MobiusCore_Optional_h__
