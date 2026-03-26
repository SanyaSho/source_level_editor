#-----------------------------------------------------------------------------
# install_lib.cmake
#
# $
#-----------------------------------------------------------------------------

include_guard( GLOBAL )

set( CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE )

function( install_library )
	cmake_parse_arguments(
		ARGS
		""
		"TARGET;EXECUTABLE;INSTALL_OUTNAME;INSTALL_DEST"
		""
		${ARGN}
	)

	# use ARGS_TARGET if OUTNAME is not set
	if( NOT ARGS_INSTALL_OUTNAME )
		set( ARGS_INSTALL_OUTNAME "${ARGS_TARGET}" )
	endif()

	# append executable subname for executables
	if( ARGS_EXECUTABLE )
		set( ARGS_INSTALL_OUTNAME "${ARGS_INSTALL_OUTNAME}${EXECUTABLE_SUBNAME}" )
	endif()

	set_target_properties( ${ARGS_TARGET} PROPERTIES OUTPUT_NAME "${ARGS_INSTALL_OUTNAME}" )

	# Set VS debugger stuff here (ignored by non-VS generators)
	if( ARGS_EXECUTABLE )
		set_target_properties( ${ARGS_TARGET} PROPERTIES
			VS_DEBUGGER_COMMAND		"${ARGS_INSTALL_DEST}/${ARGS_INSTALL_OUTNAME}"
			VS_DEBUGGER_COMMAND_ARGUMENTS	"-novid -console +developer 5" # always run game with console and developer enabled
			VS_DEBUGGER_WORKING_DIRECTORY	"${ARGS_INSTALL_DEST}"
		)
	endif()

	if( NOT MSVC )
		install(
			TARGETS ${ARGS_TARGET}
			DESTINATION ${ARGS_INSTALL_DEST}

			PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE	#
				    GROUP_READ GROUP_EXECUTE			# chmod 755
				    WORLD_READ WORLD_EXECUTE			#
		)

		if( NOT ARGS_NO_STRIP AND NOT ARGS_STATIC )
			# DBG
			install(
				FILES "$<TARGET_FILE:${ARGS_TARGET}>.dbg"
				DESTINATION ${ARGS_INSTALL_DEST}

				PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE	#
					    GROUP_READ GROUP_EXECUTE			# chmod 755
					    WORLD_READ WORLD_EXECUTE			#
			)
		endif()
	else()
		install(
			TARGETS ${ARGS_TARGET}
			RUNTIME DESTINATION ${ARGS_INSTALL_DEST}
			LIBRARY DESTINATION ${ARGS_INSTALL_DEST}
		)

		# PDB
		install(
			FILES $<TARGET_PDB_FILE:${ARGS_TARGET}>
			DESTINATION ${ARGS_INSTALL_DEST}
		)
	endif()
endfunction()

