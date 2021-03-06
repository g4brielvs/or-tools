if(NOT BUILD_JAVA)
  return()
endif()

if(NOT TARGET ortools::ortools)
  message(FATAL_ERROR "Java: missing ortools TARGET")
endif()

# Will need swig
set(CMAKE_SWIG_FLAGS)
find_package(SWIG REQUIRED)
include(UseSWIG)

if(${SWIG_VERSION} VERSION_GREATER_EQUAL 4)
  list(APPEND CMAKE_SWIG_FLAGS "-doxygen")
endif()

if(UNIX AND NOT APPLE)
  list(APPEND CMAKE_SWIG_FLAGS "-DSWIGWORDSIZE64")
endif()

# Generate Protobuf java sources
set(PROTO_JAVAS)
file(GLOB_RECURSE proto_java_files RELATIVE ${PROJECT_SOURCE_DIR}
  "ortools/constraint_solver/*.proto"
  "ortools/linear_solver/*.proto"
  "ortools/sat/*.proto"
  "ortools/util/*.proto"
  )
list(REMOVE_ITEM proto_java_files "ortools/constraint_solver/demon_profiler.proto")
foreach(PROTO_FILE ${proto_java_files})
  #message(STATUS "protoc proto(java): ${PROTO_FILE}")
  get_filename_component(PROTO_DIR ${PROTO_FILE} DIRECTORY)
  get_filename_component(PROTO_NAME ${PROTO_FILE} NAME_WE)
  set(PROTO_JAVA ${PROJECT_BINARY_DIR}/java/com/google/${PROTO_DIR}/${PROTO_NAME}.java)
  #message(STATUS "protoc java: ${PROTO_JAVA}")
  add_custom_command(
    OUTPUT ${PROTO_JAVA}
    COMMAND ${CMAKE_COMMAND} -E make_directory ${PROJECT_BINARY_DIR}/java/com/google/${PROTO_DIR}
    COMMAND protobuf::protoc
    "--proto_path=${PROJECT_SOURCE_DIR}"
    "--java_out=${PROJECT_BINARY_DIR}/java/com/google/${PROTO_DIR}"
    ${PROTO_FILE}
    DEPENDS ${PROTO_FILE} protobuf::protoc
    COMMENT "Generate Java protocol buffer for ${PROTO_FILE}"
    VERBATIM)
  list(APPEND PROTO_JAVAS ${PROTO_JAVA})
endforeach()
add_custom_target(Java${PROJECT_NAME}_proto DEPENDS ${PROTO_JAVAS} ortools::ortools)

# Setup Java
find_package(Java 1.8 REQUIRED COMPONENTS Development)
find_package(JNI REQUIRED)

# Find maven
find_program(MAVEN_EXECUTABLE mvn)
if(NOT MAVEN_EXECUTABLE)
  message(FATAL_ERROR "Check for maven Program: not found")
else()
  message(STATUS "Found Maven: ${MAVEN_EXECUTABLE}")
endif()

# CMake will remove all '-D' prefix (i.e. -DUSE_FOO become USE_FOO)
#get_target_property(FLAGS ortools::ortools COMPILE_DEFINITIONS)
set(FLAGS -DUSE_BOP -DUSE_GLOP -DABSL_MUST_USE_RESULT)
if(USE_COINOR)
  list(APPEND FLAGS
    "-DUSE_CBC"
    "-DUSE_CLP"
    )
endif()
list(APPEND CMAKE_SWIG_FLAGS ${FLAGS} "-I${PROJECT_SOURCE_DIR}")

# Create the native library
add_library(jniortools SHARED "")
set_target_properties(jniortools PROPERTIES
  POSITION_INDEPENDENT_CODE ON)
# note: macOS is APPLE and also UNIX !
if(APPLE)
  set_target_properties(jniortools PROPERTIES INSTALL_RPATH "@loader_path")
elseif(UNIX)
  set_target_properties(jniortools PROPERTIES INSTALL_RPATH "$ORIGIN")
endif()

# Swig wrap all libraries
set(OR_TOOLS_JAVA com.google.ortools)
foreach(SUBPROJECT IN ITEMS algorithms graph linear_solver constraint_solver sat util)
  add_subdirectory(ortools/${SUBPROJECT}/java)
  target_link_libraries(jniortools PRIVATE java_${SUBPROJECT})
endforeach()

####################
##  Java package  ##
####################
file(GENERATE OUTPUT java/$<CONFIG>/replace.cmake
  CONTENT
  "FILE(READ ${PROJECT_SOURCE_DIR}/ortools/java/pom.xml.in input)
STRING(REPLACE \"@PROJECT_VERSION@\" \"${PROJECT_VERSION}\" input \"\${input}\")
STRING(REPLACE \"@ortools@\" \"$<TARGET_FILE:${PROJECT_NAME}>\" input \"\${input}\")
STRING(REPLACE \"@native@\" \"$<TARGET_FILE:jniortools>\" input \"\${input}\")
FILE(WRITE pom.xml \"\${input}\")"
)

add_custom_command(
  OUTPUT java/pom.xml
  COMMAND ${CMAKE_COMMAND} -P ./$<CONFIG>/replace.cmake
  WORKING_DIRECTORY java
  )

# Main Target
add_custom_target(java_package ALL
  DEPENDS
    ortools::ortools
    Java${PROJECT_NAME}_proto
    jniortools
    java/pom.xml
  COMMAND ${MAVEN_EXECUTABLE} package
  WORKING_DIRECTORY java
  )

# Test
if(BUILD_TESTING)
  #add_subdirectory(examples/java)
endif()
