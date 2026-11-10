cmake_minimum_required(VERSION 3.20)
project(kvstore LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(FetchContent)

set(SANITIZE "" CACHE STRING "Sanitizer to enable: thread, address or undefined (empty = none)")
if(SANITIZE)
  if(NOT SANITIZE MATCHES "^(thread|address|undefined)$")
    message(FATAL_ERROR "SANITIZE must be thread, address or undefined (got '${SANITIZE}')")
  endif()
  message(STATUS "Sanitizer enabled: ${SANITIZE}")
  add_compile_options(-fsanitize=${SANITIZE} -g -fno-omit-frame-pointer)
  add_link_options(-fsanitize=${SANITIZE})
endif()

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG v1.15.2
  GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(googletest)

add_compile_options(-Wall -Wextra)
include_directories(${CMAKE_SOURCE_DIR}/src)

enable_testing()

add_subdirectory(src/node)
add_subdirectory(tests)