# WARNING! SOURCES SHOULD BE LAST
function( add_object )
	cmake_parse_arguments(
		SHARED_ARGS
		"DEBUGLOG;EXECUTABLE;SHARED;MODULE;STATIC;NO_LIB_PREFIX;NO_STRIP;INSTALL_FOR_EACH_GAME"
		"TARGET;PROPERTY_FOLDER;INSTALL_OUTNAME;INSTALL_DEST;INSTALL_BASEDIR"
		"EXCLUDE_COMPILE_DEFINITIONS;EXCLUDE_COMPILE_OPTIONS;EXCLUDE_SOURCE;EXCLUDE_INCLUDE_DIRS;EXCLUDE_LIB;SOURCES"
		${ARGN}
	)

	# SanyaSho: moved from pch_skip.cmake
	set_source_files_properties( "${SRCDIR}/public/tier0/memoverride.cpp" PROPERTIES SKIP_PRECOMPILE_HEADERS ON )

	if( SHARED_ARGS_DEBUGLOG )
		message( "SHARED_ARGS_DEBUGLOG: ${SHARED_ARGS_DEBUGLOG}" )
		message( "SHARED_ARGS_EXECUTABLE: ${SHARED_ARGS_EXECUTABLE}" )
		message( "SHARED_ARGS_SHARED: ${SHARED_ARGS_SHARED}" )
		message( "SHARED_ARGS_MODULE: ${SHARED_ARGS_MODULE}" )
		message( "SHARED_ARGS_STATIC: ${SHARED_ARGS_STATIC}" )
		message( "SHARED_ARGS_NO_LIB_PREFIX: ${SHARED_ARGS_NO_LIB_PREFIX}" )
		message( "SHARED_ARGS_NO_STRIP: ${SHARED_ARGS_NO_STRIP}" )
		message( "SHARED_ARGS_INSTALL_FOR_EACH_GAME: ${SHARED_ARGS_INSTALL_FOR_EACH_GAME}" )

		message( "SHARED_ARGS_TARGET: ${SHARED_ARGS_TARGET}" )
		message( "SHARED_ARGS_PROPERTY_FOLDER: ${SHARED_ARGS_PROPERTY_FOLDER}" )
		message( "SHARED_ARGS_INSTALL_OUTNAME: ${SHARED_ARGS_INSTALL_OUTNAME}" )
		message( "SHARED_ARGS_INSTALL_DEST: ${SHARED_ARGS_INSTALL_DEST}" )
		message( "SHARED_ARGS_INSTALL_BASEDIR: ${SHARED_ARGS_INSTALL_BASEDIR}" )

		message( "SHARED_ARGS_EXCLUDE_COMPILE_DEFINITIONS: ${SHARED_ARGS_EXCLUDE_COMPILE_DEFINITIONS}" )
		message( "SHARED_ARGS_EXCLUDE_COMPILE_OPTIONS: ${SHARED_ARGS_EXCLUDE_COMPILE_OPTIONS}" )
		message( "SHARED_ARGS_EXCLUDE_SOURCE: ${SHARED_ARGS_EXCLUDE_SOURCE}" )
		message( "SHARED_ARGS_EXCLUDE_INCLUDE_DIRS: ${SHARED_ARGS_EXCLUDE_INCLUDE_DIRS}" )
		message( "SHARED_ARGS_EXCLUDE_LIB: ${SHARED_ARGS_EXCLUDE_LIB}" )
		message( "SHARED_ARGS_SOURCES: ${SHARED_ARGS_SOURCES}" )
	endif()

	if( NOT SHARED_ARGS_TARGET )
		message( FATAL_ERROR "Missing TARGET!" )
	endif()

	# BASEDIR is set only with INSTALL_FOR_EACH_GAME
	if( NOT SHARED_ARGS_INSTALL_BASEDIR )
		set( SHARED_ARGS_INSTALL_BASEDIR "${GAMEDIR}" )
	endif()

	set_property( GLOBAL PROPERTY ${SHARED_ARGS_TARGET}_exclude_compile_definitions "${SHARED_ARGS_EXCLUDE_COMPILE_DEFINITIONS}" )
	set_property( GLOBAL PROPERTY ${SHARED_ARGS_TARGET}_exclude_compile_options "${SHARED_ARGS_EXCLUDE_COMPILE_OPTIONS}" )
	set_property( GLOBAL PROPERTY ${SHARED_ARGS_TARGET}_exclude_source "${SHARED_ARGS_EXCLUDE_SOURCE}" )
	set_property( GLOBAL PROPERTY ${SHARED_ARGS_TARGET}_exclude_include_dirs "${SHARED_ARGS_EXCLUDE_INCLUDE_DIRS}" )
	set_property( GLOBAL PROPERTY ${SHARED_ARGS_TARGET}_exclude_lib "${SHARED_ARGS_EXCLUDE_LIB}" )

	if( SHARED_ARGS_EXECUTABLE )
		# add_executable
		cmake_parse_arguments(
			ADD_EXECUTABLE_ARGS
			"WIN32"
			""
			""
			${ARGN}
		)

		if( SHARED_ARGS_DEBUGLOG )
			message( "ADD_EXECUTABLE_ARGS_WIN32: ${ADD_EXECUTABLE_ARGS_WIN32}" )
		endif()

		set( EXEWIN32 )
		if( ADD_EXECUTABLE_ARGS_WIN32 )
			set( EXEWIN32 WIN32 )
		endif()

		add_executable(
			${SHARED_ARGS_TARGET} ${EXEWIN32}
			${SHARED_ARGS_SOURCES}
		)

		set( NEW_PROPERTY_FOLDER "Executables" )

		if( NOT SHARED_ARGS_NO_STRIP )
			# Only applies to Linux and OSX
			target_strip_symbols( ${SHARED_ARGS_TARGET} )
		endif()

	elseif( SHARED_ARGS_SHARED OR SHARED_ARGS_MODULE OR SHARED_ARGS_STATIC )
		# add_library
		if( SHARED_ARGS_SHARED )
			set( LIBTYPE SHARED )
		elseif( SHARED_ARGS_MODULE )
			set( LIBTYPE MODULE )
		elseif( SHARED_ARGS_STATIC )
			set( LIBTYPE STATIC )
		endif()

		if( NOT LIBTYPE )
			message( FATAL_ERROR "Missing library type for ${SHARED_ARGS_TARGET}" )
		endif()

		add_library(
			${SHARED_ARGS_TARGET} ${LIBTYPE}
			${SHARED_ARGS_SOURCES}
		)

		if( SHARED_ARGS_MODULE OR SHARED_ARGS_NO_LIB_PREFIX ) # disable lib- prefix for all modules (from this time any new shared library should be MODULE)
			set_target_properties( ${SHARED_ARGS_TARGET} PROPERTIES PREFIX "" )
		endif()

		if( SHARED_ARGS_SHARED OR SHARED_ARGS_MODULE )
			set( NEW_PROPERTY_FOLDER "Shared Libs" )
		elseif( SHARED_ARGS_STATIC )
			set( NEW_PROPERTY_FOLDER "Static Libs" )
		endif()

		if( NOT SHARED_ARGS_NO_STRIP AND NOT SHARED_ARGS_STATIC )
			# Only applies to Linux and OSX
			target_strip_symbols( ${SHARED_ARGS_TARGET} )
		endif()
	else()
		message( FATAL_ERROR "${SHARED_ARGS_TARGET} has unknown object type!" )
	endif()

	# Override property folder
	if( SHARED_ARGS_PROPERTY_FOLDER )
		set( NEW_PROPERTY_FOLDER ${SHARED_ARGS_PROPERTY_FOLDER} )
	endif()

	if ( NOT ${IS_LINUX} )
		set_property( TARGET ${SHARED_ARGS_TARGET} PROPERTY FOLDER ${NEW_PROPERTY_FOLDER} )
	endif()

	## Merged set_install_properties into add_object
	if( SHARED_ARGS_INSTALL_FOR_EACH_GAME )
		foreach( GAME IN LISTS GAMES_TO_BUILD_LIST )
			override_game_name( GAME )

			set( LIB_INSTALL_PATH_FOR_GAME "${SHARED_ARGS_INSTALL_BASEDIR}/${GAME}/${SHARED_ARGS_INSTALL_DEST}" )

			install_library(
				TARGET ${SHARED_ARGS_TARGET}
				EXECUTABLE ${SHARED_ARGS_EXECUTABLE}
				INSTALL_OUTNAME ${SHARED_ARGS_INSTALL_OUTNAME}
				INSTALL_DEST ${LIB_INSTALL_PATH_FOR_GAME}
			)
		endforeach()
	else()
		# Don't install if DESTINATION is not set
		if( NOT "${SHARED_ARGS_INSTALL_DEST}" STREQUAL "" )
			# Install DLLS as _srv.so for Linux SRCDS
			if( ( SHARED_ARGS_SHARED OR SHARED_ARGS_MODULE ) AND ( ${IS_DEDICATED} AND ${IS_LINUX} ) )
				set( SHARED_ARGS_INSTALL_OUTNAME "${SHARED_ARGS_INSTALL_OUTNAME}_srv" )
			endif()

			install_library(
				TARGET ${SHARED_ARGS_TARGET}
				EXECUTABLE ${SHARED_ARGS_EXECUTABLE}
				INSTALL_OUTNAME ${SHARED_ARGS_INSTALL_OUTNAME}
				INSTALL_DEST ${SHARED_ARGS_INSTALL_DEST}
			)
		endif()
	endif()
endfunction()
