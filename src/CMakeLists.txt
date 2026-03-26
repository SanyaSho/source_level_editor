cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

if( POLICY CMP0177 )
	cmake_policy( SET CMP0177 OLD )
endif()

set( CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE )

set( CMAKE_POSITION_INDEPENDENT_CODE ON )

if( UNIX )
	set( CMAKE_SKIP_BUILD_RPATH FALSE )
	set( CMAKE_BUILD_WITH_INSTALL_RPATH TRUE )
	set( CMAKE_INSTALL_RPATH "$\{ORIGIN\}" )
endif()

project( SourceLevelEditor CXX C )

# For some reason, checking if CMAKE_BUILD_TYPE is defined is unreliable
# So simply check if it's empty instead
if( "${CMAKE_BUILD_TYPE}" STREQUAL "" )
	set( CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE )
endif()

set( CMAKE_CXX_STANDARD 17 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_VISIBILITY_PRESET hidden )

set_property( GLOBAL PROPERTY USE_FOLDERS ON )

set( SRCDIR "${CMAKE_CURRENT_LIST_DIR}" )
set( GAMEDIR "${CMAKE_CURRENT_LIST_DIR}/_compiled_bin" CACHE STRING "Build output folder" )
set( THIRDPARTYDIR "${SRCDIR}/thirdparty" )
set( DX9SDKDIR "${SRCDIR}/dx9sdk" )

# Compile options that are populated and set for each target depending on their type
set( ADDITIONAL_COMPILE_OPTIONS_EXE )
set( ADDITIONAL_COMPILE_OPTIONS_DLL )
set( ADDITIONAL_COMPILE_OPTIONS_LIB )

# Libraries that are linked to for each target depending on their type
set( ADDITIONAL_LINK_LIBRARIES_EXE )
set( ADDITIONAL_LINK_LIBRARIES_DLL )

# Linker options that are populated and set for each target depending on their type
set( ADDITIONAL_LINK_OPTIONS_EXE )
set( ADDITIONAL_LINK_OPTIONS_DLL )
set( ADDITIONAL_LINK_OPTIONS_LIB )

# Sources that are added to each target depending on their type
set( ADDITIONAL_SOURCES_EXE )
set( ADDITIONAL_SOURCES_DLL )
set( ADDITIONAL_SOURCES_LIB )

# Compile definitions that are added to each target depending on their type
set( ADDITIONAL_COMPILE_DEFINITIONS_EXE )
set( ADDITIONAL_COMPILE_DEFINITIONS_DLL )
set( ADDITIONAL_COMPILE_DEFINITIONS_LIB )

set( ADDITIONAL_INCLUDES_EXE )
set( ADDITIONAL_INCLUDES_DLL )
set( ADDITIONAL_INCLUDES_LIB )

add_compile_definitions( $<$<CONFIG:Debug>:DEBUG> $<$<CONFIG:Debug>:_DEBUG> )
add_compile_definitions( $<$<CONFIG:Release>:NDEBUG> )


include( "cmake/base.cmake" )
include( "cmake/platform_dirs.cmake" )
include( "cmake/video_base.cmake" )
include( "cmake/postbuild.cmake" )
include( "cmake/misc/install_lib.cmake" )

set( LIBPUBLIC "${SRCDIR}/lib/public/${PLATFORM_SUBDIR}" )
link_directories( ${LIBPUBLIC} )

include( "${SRCDIR}/cmake/misc/source_use_steamapi.cmake" )

if( ${IS_WINDOWS} )
	include( "cmake/windows_base.cmake" )
elseif( ${IS_LINUX} OR ${IS_OSX} )
	include( "cmake/posix_base.cmake" )
endif()

include( "cmake/misc/srcgrp.cmake" )

include( "cmake/groups.cmake" )


# Set of helper functions to add defintions/options/libs for each target in a filtered way
function( add_compile_definitions_filtered target definitions )
	foreach( additional_definition IN LISTS ${definitions} )
		set( SHOULD_EXCLUDE 0 )

		get_property( ${target}_exclude_compile_definitions GLOBAL PROPERTY ${target}_exclude_compile_definitions )

		# Define an empty exclude list if one isn't defined
		if( NOT DEFINED "${target}_exclude_compile_definitions" )
			set( "${target}_exclude_compile_definitions" )
		endif()

		# Exclude the compile definition if target defines an exclude list
		foreach( exclude IN LISTS "${target}_exclude_compile_definitions" )
			set( exclude_expression )
			strip_generator_expressions( exclude exclude_expression )

			#if( ${exclude_expression} )
				if( ${additional_definition} STREQUAL ${exclude} )
					set( SHOULD_EXCLUDE 1 )
					break()
				endif()
			#endif()
		endforeach()

		if( NOT ${SHOULD_EXCLUDE} )
			target_compile_definitions( ${target} PRIVATE ${additional_definition} )
		endif()
	endforeach()
