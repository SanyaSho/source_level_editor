#=============================================================================
# platforms.cmake
#
# Platform & Compilers defiintions
#=============================================================================

include_guard( GLOBAL )


# Platforms
set( IS_WINDOWS		0 )
set( IS_POSIX		0 )
set( IS_LINUX		0 )

if( WIN32 )
	set( IS_WINDOWS	1 )
endif()

if( UNIX )
	set( IS_POSIX 1 )
	set( IS_LINUX 1 )
endif()


# Compilers
set( IS_CLANG		0 )
set( IS_CLANGCL		0 )
set( IS_APPLECLANG	0 )
set( IS_GCC		0 )
set( IS_INTELC		0 )
set( IS_MSVC		0 )

if( CMAKE_CXX_COMPILER_ID STREQUAL "Clang" )
	# using Clang
	set( IS_CLANG 1 )
	if( MSVC )
		# using ClangCL
		set( IS_CLANGCL 1 )
	endif()
elseif( CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang" )
	# using Apple Clang
	set( IS_CLANG 1 )
	set( IS_APPLECLANG 1 )
elseif( CMAKE_CXX_COMPILER_ID STREQUAL "GNU" )
	# using GCC
	set( IS_GCC 1 )
elseif( CMAKE_CXX_COMPILER_ID STREQUAL "Intel" )
	# using Intel C++
	set( IS_INTELC 1 )
elseif( CMAKE_CXX_COMPILER_ID STREQUAL "MSVC" )
	# using Visual Studio C++
	set( IS_MSVC 1 )
endif()
