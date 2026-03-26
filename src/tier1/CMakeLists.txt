#-----------------------------------------------------------------------------
#	tier1
#
#	Project Script
#-----------------------------------------------------------------------------

cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

set( TIER1_SOURCE_FILES )
BEGIN_SRC( TIER1_SOURCE_FILES "Source Files" )
	SRC_GRP(
		SOURCES
		#{
			"bitbuf.cpp"
			"newbitbuf.cpp"
			"byteswap.cpp"
			"characterset.cpp"
			"checksum_crc.cpp"
			"checksum_md5.cpp"
			"checksum_sha1.cpp"
			"commandbuffer.cpp"
			"convar.cpp"
			"datamanager.cpp"
			"diff.cpp"
			"generichash.cpp"
			"ilocalize.cpp"
			"interface.cpp"
			"KeyValues.cpp"
			"keyvaluesjson.cpp"
			"kvpacker.cpp"
			"lzmaDecoder.cpp"
			"lzss.cpp"
			"mempool.cpp"
			"memstack.cpp"
			"NetAdr.cpp"
			"splitstring.cpp"
			"$<${IS_LINUX}:math_proxy.cpp>"
			"$<${IS_WINDOWS}:processor_detect.cpp>"
			"$<${IS_POSIX}:processor_detect_linux.cpp>"
			"$<${IS_LINUX}:qsort_s.cpp>"
			"rangecheckedvar.cpp"
			"reliabletimer.cpp"
			"stringpool.cpp"
			"strtools.cpp"
			"strtools_unicode.cpp"
			"tier1.cpp"
			"tokenreader.cpp"
			"sparsematrix.cpp"
			"uniqueid.cpp"
			"utlbuffer.cpp"
			"utlbufferutil.cpp"
			"utlstring.cpp"
			"utlsymbol.cpp"
			"utlbinaryblock.cpp"
			"$<${IS_LINUX}:pathmatch.cpp>"
			"snappy.cpp"
			"snappy-sinksource.cpp"
			"snappy-stubs-internal.cpp"
		#}
	)
END_SRC( TIER1_SOURCE_FILES "Source Files" )

if( ${IS_WINDOWS} )
	set_source_files_properties(
		"processor_detect.cpp" PROPERTIES
		COMPILE_FLAGS /EHsc
	)
endif()

BEGIN_SRC( TIER1_SOURCE_FILES "LZMA Decompression Support" )
	SRC_GRP(
		SOURCES
		#{
			"${SRCDIR}/utils/lzma/C/LzmaDec.h"
			"${SRCDIR}/utils/lzma/C/LzmaDec.c"
			"${SRCDIR}/utils/lzma/C/7zTypes.h"
		#}
	)
END_SRC( TIER1_SOURCE_FILES "LZMA Decompression Support" )

