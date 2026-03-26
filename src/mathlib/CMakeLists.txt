#-----------------------------------------------------------------------------
#	mathlib
#
#	Project Script
#-----------------------------------------------------------------------------

cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

set( MATHLIB_SOURCE_FILES )
BEGIN_SRC( MATHLIB_SOURCE_FILES "Source Files" )
	SRC_GRP(
		SOURCES
		#{
			"color_conversion.cpp"
			"halton.cpp"
			"lightdesc.cpp"
			"mathlib_base.cpp"
			"powsse.cpp"
			"sparse_convolution_noise.cpp"
			"sseconst.cpp"
			"$<$<OR:${IS_WINDOWS},${IS_POSIX}>:sse.cpp>"
			"ssenoise.cpp"				
			"$<$<OR:${IS_WINDOWS},${IS_POSIX}>:3dnow.cpp>"
			"anorms.cpp"
			"bumpvects.cpp"
			"IceKey.cpp"
			"imagequant.cpp"
			"polyhedron.cpp"
			"quantize.cpp"
			"randsse.cpp"
			"spherical.cpp"
			"simdvectormatrix.cpp"
			"vector.cpp"
			"vmatrix.cpp"
			"almostequal.cpp"
		#}
	)
END_SRC( MATHLIB_SOURCE_FILES "Source Files" )

set( MATHLIB_HEADER_FILES )
BEGIN_SRC( MATHLIB_HEADER_FILES "Public Header Files" )
	SRC_GRP(
		SOURCES
		#{
			"$<$<OR:${IS_WINDOWS},${IS_POSIX}>:${SRCDIR}/public/mathlib/amd3dx.h>"
			"${SRCDIR}/public/mathlib/anorms.h"
			"${SRCDIR}/public/mathlib/bumpvects.h"		
			"${SRCDIR}/public/mathlib/compressed_3d_unitvec.h"
			"${SRCDIR}/public/mathlib/compressed_light_cube.h"
			"${SRCDIR}/public/mathlib/compressed_vector.h"
			"${SRCDIR}/public/mathlib/halton.h"
			"${SRCDIR}/public/mathlib/IceKey.H"
			"${SRCDIR}/public/mathlib/lightdesc.h"
			"${SRCDIR}/public/mathlib/math_pfns.h"
			"${SRCDIR}/public/mathlib/mathlib.h"
			"${SRCDIR}/public/mathlib/noise.h"
			"${SRCDIR}/public/mathlib/polyhedron.h"
			"${SRCDIR}/public/mathlib/quantize.h"
			"${SRCDIR}/public/mathlib/simdvectormatrix.h"
			"${SRCDIR}/public/mathlib/spherical_geometry.h"		
			"${SRCDIR}/public/mathlib/ssemath.h"		
			"${SRCDIR}/public/mathlib/ssequaternion.h"		
			"${SRCDIR}/public/mathlib/vector.h"
			"${SRCDIR}/public/mathlib/vector2d.h"
			"${SRCDIR}/public/mathlib/vector4d.h"
			"${SRCDIR}/public/mathlib/vmatrix.h"
			"${SRCDIR}/public/mathlib/vplane.h"
		#}
	)
END_SRC( MATHLIB_HEADER_FILES "Public Header Files" )

BEGIN_SRC( MATHLIB_HEADER_FILES "Header Files" )
	SRC_GRP(
		SOURCES
		#{
			"noisedata.h"
			"$<$<OR:${IS_WINDOWS},${IS_POSIX}>:sse.h>"
			"$<$<OR:${IS_WINDOWS},${IS_POSIX}>:3dnow.h>"
		#}
	)
END_SRC( MATHLIB_HEADER_FILES "Header Files" )

add_object(
	TARGET mathlib
	STATIC
	SOURCES ${MATHLIB_SOURCE_FILES} ${MATHLIB_HEADER_FILES}
)

target_compile_definitions(
	mathlib PRIVATE

	MATHLIB_LIB
)

target_include_directories(
	mathlib PRIVATE

	"${SRCDIR}/public/mathlib"
)