#-----------------------------------------------------------------------------
#	raytrace
#
#	Project Script
#-----------------------------------------------------------------------------

cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

set( RAYTRACE_SOURCE_FILES )
BEGIN_SRC( RAYTRACE_SOURCE_FILES "Source Files" )
	SRC_GRP(
		SOURCES
		#{
			"raytrace.cpp"
			"trace2.cpp"
			"trace3.cpp"
		#}
	)
END_SRC( RAYTRACE_SOURCE_FILES "Source Files" )

add_object(
	TARGET raytrace
	STATIC
	SOURCES ${RAYTRACE_SOURCE_FILES}
)

target_include_directories(
	raytrace PRIVATE

	"${SRCDIR}/utils/common"
)