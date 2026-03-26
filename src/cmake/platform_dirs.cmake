#=============================================================================
# platform_dirs.cmake
#
# $
#=============================================================================

if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
	set( PLATFORM_ARCH "64" )

	if( UNIX )
		set( EXECUTABLE_SUBNAME "_linux64" )
		set( PLATFORM_SUBDIR "linux64" )
	endif()

	if( WIN32 )
		set( EXECUTABLE_SUBNAME "_win64" )
		set( PLATFORM_SUBDIR "x64" )
	endif()
else()
	set( PLATFORM_ARCH "32" )

	if( UNIX )
		set( EXECUTABLE_SUBNAME "_linux" )
		set( PLATFORM_SUBDIR "linux32" )
	endif()

	if( WIN32 )
		set( EXECUTABLE_SUBNAME "" )
		set( PLATFORM_SUBDIR "" )
	endif()
endif()
