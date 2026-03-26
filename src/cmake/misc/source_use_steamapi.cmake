#=============================================================================
# source_use_steamapi.cmake
#
# Link library with SteamAPI (platform-dependent)
#=============================================================================

include_guard( GLOBAL )

set( STEAM_API_INCLUDES "${SRCDIR}/public/steam" )

function( target_use_steamapi target )

	set(
		STEAM_API_HEADER_FILES

	)

	target_sources(
		${target} PRIVATE

		${STEAM_API_HEADER_FILES}
	)

	source_group(
		"SteamAPI"
		FILES
		${STEAM_API_HEADER_FILES}
	)

	target_link_libraries(
		${target} PRIVATE

		# linux32/linux64 osx32/osx64
		"$<${IS_POSIX}:${LIBPUBLIC}/libsteam_api${IMPLIB_EXT}>"

		# win32
		"$<$<AND:${IS_WINDOWS},$<NOT:${IS_64BIT}>>:${LIBPUBLIC}/steam_api${IMPLIB_EXT}>"

		# win64
		"$<$<AND:${IS_WINDOWS},${IS_64BIT}>:${LIBPUBLIC}/steam_api64${IMPLIB_EXT}>"
	)

	target_include_directories(
		${target} PRIVATE

		"${STEAM_API_INCLUDES}"
	)

endfunction()
