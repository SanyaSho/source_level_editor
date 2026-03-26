#=============================================================================
#	matsys_controls.cmake
#
#	Project Script
#=============================================================================
cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

set( MATSYS_CONTROLS_SOURCE_FILES )
BEGIN_SRC( MATSYS_CONTROLS_SOURCE_FILES "Source Files" )
	SRC_GRP(
		SOURCES
		#$Folder "Source Files"
		#{
			"assetpicker.cpp"
			"baseassetpicker.cpp"
			"colorpickerpanel.cpp"
			"curveeditorpanel.cpp"
			"gamefiletreeview.cpp"
			"manipulator.cpp"
			"matsyscontrols.cpp"
			"mdlpanel.cpp"
			"mdlpicker.cpp"
			"mdlsequencepicker.cpp"
			"picker.cpp"
			"potterywheelpanel.cpp"
			"proceduraltexturepanel.cpp"
			"QCGenerator.cpp"
			"sequencepicker.cpp"
			"tgapreviewpanel.cpp"
			"vmtpicker.cpp"
			"vmtpreviewpanel.cpp"
			"vtfpicker.cpp"
			"vtfpreviewpanel.cpp"
			"vmtpanel.cpp"
		#}
	)

	# SLE
	SRC_GRP(
		SUBGROUP "particles_new"
		SOURCES
		#{
			"${SRCDIR}/vgui2/dme_controls/dmepanel.cpp"
			"${SRCDIR}/vgui2/dme_controls/particlesystempanel.cpp"
		#}
	)
END_SRC( MATSYS_CONTROLS_SOURCE_FILES "Source Files" )

set( MATSYS_CONTROLS_HEADER_FILES )
BEGIN_SRC( MATSYS_CONTROLS_HEADER_FILES "Header Files" )
	SRC_GRP(
		SOURCES
		#$Folder "Header Files"
		#{
			"${SRCDIR}/public/matsys_controls/assetpicker.h"
			"${SRCDIR}/public/matsys_controls/baseassetpicker.h"
			"${SRCDIR}/public/matsys_controls/colorpickerpanel.h"
			"${SRCDIR}/public/matsys_controls/gamefiletreeview.h"
			"${SRCDIR}/public/matsys_controls/manipulator.h"
			"${SRCDIR}/public/matsys_controls/matsyscontrols.h"
			"${SRCDIR}/public/matsys_controls/mdlpanel.h"
			"${SRCDIR}/public/matsys_controls/mdlpicker.h"
			"${SRCDIR}/public/matsys_controls/mdlsequencepicker.h"
			"${SRCDIR}/public/matsys_controls/picker.h"
			"${SRCDIR}/public/matsys_controls/potterywheelpanel.h"
			"${SRCDIR}/public/matsys_controls/proceduraltexturepanel.h"
			"${SRCDIR}/public/matsys_controls/QCGenerator.h"
			"${SRCDIR}/public/matsys_controls/sequencepicker.h"
			"${SRCDIR}/public/matsys_controls/tgapreviewpanel.h"
			"${SRCDIR}/public/matsys_controls/vmtpicker.h"
			"${SRCDIR}/public/matsys_controls/vmtpreviewpanel.h"
			"${SRCDIR}/public/matsys_controls/vtfpicker.h"
			"${SRCDIR}/public/matsys_controls/vtfpreviewpanel.h"
			"${SRCDIR}/public/matsys_controls/vmtpanel.h"

			# SLE
			"${SRCDIR}/public/dme_controls/particlesystempanel.h"
		#}
	)
END_SRC( MATSYS_CONTROLS_HEADER_FILES "Header Files" )

add_object(
	TARGET matsys_controls
	STATIC
	SOURCES ${MATSYS_CONTROLS_SOURCE_FILES} ${MATSYS_CONTROLS_HEADER_FILES}
)

target_link_libraries(
	matsys_controls PRIVATE

	$<${IS_WINDOWS}:bitmap>
)