endfunction()

function( add_compile_options_filtered target options )
	foreach( additional_option IN LISTS ${options} )
		set( SHOULD_EXCLUDE 0 )

		get_property( ${target}_exclude_compile_options GLOBAL PROPERTY ${target}_exclude_compile_options )

		# Define an empty exclude list if one isn't defined
		if( NOT DEFINED "${target}_exclude_compile_options" )
			set( "${target}_exclude_compile_options" )
		endif()

		# Exclude the compile options if target defines an exclude list
		foreach( exclude IN LISTS "${target}_exclude_compile_options" )
			set( exclude_expression )
			strip_generator_expressions( exclude exclude_expression )

			if( ${exclude_expression} )
				if( ${additional_option} STREQUAL ${exclude} )
					set( SHOULD_EXCLUDE 1 )
					break()
				endif()
			endif()
		endforeach()

		if( NOT ${SHOULD_EXCLUDE} )
			target_compile_options( ${target} PRIVATE "$<$<COMPILE_LANGUAGE:C,CXX>:${additional_option}>" )
		endif()
	endforeach()
endfunction()

function( add_sources_filtered target sources )
	foreach( additional_source IN LISTS ${sources} )
		set( SHOULD_EXCLUDE 0 )

		get_property( ${target}_exclude_source GLOBAL PROPERTY ${target}_exclude_source )

		# Define an empty exclude list if one isn't defined
		if( NOT DEFINED "${target}_exclude_source" )
			set( "${target}_exclude_source" )
		endif()

		# Exclude the source if target defines an exclude list
		foreach( exclude IN LISTS "${target}_exclude_source" )
			set( exclude_expression )
			strip_generator_expressions( exclude exclude_expression )

			if( ${exclude_expression} )
				if( ${additional_source} STREQUAL ${exclude} )
					set( SHOULD_EXCLUDE 1 )
					break()
				endif()
			endif()
		endforeach()

		if( NOT ${SHOULD_EXCLUDE} )
			target_sources( ${target} PRIVATE ${additional_source} )
		endif()
	endforeach()
endfunction()

function( add_include_dirs_filtered target includes )
	foreach( additional_include_dir IN LISTS ${includes} )
		set( SHOULD_EXCLUDE 0 )

		get_property( ${target}_exclude_include_dirs GLOBAL PROPERTY ${target}_exclude_include_dirs )

		# Define an empty exclude list if one isn't defined
		if( NOT DEFINED "${target}_exclude_include_dirs" )
			set( "${target}_exclude_include_dirs" )
		endif()

		# Exclude the source if target defines an exclude list
		foreach( exclude IN LISTS "${target}_exclude_include_dirs" )
			set( exclude_expression )
			strip_generator_expressions( exclude exclude_expression )

			if( ${exclude_expression} )
				if( ${additional_include_dir} STREQUAL ${exclude} )
					set( SHOULD_EXCLUDE 1 )
					break()
				endif()
			endif()
		endforeach()

		if( NOT ${SHOULD_EXCLUDE} )
			target_include_directories( ${target} PRIVATE ${additional_include_dir} )
		endif()
	endforeach()
endfunction()

function( add_libraries_filtered target libraries )
	foreach( additional_lib IN LISTS ${libraries} )
		set( SHOULD_EXCLUDE 0 )

		get_property( ${target}_exclude_lib GLOBAL PROPERTY ${target}_exclude_lib )

		# Define an empty exclude list if one isn't defined
		if( NOT DEFINED "${target}_exclude_lib" )
			set( "${target}_exclude_lib" )
		endif()

		# Exclude the lib if target defines an exclude list
		foreach( exclude IN LISTS "${target}_exclude_lib" )
			set( exclude_expression )
			strip_generator_expressions( exclude exclude_expression )

			if( ${exclude_expression} )
				if( ${additional_lib} STREQUAL ${exclude} )
					set( SHOULD_EXCLUDE 1 )
					break()
				endif()
			endif()
		endforeach()

		if( NOT ${SHOULD_EXCLUDE} )
			get_target_property( libraries ${target} LINK_LIBRARIES )
			# Don't bother adding it if the target already links it manually
			foreach( lib IN LISTS libraries )
				if( ${additional_lib} STREQUAL ${lib} )
					set( SHOULD_EXCLUDE 1 )
					break()
				endif()
			endforeach()
		endif()

		if( NOT ${SHOULD_EXCLUDE} )
			target_link_libraries( ${target} PRIVATE ${additional_lib} )
		endif()
	endforeach()
