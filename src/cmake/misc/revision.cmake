#=============================================================================
# revision.cmake
#
# Utility CMake file called by update_revision target.
#=============================================================================

set( BUILD_GIT_COMMIT "0000000" )
set( BUILD_GIT_BRANCH "unknown" )

# When built using GitLab CI, especially when clonning mode set to FETCH the branch will show HEAD and the commit always will have the "-dirty" prefix.
# This is a small hack only for CI that uses vars set by GitLab as current revision variables.
if( DEFINED ENV{CI_COMMIT_SHORT_SHA} AND DEFINED ENV{CI_COMMIT_REF_NAME} )
	set( BUILD_GIT_COMMIT "$ENV{CI_COMMIT_SHORT_SHA}" )
	set( BUILD_GIT_BRANCH "$ENV{CI_COMMIT_REF_NAME}" )
else()
	# Try to find Git executable
	find_program( GIT_EXE git )

	if ( NOT ${GIT_EXE} MATCHES "NOTFOUND" )
		# Get the commit - fa55cb6-dirty
		execute_process(
			COMMAND ${GIT_EXE} describe --always --dirty --abbrev=7 --exclude "*"
			OUTPUT_VARIABLE BUILD_GIT_COMMIT
			OUTPUT_STRIP_TRAILING_WHITESPACE
		)

		# Get the branch - master
		execute_process(
			COMMAND ${GIT_EXE} rev-parse --abbrev-ref HEAD
			OUTPUT_VARIABLE BUILD_GIT_BRANCH
			OUTPUT_STRIP_TRAILING_WHITESPACE
		)
	endif()
endif()

# Configure the temp script
configure_file( "${INPUT}" "${OUTPUT}.tmp" @ONLY )

# Check if we actually have the values changed
execute_process(
	COMMAND ${CMAKE_COMMAND} -E compare_files "${OUTPUT}.tmp" "${OUTPUT}"
	RESULT_VARIABLE SAME
)

if ( NOT SAME EQUAL 0 )
	message( STATUS "Commit: ${BUILD_GIT_COMMIT}" )
	message( STATUS "Branch: ${BUILD_GIT_BRANCH}" )

	# Silently rename the temp file
	file( RENAME "${OUTPUT}.tmp" "${OUTPUT}" )
else()
	# Revision wasn't changed, remove the temp file
	file( REMOVE "${OUTPUT}.tmp" )
endif()
