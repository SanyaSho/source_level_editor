#=============================================================================
# base.cmake
#
# $
#=============================================================================

# NOTE: We use 0 or 1 so we can use these more easily in generator expressions
# Initialize them with default values that we then set later

set( IS_DEDICATED	0 )
set( IS_SOURCESDK	1 )
set( IS_64BIT		0 )


if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
	set( IS_64BIT 1 )
else()
	set( IS_64BIT 0 )
endif()


include( "${SRCDIR}/cmake/platforms.cmake" )


if( ${IS_WINDOWS} )
	set( _DLL_EXT ".dll" )
	set( STATIC_LIB_EXT ".lib" )
	set( IMPLIB_EXT ".lib" )
elseif( ${IS_LINUX} )
	set( _DLL_EXT ".so" )
	set( STATIC_LIB_EXT ".a" )
	set( IMPLIB_EXT ".so" )
endif()


message( "=============================================================================" )

message( STATUS "GAMEDIR: ${GAMEDIR}" )

# Set this to ON to supress all warnings (POSIX-only for now)
option( DISABLE_WARNINGS "Disable warnings" OFF )
message( STATUS "DISABLE_WARNINGS: ${DISABLE_WARNINGS}" )

option( DEDICATED "Build dedicated" OFF )
message( STATUS "DEDICATED: ${DEDICATED}" )
if( DEDICATED )
	set( IS_DEDICATED 1 )
	set( BUILD_GROUP "dedicated" )

	if( ${IS_LINUX} )
		set( _DLL_EXT "_srv.so" )
	endif()
endif()

option( RELEASEASSERTS "Build engine with enabled asserts in release" OFF )
message( STATUS "RELEASEASSERTS: ${RELEASEASSERTS}" )

option( STAGING_ONLY "STAGING_ONLY" ON )
message( STATUS "STAGING_ONLY: ${STAGING_ONLY}" )

option( USE_MANIFEST "Add the control manifest to make interface use Vista+ themes" ON )
add_compile_definitions( DARKINTERVAL SLE $<$<BOOL:${USE_MANIFEST}>:SLE_MANIFEST> ) # SLE

message( "=============================================================================" )


list(
	APPEND ADDITIONAL_SOURCES_EXE
	"${SRCDIR}/public/tier0/memoverride.cpp"
)

list(
	APPEND ADDITIONAL_SOURCES_DLL
	"${SRCDIR}/public/tier0/memoverride.cpp"
)


if( ${IS_DEDICATED} )
	# We will use patchelf to replace the required libtier0.so and libvstdlib.so with their _srv.so variants
	find_program( PATCHELF_EXE patchelf REQUIRED )
endif()


# CMAKETODO(SanyaSho): windows support
if( ${IS_POSIX} )
	find_program( CCACHE ccache )

	if( NOT CCACHE MATCHES "NOTFOUND" )
		# https://github.com/llvm/llvm-project/blob/main/llvm/CMakeLists.txt#L239-L267
		set( CCACHE_COMMAND "CCACHE_DIR=\"${SRCDIR}/.ccache\" ${CCACHE}" )

		set_property(
			GLOBAL
			PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_COMMAND}"
		)

		# CMAKETODO(SanyaSho): 'Error running link command: No such file or directory'
		#set_property(
		#	GLOBAL
		#	PROPERTY RULE_LAUNCH_LINK "${CCACHE_COMMAND}"
		#)
	else()
		message( STATUS "Could not find ccache executable!" )
	endif()
endif()

list(
	APPEND ADDITIONAL_INCLUDES_EXE
	"${SRCDIR}/common"
	"${SRCDIR}/public"
	"${SRCDIR}/public/tier0"
	"${SRCDIR}/public/tier1"
)

list(
	APPEND ADDITIONAL_INCLUDES_DLL
	"${SRCDIR}/common"
	"${SRCDIR}/public"
	"${SRCDIR}/public/tier0"
	"${SRCDIR}/public/tier1"
)

list(
	APPEND ADDITIONAL_INCLUDES_LIB
	"${SRCDIR}/common"
	"${SRCDIR}/public"
	"${SRCDIR}/public/tier0"
	"${SRCDIR}/public/tier1"
)

add_compile_definitions(
	"$<$<BOOL:${RELEASEASSERTS}>:RELEASEASSERTS>"
	"$<$<BOOL:${STAGING_ONLY}>:STAGING_ONLY>"

	"$<$<BOOL:${IS_64BIT}>:PLATFORM_64BITS>"

	VPROF_LEVEL=4

	"$<${IS_SOURCESDK}:RAD_TELEMETRY_DISABLED>"

	_DLL_EXT=${_DLL_EXT}
	FRAME_POINTER_OMISSION_DISABLED
)

add_custom_target(
	update_revision
	ALL
	WORKING_DIRECTORY ${SRCDIR}/public
	COMMAND ${CMAKE_COMMAND} -DSOURCE_DIR=${SRCDIR} -DINPUT=revision.h.in -DOUTPUT=revision.h -P ${SRCDIR}/cmake/misc/revision.cmake
	VERBATIM
)
set_property( TARGET update_revision PROPERTY FOLDER "Utility" )