set( TIER1_HEADER_FILES )
BEGIN_SRC( TIER1_HEADER_FILES "Header Files" )
	SRC_GRP(
		SOURCES
		#{
			"${SRCDIR}/public/tier1/bitbuf.h"
			"${SRCDIR}/public/tier1/byteswap.h"
			"${SRCDIR}/public/tier1/callqueue.h"
			"${SRCDIR}/public/tier1/characterset.h"
			"${SRCDIR}/public/tier1/checksum_crc.h"
			"${SRCDIR}/public/tier1/checksum_md5.h"
			"${SRCDIR}/public/tier1/checksum_sha1.h"
			"${SRCDIR}/public/tier1/CommandBuffer.h"
			"${SRCDIR}/public/tier1/convar.h"
			"${SRCDIR}/public/tier1/datamanager.h"
			"${SRCDIR}/public/datamap.h"
			"${SRCDIR}/public/tier1/delegates.h"
			"${SRCDIR}/public/tier1/diff.h"
			"${SRCDIR}/public/tier1/fmtstr.h"
			"${SRCDIR}/public/tier1/functors.h"
			"${SRCDIR}/public/tier1/generichash.h"
			"${SRCDIR}/public/tier1/iconvar.h"
			"${SRCDIR}/public/tier1/ilocalize.h"
			"${SRCDIR}/public/tier1/interface.h"
			"${SRCDIR}/public/tier1/KeyValues.h"
			"${SRCDIR}/public/tier1/kvpacker.h"
			"${SRCDIR}/public/tier1/lzmaDecoder.h"
			"${SRCDIR}/public/tier1/lzss.h"
			"${SRCDIR}/public/tier1/mempool.h"
			"${SRCDIR}/public/tier1/memstack.h"
			"${SRCDIR}/public/tier1/netadr.h"
			"${SRCDIR}/public/tier1/processor_detect.h"
			"${SRCDIR}/public/tier1/rangecheckedvar.h"
			"${SRCDIR}/public/tier1/refcount.h"
			"${SRCDIR}/public/tier1/smartptr.h"
			"${SRCDIR}/public/tier1/snappy.h"
			"${SRCDIR}/public/tier1/snappy-sinksource.h"
			"${SRCDIR}/public/tier1/stringpool.h"
			"${SRCDIR}/public/tier1/strtools.h"
			"${SRCDIR}/public/tier1/tier1.h"
			"${SRCDIR}/public/tier1/tokenreader.h"
			"$<${IS_WINDOWS}:${SRCDIR}/public/tier1/uniqueid.h>"
			"${SRCDIR}/public/tier1/utlbidirectionalset.h"
			"${SRCDIR}/public/tier1/utlblockmemory.h"
			"${SRCDIR}/public/tier1/utlbuffer.h"
			"${SRCDIR}/public/tier1/utlbufferutil.h"
			"${SRCDIR}/public/tier1/utlcommon.h"
			"${SRCDIR}/public/tier1/utldict.h"
			"${SRCDIR}/public/tier1/utlenvelope.h"
			"${SRCDIR}/public/tier1/utlfixedmemory.h"
			"${SRCDIR}/public/tier1/utlhandletable.h"
			"${SRCDIR}/public/tier1/utlhash.h"
			"${SRCDIR}/public/tier1/utlhashtable.h"
			"${SRCDIR}/public/tier1/utllinkedlist.h"
			"${SRCDIR}/public/tier1/utlmap.h"
			"${SRCDIR}/public/tier1/utlmemory.h"
			"${SRCDIR}/public/tier1/utlmultilist.h"
			"${SRCDIR}/public/tier1/utlpriorityqueue.h"
			"${SRCDIR}/public/tier1/utlqueue.h"
			"${SRCDIR}/public/tier1/utlrbtree.h"
			"${SRCDIR}/public/tier1/UtlSortVector.h"
			"${SRCDIR}/public/tier1/utlstack.h"
			"${SRCDIR}/public/tier1/utlstring.h"
			"${SRCDIR}/public/tier1/UtlStringMap.h"
			"${SRCDIR}/public/tier1/utlsymbol.h"
			"${SRCDIR}/public/tier1/utlsymbollarge.h"
			"${SRCDIR}/public/tier1/utlvector.h"
			"${SRCDIR}/public/tier1/utlbinaryblock.h"
			"$<${IS_WINDOWS}:${SRCDIR}/common/xbox/xboxstubs.h>"
		#}
	)

	SRC_GRP(
		SUBGROUP "Internal Header Files"
		SOURCES
		#{
			"snappy-internal.h"
			"snappy-stubs-internal.h"
		#}
	)
END_SRC( TIER1_HEADER_FILES "Header Files" )

add_object(
	TARGET tier1
	STATIC
	SOURCES ${TIER1_SOURCE_FILES} ${TIER1_HEADER_FILES}
)

target_compile_definitions(
	tier1 PRIVATE

	TIER1_STATIC_LIB
)

target_link_libraries(
	tier1 PRIVATE

	"$<${IS_WINDOWS}:Rpcrt4>"
)
