/*
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License as published by the
* Free Software Foundation; either version 2 of the License, or (at your
* option) any later version.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see <http://www.gnu.org/licenses/>.
*/

// Currently we are using a single module (executable) for all the tests however
// when the test code base gets larger the tests should be split in multiple
// modules, e.g, one for each tool, one for each server, one for the database code, etc.

#define BOOST_TEST_MODULE TrinityCore Unit Tests
#include <boost/test/unit_test.hpp>