endfunction()

function( add_dependency_filtered target dependency )
	if( NOT ${target} STREQUAL "${dependency}" ) # Don't link to the same library
		add_dependencies( ${target} ${dependency} )
	endif()
endfunction()


# Store all targets in a variable name ( See: https://stackoverflow.com/questions/37434946/how-do-i-iterate-over-all-cmake-targets-programmatically/62311397#62311397 )
macro( get_all_targets_recursive targets dir )
    get_property( subdirectories DIRECTORY ${dir} PROPERTY SUBDIRECTORIES )

    foreach( subdir ${subdirectories} )
        get_all_targets_recursive( ${targets} ${subdir} )
    endforeach()

    get_property( current_targets DIRECTORY ${dir} PROPERTY BUILDSYSTEM_TARGETS )
    list( APPEND ${targets} ${current_targets} )
endmacro()

function( get_all_targets var )
    set( targets )
    get_all_targets_recursive( targets ${CMAKE_CURRENT_SOURCE_DIR} )
    set( ${var} ${targets} PARENT_SCOPE )
endfunction()

get_all_targets( ALL_TARGETS )

message( "--- Targets for \"${BUILD_GROUP}\":" )

# Iterates over all the targets and add memoverride stuff for debugging
foreach( target ${ALL_TARGETS} )
	get_target_property( target_type ${target} TYPE )
	message( "---- ${target} (${target_type})" )

	add_dependency_filtered( ${target} update_revision ) # Make every target depend on this command

	if( ${target_type} STREQUAL "EXECUTABLE" )
		add_compile_options_filtered( ${target} ADDITIONAL_COMPILE_OPTIONS_EXE )
		add_libraries_filtered( ${target} ADDITIONAL_LINK_LIBRARIES_EXE )
		add_sources_filtered( ${target} ADDITIONAL_SOURCES_EXE )
		add_include_dirs_filtered( ${target} ADDITIONAL_INCLUDES_EXE )
		target_link_options( ${target} PRIVATE ${ADDITIONAL_LINK_OPTIONS_EXE} )
		target_compile_definitions( ${target} PRIVATE MEMOVERRIDE_MODULE=$<TARGET_NAME_IF_EXISTS:${target}> )
		add_compile_definitions_filtered( ${target} ADDITIONAL_COMPILE_DEFINITIONS_EXE )
	elseif( (${target_type} STREQUAL "SHARED_LIBRARY") OR (${target_type} STREQUAL "MODULE_LIBRARY") )
		add_compile_options_filtered( ${target} ADDITIONAL_COMPILE_OPTIONS_DLL )
		add_libraries_filtered( ${target} ADDITIONAL_LINK_LIBRARIES_DLL )
		add_sources_filtered( ${target} ADDITIONAL_SOURCES_DLL )
		add_include_dirs_filtered( ${target} ADDITIONAL_INCLUDES_DLL )
		target_link_options( ${target} PRIVATE ${ADDITIONAL_LINK_OPTIONS_DLL} )
		target_compile_definitions( ${target} PRIVATE MEMOVERRIDE_MODULE=$<TARGET_NAME_IF_EXISTS:${target}> DLLNAME=$<TARGET_NAME_IF_EXISTS:${target}> )
		add_compile_definitions_filtered( ${target} ADDITIONAL_COMPILE_DEFINITIONS_DLL )
	elseif( ${target_type} STREQUAL "STATIC_LIBRARY" )
		add_compile_options_filtered( ${target} ADDITIONAL_COMPILE_OPTIONS_LIB )
		add_sources_filtered( ${target} ADDITIONAL_SOURCES_LIB )
		add_include_dirs_filtered( ${target} ADDITIONAL_INCLUDES_LIB )
		target_link_options( ${target} PRIVATE ${ADDITIONAL_LINK_OPTIONS_LIB} )
		target_compile_definitions( ${target} PRIVATE LIBNAME=$<TARGET_NAME_IF_EXISTS:${target}> )
		add_compile_definitions_filtered( ${target} ADDITIONAL_COMPILE_DEFINITIONS_LIB )
	endif()
endforeach()
