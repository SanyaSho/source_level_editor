#-----------------------------------------------------------------------------
#	hammer_launcher.cmake
#
#	Project Script
#-----------------------------------------------------------------------------

cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

# CMAKETODO:
#	$Compiler
#	{
#		$AdditionalOptions					"$BASE /EHa"
#	}

set( HAMMER_LAUNCHER_SOURCE_FILES )
BEGIN_SRC( HAMMER_LAUNCHER_SOURCE_FILES "Source Files" )
	SRC_GRP(
		SOURCES
		#$Folder "Source Files"
		#{
			"main.cpp"
		#}
	)
END_SRC( HAMMER_LAUNCHER_SOURCE_FILES "Source Files" )

BEGIN_SRC( HAMMER_LAUNCHER_SOURCE_FILES "Resources" )
	SRC_GRP(
		SOURCES
		#$Folder "Resources" [$WIN32]
		#{
			"$<${IS_WINDOWS}:hammer_launcher.rc>"
			"$<${IS_WINDOWS}:hammer_launcher.ico>"
			"$<${IS_WINDOWS}:idr_manifest.ico>"
			"$<${IS_WINDOWS}:sle_icon.ico>"
			"$<${IS_WINDOWS}:new_sle_icon.ico>"
		#}
	)
END_SRC( HAMMER_LAUNCHER_SOURCE_FILES "Resources" )

add_object(
	TARGET hammer_launcher
	EXECUTABLE
	WIN32
	PROPERTY_FOLDER "Hammer//Executables"
	INSTALL_OUTNAME "level_editor"
	#INSTALL_DEST "${GAMEDIR}/bin"
	INSTALL_DEST "${GAMEDIR}"
	EXCLUDE_SOURCE "${SRCDIR}/public/tier0/memoverride.cpp"
	SOURCES ${HAMMER_LAUNCHER_SOURCE_FILES}
)

target_link_options(
	hammer_launcher PRIVATE

	"LINKER:/LARGEADDRESSAWARE"
)

target_link_libraries(
	hammer_launcher PRIVATE

	appframework
)

