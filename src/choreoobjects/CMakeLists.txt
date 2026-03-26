#-----------------------------------------------------------------------------
#	choreoobjects
#
#	Project Script
#-----------------------------------------------------------------------------

# Use this to extract the file list or open the .lib and check for .objs
#$ strings choreoobjects.lib | grep .cpp | grep rel_multiplayer
#$ strings choreoobjects.lib | grep -i .h | grep rel_multiplayer

cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

set( CHOREOOBJECTS_SOURCE_FILES )
BEGIN_SRC( CHOREOOBJECTS_SOURCE_FILES "Source Files" )
	SRC_GRP(
		SOURCES
		#{
			"${SRCDIR}/game/shared/sceneimage.cpp"
			"${SRCDIR}/game/shared/choreoscene.cpp"
			"${SRCDIR}/game/shared/choreoevent.cpp"
			"${SRCDIR}/game/shared/choreochannel.cpp"
			"${SRCDIR}/game/shared/choreoactor.cpp"
		#}
	)
END_SRC( CHOREOOBJECTS_SOURCE_FILES "Source Files" )

set( CHOREOOBJECTS_HEADER_FILES )
BEGIN_SRC( CHOREOOBJECTS_HEADER_FILES "Header Files" )
	SRC_GRP(
		SOURCES
		#{
			"${SRCDIR}/game/shared/choreoactor.h"
			"${SRCDIR}/game/shared/choreochannel.h"
			"${SRCDIR}/game/shared/choreoevent.h"
			"${SRCDIR}/game/shared/choreoscene.h"
			"${SRCDIR}/game/shared/ichoreoeventcallback.h"
			"${SRCDIR}/game/shared/sceneimage.h"
			"${SRCDIR}/game/shared/expressionsample.h"
		#}
	)
END_SRC( CHOREOOBJECTS_HEADER_FILES "Header Files" )

add_object(
	TARGET choreoobjects
	STATIC
	SOURCES ${CHOREOOBJECTS_SOURCE_FILES} ${CHOREOOBJECTS_HEADER_FILES}
)

target_include_directories(
	choreoobjects PRIVATE

	"${SRCDIR}/utils/common"
)
