# This file is part of the MobiusCore project.
# See AUTHORS file for copyright information.

# basic packagesearching and setup
# (further support will be needed, this is a preliminary release!)
set(OPENSSL_EXPECTED_VERSION 1.0.0)

find_package(OpenSSL REQUIRED)

add_library(openssl INTERFACE)

target_link_libraries(openssl
  INTERFACE
    ${OPENSSL_LIBRARIES})

target_include_directories(openssl
  INTERFACE
    ${OPENSSL_INCLUDE_DIR})
