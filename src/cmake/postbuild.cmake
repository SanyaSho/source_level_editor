#=============================================================================
# postbuild.cmake
#
# $
#=============================================================================

include_guard( GLOBAL )

function( target_strip_symbols target )

	if( ${IS_LINUX} )
		add_custom_command(
			TARGET ${target} POST_BUILD
			COMMAND ${CMAKE_OBJCOPY} --only-keep-debug "$<TARGET_FILE:${target}>" "$<TARGET_FILE:${target}>.dbg"
			COMMAND ${CMAKE_STRIP} --strip-debug "$<TARGET_FILE:${target}>"
			COMMAND ${CMAKE_OBJCOPY} --add-gnu-debuglink="$<TARGET_FILE:${target}>.dbg" "$<TARGET_FILE:${target}>"
		)

		set_property(
			TARGET ${target}
			APPEND PROPERTY ADDITIONAL_CLEAN_FILES "$<TARGET_FILE:${target}>.dbg"
		)

		if( ${IS_DEDICATED} )
			# Replace the needed library without having a duplicate in the lib/public/linux64
			add_custom_command(
				TARGET ${target} POST_BUILD
				COMMAND ${PATCHELF_EXE} --replace-needed libtier0.so libtier0_srv.so "$<TARGET_FILE:${target}>"
				COMMAND ${PATCHELF_EXE} --replace-needed libvstdlib.so libvstdlib_srv.so "$<TARGET_FILE:${target}>"
			)
		endif()
	endif()

endfunction()
