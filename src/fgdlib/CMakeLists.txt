#-----------------------------------------------------------------------------
#	fgdlib
#
#	Project Script
#-----------------------------------------------------------------------------

cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

set( FGDLIB_SOURCE_FILES )
BEGIN_SRC( FGDLIB_SOURCE_FILES "Source Files" )
	SRC_GRP(
		SOURCES
		#{
			"gamedata.cpp"
			"gdclass.cpp"
			"gdvar.cpp"
			"inputoutput.cpp"
			"wckeyvalues.cpp"
		#}
	)
END_SRC( FGDLIB_SOURCE_FILES "Source Files" )

set( FGDLIB_HEADER_FILES )
BEGIN_SRC( FGDLIB_HEADER_FILES "Header Files" )
	SRC_GRP(
		SOURCES
		#{
			"${SRCDIR}/public/fgdlib/fgdlib.h"
			"${SRCDIR}/public/fgdlib/gamedata.h"
			"${SRCDIR}/public/fgdlib/gdclass.h"
			"${SRCDIR}/public/fgdlib/gdvar.h"
			"${SRCDIR}/public/fgdlib/helperinfo.h"
			"${SRCDIR}/public/fgdlib/ieditortexture.h"
			"${SRCDIR}/public/fgdlib/inputoutput.h"
			"${SRCDIR}/public/fgdlib/wckeyvalues.h"
		#}
	)
END_SRC( FGDLIB_HEADER_FILES "Header Files" )

add_object(
	TARGET fgdlib
	STATIC
	SOURCES ${FGDLIB_SOURCE_FILES} ${FGDLIB_HEADER_FILES}
)

target_include_directories(
	fgdlib PRIVATE

	"${SRCDIR}/utils/common"
)
