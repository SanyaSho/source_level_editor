#=============================================================================
# posix_base.cmake
#
# $
#=============================================================================

string( REPLACE "-O3" "-O2" CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}" )
string( REPLACE "-O3" "-O2" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}" )

find_package( Threads REQUIRED )

add_compile_options(
	-g
	$<$<COMPILE_LANGUAGE:CXX>:-fpermissive>
	-fdiagnostics-color
	$<${IS_LINUX}:-U_FORTIFY_SOURCE>
	-Usprintf
	-Ustrncpy
	-UPROTECTED_THINGS_ENABLE

	$<$<COMPILE_LANGUAGE:CXX>:-fabi-compat-version=2> # Compat with old libs
)

if( DISABLE_WARNINGS )
	add_compile_options(
		-w
	)
else()
	add_compile_options(
		-Wno-narrowing

		$<$<AND:$<COMPILE_LANGUAGE:CXX>,$<NOT:$<BOOL:${DISABLE_WARNINGS}>>>:-Wno-invalid-offsetof> # Mr0maks: suppress invalid offsetof because of non standard classes. (All project work on it).
		$<$<AND:$<COMPILE_LANGUAGE:CXX>,$<NOT:$<BOOL:${DISABLE_WARNINGS}>>>:-Wno-ignored-attributes> # Mr0maks: suppress ignored attributes because of using int128 in templates.

		$<${IS_CLANG}:-Wno-inconsistent-missing-override> # c_tf_team.h:60:15: 'ClientThink' overrides a member function but is not marked 'override' c_team.h:57:18: overridden virtual function is here

		-Wno-deprecated-declarations
	)
endif()

if( ${IS_64BIT} )
	add_compile_options( -m64 )
	add_link_options( -m64 )
else()
	add_compile_options( -m32 )
	add_link_options( -m32 )
endif()

add_compile_definitions(
	_POSIX
	POSIX
	GNUC
	COMPILER_GCC
	$<${IS_LINUX}:_LINUX>
	$<${IS_LINUX}:LINUX>

	NO_HOOK_MALLOC
	NO_MALLOC_OVERRIDE
)

if( ${IS_LINUX} )
	# Helps us catch any linker errors from out of order linking or in general
	list(
		APPEND ADDITIONAL_LINK_OPTIONS_DLL
		-Wl,--no-undefined
	)
endif()

link_libraries(
	Threads::Threads
	${CMAKE_DL_LIBS}
	$<${IS_LINUX}:m>
)

add_link_options(
	-static-libgcc
	-static-libstdc++
)

add_compile_options(
	$<${IS_LINUX}:-march=core2>
	-msse2
	-mfpmath=sse
	-mtune=core2
)

list(
	APPEND ADDITIONAL_LINK_LIBRARIES_DLL
	tier1
	tier0
	vstdlib
)
