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
		"${STEAM_API_INCLUDES}/isteamapplist.h"
		"${STEAM_API_INCLUDES}/isteamapps.h"
		"${STEAM_API_INCLUDES}/isteamclient.h"
		"${STEAM_API_INCLUDES}/isteamcontroller.h"
		"${STEAM_API_INCLUDES}/isteamfriends.h"
		"${STEAM_API_INCLUDES}/isteamgameserver.h"
		"${STEAM_API_INCLUDES}/isteamgameserverstats.h"
		"${STEAM_API_INCLUDES}/isteamhtmlsurface.h"
		"${STEAM_API_INCLUDES}/isteamhttp.h"
		"${STEAM_API_INCLUDES}/isteammatchmaking.h"
		"${STEAM_API_INCLUDES}/isteammusic.h"
		"${STEAM_API_INCLUDES}/isteammusicremote.h"
		"${STEAM_API_INCLUDES}/isteamnetworking.h"
		"${STEAM_API_INCLUDES}/isteamremotestorage.h"
		"${STEAM_API_INCLUDES}/isteamscreenshots.h"
		"${STEAM_API_INCLUDES}/isteamugc.h"
		"${STEAM_API_INCLUDES}/isteamunifiedmessages.h"
		"${STEAM_API_INCLUDES}/isteamuser.h"
		"${STEAM_API_INCLUDES}/isteamuserstats.h"
		"${STEAM_API_INCLUDES}/isteamutils.h"
		"${STEAM_API_INCLUDES}/matchmakingtypes.h"
		"${STEAM_API_INCLUDES}/steam_api.h"
		"${STEAM_API_INCLUDES}/steam_gameserver.h"
		"${STEAM_API_INCLUDES}/steamclientpublic.h"
		"${STEAM_API_INCLUDES}/steamcontrollerpublic.h"
		"${STEAM_API_INCLUDES}/steamhttpenums.h"
		"${STEAM_API_INCLUDES}/steamtypes.h"
		"${STEAM_API_INCLUDES}/steamuniverse.h"
		"${STEAM_API_INCLUDES}/steamvr.h"
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
