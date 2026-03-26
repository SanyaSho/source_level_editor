#=============================================================================
#	hammer_dll.cmake
#
#	Project Script
#=============================================================================

cmake_minimum_required( VERSION 3.20 FATAL_ERROR )

# CMAKETODO:
#	$AdditionalOptions				"$BASE /EHa"

set( UTILS_DIR "${SRCDIR}/utils" )

set( HAMMER_DLL_SOURCE_FILES )
BEGIN_SRC( HAMMER_DLL_SOURCE_FILES "Source Files" )
	SRC_GRP(
		SOURCES
		#{
			"AnchorMgr.cpp"
			"AnchorMgr.h"
			"AngleBox.cpp"
			"AngleBox.h"
			"AutoSelCombo.cpp"
			"AutoSelCombo.h"
			"VisGroup.cpp"
			"VisGroup.h"
			#"Noise.h"
			"BlockArray.h"

			"MapDoc.cpp"
			"MapDoc.h"
			"treelist.cpp"
			"treelist.h"
			"FilteredComboBox.cpp"
			"FilteredComboBox.h"
			"particlebrowser.cpp"
			"particlebrowser.h"
			"Prefab3D.cpp"
			"Prefab3D.h"
			"Prefabs.cpp"
			"Prefabs.h"
			"keybinds.cpp"
			"keybinds.h"
			"FilterControl.cpp"
			"FilterControl.h"
			"Manifest.cpp"
			"Manifest.h"
			"TargetNameCombo.cpp"
			"TargetNameCombo.h"
			"SoundBrowser.cpp"
			"SoundBrowser.h"
			"soundsystem.cpp"
			"soundsystem.h"
			"LoadSave_MAP.cpp"
			"LoadSave_RMF.cpp"
			"GroupList.cpp"
			"GroupList.h"
			"SaveInfo.cpp"
			#"SafeInfo.h"
			"HammerScene.cpp"
			"HammerScene.h"
			"IconComboBox.cpp"
			"IconComboBox.h"
			"RichEditCtrlEx.cpp"
			"RichEditCtrlEx.h"
		#}
		NO_PCH
		#{
			"SaveInfo.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "Dialogs"
		SOURCES
		#{
			"ArchDlg.cpp"
			"DispDlg.cpp"
			"DispDlg.h"
			"EditGroups.cpp"
			"EditGroups.h"
			"EditPathDlg.cpp"
			"EditPathDlg.h"
			"EditPathNodeDlg.cpp"
			"EditPathNodeDlg.h"
			"EditPrefabDlg.cpp"
			"EditPrefabDlg.h"
			"EntityHelpDlg.cpp"
			"EntityHelpDlg.h"
			"EntityReportDlg.cpp"
			"EntityReportDlg.h"
			"FaceEdit_DispPage.cpp"
			"FaceEdit_MaterialPage.cpp"
			"FaceEditSheet.cpp"
			"FaceEditSheet.h"
			"GotoBrushDlg.cpp"
			"hammerbar.cpp"
			"MapAnimationDlg.cpp"
			"MapCheckDlg.cpp"
			"MapDiffDlg.cpp"
			"MapInfoDlg.cpp"
			"NewKeyValue.cpp"
			"NewVisGroupDlg.cpp"
			"PasteSpecialDlg.cpp"
			"ProgDlg.cpp"
			"ReplaceTexDlg.cpp"
			"RunMapCfgDlg.cpp"
			"RunMapExpertDlg.cpp"
			"ScenePreviewDlg.cpp"
			"ScaleVerticesDlg.cpp"
			"SearchReplaceDlg.cpp"
			"SelectEntityDlg.cpp"
			"SelectModeDlgBar.cpp"
			"StrDlg.cpp"
			"TextureBar.cpp"
			"texturebrowser.cpp"
			"TorusDlg.cpp"
			"TransformDlg.cpp"
			"ManifestDialog.cpp"
			"PrefabsDlg.cpp"
			"entitysprinkledlg.cpp"
			"TextureBox.cpp"
			"ButtonContext.cpp"
			"EditGameConfigs.cpp"
			"DynamicDialogWnd.cpp"
			"dlglistmanage.cpp"
			"ModelBrowser.cpp"
			"NewDocType.cpp"
			"RunMap.cpp"
			"SmoothingGroupsDlg.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "Dialogs/Object Properties"
		SOURCES
		#{
			"ObjectProperties.cpp"
			"ObjectProperties.h"
			"OP_Entity.cpp"
			"OP_Entity.h"
			"OP_Flags.cpp"
			"OP_Flags.h"
			"OP_Groups.cpp"
			"OP_Groups.h"
			"OP_Input.cpp"
			"OP_Input.h"
			"OP_Model.cpp"
			"OP_Model.h"
			"OP_Output.cpp"
			"OP_Output.h"
			"ObjectPage.cpp"
			"ObjectPage.h"
		#}
	)

	SRC_GRP(
		SUBGROUP "Dialogs/Editor Config"
		SOURCES
		#{
			"OPTView3D.cpp"
			"OPTView3D.h"
			"OPTView2D.cpp"
			"OPTView2D.h"
			"OPTGeneral.cpp"
			"OPTGeneral.h"
			"OPTConfigs.cpp"
			"OPTConfigs.h"
			"OPTBuild.cpp"
			"OPTBuild.h"
			"OPTColor.cpp"
			"OPTColor.h"
			"OptionProperties.cpp"
			"Options.cpp"
			"OPTTextures.cpp"
			"OPTTextures.h"
		#}
	)

	SRC_GRP(
		SUBGROUP "Map Classes"
		SOURCES
		#{
			"MapDecal.cpp"
			"MapDecal.h"
			"MapDisp.cpp"
			"MapDisp.h"
			"MapDoc.cpp"
			"MapDoc.h"
			"MapEntity.cpp"
			"MapEntity.h"
			"mapcylinder.cpp"
			"MapClass.cpp"
			"MapAxisHandle.cpp"
			"MapAnimator.cpp"
			"MapAlignedBox.cpp"
			"MapEntity.cpp"
			"MapEntity.h"
			"MapErrorsDlg.cpp"
			"MapErrorsDlg.h"
			"MapFace.cpp"
			"MapFace.h"
			"MapFrustum.cpp"
			"MapFrustum.h"
			"MapGroup.cpp"
			"MapGroup.h"
			"MapHelper.cpp"
			"MapHelper.h"
			"MapInstance.cpp"
			"MapInstance.h"
			"MapKeyFrame.cpp"
			"MapKeyFrame.h"
			"MapLight.cpp"
			"MapLight.h"
			"MapLightCone.cpp"
			"MapLightCone.h"
			"MapLine.cpp"
			"MapLine.h"
			"MapOverlay.cpp"
			"MapOverlay.h"
			"mapoverlaytrans.cpp"
			"MapPath.cpp"
			"MapPath.h"
			"mapplayerhullhandle.cpp"
			"MapPoint.cpp"
			"MapPoint.h"
			"MapSideList.cpp"
			"MapSideList.h"
			"MapSolid.cpp"
			"MapSolid.h"
			"MapQuadBounds.cpp"
			"MapQuadBounds.h"
			"MapPointHandle.cpp"
			"MapPointHandle.h"
			"MapSprite.cpp"
			"MapSprite.h"
			"MapStudioModel.cpp"
			"MapStudioModel.h"
			"MapSphere.cpp"
			"MapSphere.h"
			"mapsweptplayerhull.cpp"
			"MapWorld.cpp"
			"MapWorld.h"
			"mapspotlight.cpp"
			"mapworldtext.cpp"
			"mapdirectionvisualizer.cpp"
			"mapornament.cpp"
			"mapsunhelper.cpp"
			"MapSpriteBeam.cpp"
			"maprotationdistancevisualizer.cpp"
			"mapimagepanel.cpp"
			"EditGameClass.cpp"
			"EntityConnection.cpp"
			"EntityConnection.h"
			"HelperFactory.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "Tools"
		SOURCES
		#{
			"Box3D.cpp"
			"Box3D.h"
			"ToolBase.cpp"
			#"ToolBase.h"
			"ToolBlock.cpp"
			"ToolBlock.h"
			"ToolCamera.cpp"
			"ToolCamera.h"
			"ToolAxisHandle.cpp"
			"ToolAxisHandle.h"
			"Tool3D.cpp"
			"Tool3D.h"
			"ToolClipper.cpp"
			"ToolClipper.h"
			"ToolCordon.cpp"
			"ToolCordon.h"
			"ToolDecal.cpp"
			"ToolDecal.h"
			"ToolDisplace.cpp"
			"ToolDisplace.h"
			"ToolEntity.cpp"
			"ToolEntity.h"
			"ToolMagnify.cpp"
			"ToolMagnify.h"
			"ToolManager.cpp"
			"ToolManager.h"
			"ToolMaterial.cpp"
			"ToolMaterial.h"
			"ToolOverlay.cpp"
			"ToolOverlay.h"
			"ToolPickAngles.cpp"
			"ToolPickAngles.h"
			"ToolPickEntity.cpp"
			"ToolPickEntity.h"
			"ToolPickFace.cpp"
			"ToolPickFace.h"
			"ToolPointHandle.cpp"
			"ToolPointHandle.h"
			"ToolSelection.cpp"
			"ToolSelection.h"
			"ToolSphere.cpp"
			"ToolSphere.h"
			"ToolSprinkle.cpp"
			"ToolSprinkle.h"
			"toolswepthull.cpp"
			"ToolVertexEdit.cpp"
			"ToolVertexEdit.h"
			"Gizmo.cpp"
			"Gizmo.h"
			"StockSolids.cpp"
			"cordonlist.cpp"
			"CreateArchAndTorus.cpp"
			"ObjectBar.cpp"
			"Selection.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "Displacements"
		SOURCES
		#{
			"${SRCDIR}/public/disp_common.cpp"
			"${SRCDIR}/public/disp_powerinfo.cpp"
			"DispManager.cpp"
			"DispManager.h"
			"DispMapImageFilter.cpp"
			"DispPaint.cpp"
			"DispSew.cpp"
			"DispShore.cpp"
			"DispSubdiv.cpp"
			"${SRCDIR}/public/builddisp.cpp"
			"DetailObjects.cpp"
			"SculptOptions.cpp"
		#}
		NO_PCH
		#{
			"${SRCDIR}/public/disp_common.cpp"
			"${SRCDIR}/public/disp_powerinfo.cpp"
			"${SRCDIR}/public/builddisp.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "MaterialSystem"
		SOURCES
		#{
			"DummyTexture.cpp"
			"Material.cpp"
			"Material.h"
			"TextureSystem.cpp"
			"TextureConverter.cpp"
			"TextureWindow.cpp"
			"Texture.cpp"
			"Texture.h"
			"materialproxyfactory_wc.cpp"
			"WADTexture.cpp"
			"gamepalette.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "Viewports and Render"
		SOURCES
		#{
			"Camera.cpp"
			"Camera.h"
			"Render3DMS.cpp"
			"Render3DMS.h"
			"Render2D.cpp"
			"Render2D.h"
			"Render.cpp"
			"Render.h"
			"mapviewlogical.cpp"
			"MapView3D.cpp"
			"mapview2dbase.cpp"
			"MapView2D.cpp"
			"MapView.cpp"
			"beamdraw.cpp"
			"RenderUtils.cpp"
			"RenderUtils.h"
			"CullTreeNode.cpp"
			"CullTreeNode.h"
			"ViewerSettings.cpp"
			"ViewerSettings.h"
			"Sprite.cpp"
			"StudioModel.cpp"
			"TitleWnd.cpp"
		#}
		NO_PCH
		#{
			"Camera.cpp"
			"ViewerSettings.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "Viewports and Render//Lighting"
		SOURCES
		#{
			"lprvwindow.cpp"
			"lpreview_thread.cpp"
			"bsplightingthread.cpp"
			"bsplighting.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "Shell and Framework"
		SOURCES
		#{
			"ChildFrm.cpp"
			"ChildFrm.h"
			"BuildNum.cpp"
			"BuildNum.h"
			"MainFrm.cpp"
			"MainFrm.h"
			"MDIClientWnd.cpp"
			"MDIClientWnd.h"
			"Shell.cpp"
			"Shell.h"
			"ShellMessageWnd.cpp"
			"ShellMessageWnd.h"
			"Clock.cpp"
			"events.cpp"
			"FileChangeWatcher.cpp"
			"FileChangeWatcher.h"
			"gameconfig.cpp"
			"hammer.cpp"
			"hammer.h"
			"hammer_mathlib.cpp"
			"hammer_mathlib.h"
			"HammerVGui.cpp"
			"History.cpp"
			"History.h"
			"Keyboard.cpp"
			"Keyboard.h"
			"MessageWnd.cpp"
			"MessageWnd.h"
			"osver.cpp"
			"ProcessWnd.cpp"
			"ProcessWnd.h"
			"RunCommands.cpp"
			"RunCommands.h"
			"Splash.cpp"
			"Splash.h"
			"StdAfx.cpp"
			"StdAfx.h"
			"VGuiWnd.cpp"
			"VGuiWnd.h"
		#}
		NO_PCH
		#{
			"BuildNum.cpp"
			"hammer_mathlib.cpp"
		#}
	)

	SRC_GRP(
		SUBGROUP "Utils"
		SOURCES
		#{
			"BoundBox.cpp"
			"BoundBox.h"
			"BrushOps.cpp"
			"BrushOps.h"
			"clipcode.cpp"
			"clipcode.h"
			"MakePrefabLibrary.cpp"
			"misc.cpp"
			#"misc.h"
			"Noise.cpp"
			"Axes2.cpp"
			"Axes2.h"
			"SSolid.cpp"
			"tablet.cpp"
			"tablet.h"
		#}
	)

	SRC_GRP(
		SUBGROUP "Public"
		SOURCES
		#{
			"${SRCDIR}/public/tier0/afxmem_override.cpp"
			"${SRCDIR}/public/bone_setup.cpp"
			"${SRCDIR}/public/CollisionUtils.cpp"
			"${SRCDIR}/common/debug_dll_check.cpp"
			"${SRCDIR}/public/filesystem_helpers.cpp"
			"${SRCDIR}/public/filesystem_init.cpp"
			"${SRCDIR}/public/interpolatortypes.cpp"
			"${SRCDIR}/public/KeyFrame/keyframe.cpp"
			"${SRCDIR}/public/rope_physics.cpp"
			"${SRCDIR}/utils/common/scriplib.cpp"
			"${SRCDIR}/public/simple_physics.cpp"
			"${SRCDIR}/common/SourceAppInfo.cpp"
			"${SRCDIR}/public/studio.cpp"
			"${SRCDIR}/public/vgui_controls/vgui_controls.cpp"
			"${SRCDIR}/common/ConfigManager.cpp"
			"${SRCDIR}/common/ConfigManager.h"
			"${SRCDIR}/public/ChunkFile.cpp"
			"${SRCDIR}/public/ChunkFile.h"
		#}
		NO_PCH
		#{
			"${SRCDIR}/public/bone_setup.cpp"
			"${SRCDIR}/public/CollisionUtils.cpp"
			"${SRCDIR}/common/debug_dll_check.cpp"
			"${SRCDIR}/public/filesystem_helpers.cpp"
			"${SRCDIR}/public/filesystem_init.cpp"
			"${SRCDIR}/public/interpolatortypes.cpp"
			"${SRCDIR}/public/KeyFrame/keyframe.cpp"
			"${SRCDIR}/public/rope_physics.cpp"
			"${SRCDIR}/utils/common/scriplib.cpp"
			"${SRCDIR}/public/simple_physics.cpp"
			"${SRCDIR}/common/SourceAppInfo.cpp"
			"${SRCDIR}/public/studio.cpp"
			"${SRCDIR}/public/vgui_controls/vgui_controls.cpp"
			"${SRCDIR}/common/ConfigManager.cpp"
			"${SRCDIR}/public/ChunkFile.cpp"
		#}
	)
END_SRC( HAMMER_DLL_SOURCE_FILES "Source Files" )

BEGIN_SRC( HAMMER_DLL_SOURCE_FILES "Resource Files" )
	SRC_GRP(
		SOURCES
		#$Folder "Resource Files"
		#{
			"Hammer.rc"

			"res/afx_idi_.ico"
			#"res/bmp00002.bmp"
			"res/camera.ico"
			#"res/crosshair.cur"
			"res/crosshair.ico"
			#"res/cubechec.bmp"
			#"res/cur00001.cur"
			#"res/cur00002.cur"
			"res/cursor1.cur"
			#"res/cursor2.cur"
			#"res/cursor3.cur"
			"res/dispedit.bmp"
			#"res/entity.cur"
			#"res/eyedropper.cur"
			"res/eyedropper.ico"
			#"facepaint.cur"
			#"res/Forge.ico"
			#"res/ForgeDoc.ico"
			"res/forgemap.bmp"
			"res/gizmoaxis.bmp"
			"res/gizmorotate.bmp"
			"res/gizmoscale.bmp"
			"res/gizmotranslate.bmp"
			#"res/handclos.cur"
			#"res/handcurs.cur"
			#"res/ico00001.ico"
			#"res/ico00002.ico"
			#"res/ico00003.ico"
			#"res/ico00004.ico"
			#"res/icon1.ico"
			"res/idr_manifest.ico"
			"res/input.ico"
			"res/input_grey.ico"
			"res/inputbad.ico"
			"res/inputbad_grey.ico"
			#"res/magnify.cur"
			"res/manifest.bmp"
			"res/manifest2.bmp"
			#"res/mapdoc_n.bmp"
			"res/mapedit.bmp"
			"res/mapedit256.bmp"
			#"res/newsplash.bmp"
			"res/ouput.ico"
			"res/output_grey.ico"
			"res/outputbad.ico"
			"res/outputbad_grey.ico"
			#"res/paktypes.bmp"
			#"res/set_u.bmp"
			#"res/smartclick.cur"
			"res/texturew.ico"
			"res/treeroot.bmp"
			#"res/undoredo.bmp"
			"res/visgroup.bmp"

			#"res/bitmap1.bmp"
			#"res/cube.bmp"
			"res/loading.bmp"
			"res/new_sle_icon.ico"
			"res/sle_splash.bmp"
			"res/sle_splash_bmi.bmp"
			"res/sle_splash_bs.bmp"
			"res/sle_splash_cow.bmp"
			"res/sle_splash_css.bmp"
			"res/sle_splash_dc.bmp"
			"res/sle_splash_ep1.bmp"
			"res/sle_splash_ep2.bmp"
			"res/sle_splash_hl1.bmp"
			"res/sle_splash_hl2.bmp"
			"res/sle_splash_hla.bmp"
			"res/sle_splash_lc.bmp"
			"res/sle_splash_of.bmp"
			"res/sle_splash_portal.bmp"
			"res/sle_splash_portal2.bmp"
			"res/sle_splash_sep30.bmp"
			"res/sle_splash_space.bmp"
			"res/sle_splash_tf2.bmp"
			"res/toolbar256.bmp"
			"res/toolbar_grid_selection.bmp"
			"res/toolbar_main.bmp"
			"res/toolbar_map.bmp"
			"res/toolbar_undoredo.bmp"
			"res/toolbar_visibility.bmp"
		#}
	)
END_SRC( HAMMER_DLL_SOURCE_FILES "Resource Files" )

add_object(
	TARGET hammer_dll
	MODULE
	PROPERTY_FOLDER "Hammer//Shared Libs"
	#INSTALL_DEST "${GAMEDIR}/bin"
	INSTALL_DEST "${GAMEDIR}"
	INSTALL_OUTNAME "level_editor_dll"
	SOURCES ${HAMMER_DLL_SOURCE_FILES}
)

target_precompile_headers(
	hammer_dll
	PRIVATE "stdafx.h"
)

target_include_directories(
	hammer_dll PRIVATE

	"${SRCDIR}/common/shaderdll"
	"${SRCDIR}/common/iostream"
	"${DX9SDKDIR}/Include"
	"${SRCDIR}/engine"
	"${SRCDIR}/game/shared"
	"${SRCDIR}/utils/common"
	"${SRCDIR}/hammer"
	"${SRCDIR}/public/wintab/include"

	"fmod"
)

target_compile_definitions(
	hammer_dll PRIVATE

	VALVE
	PROTECTED_THINGS_DISABLE
	VERSION_SAFE_STEAM_API_INTERFACES
	NO_WARN_MBCS_MFC_DEPRECATION

	# CMAKETODO: this should be as in file start
	NO_MEMOVERRIDE_NEW_DELETE

	ISOLATION_AWARE_ENABLED
)

target_link_directories(
	hammer_dll PRIVATE

	"${SRCDIR}/public/wintab/lib/i386"
)

target_link_libraries(
	hammer_dll PRIVATE

	$<${IS_WINDOWS}:winmm>
	$<${IS_WINDOWS}:rpcrt4>
	$<${IS_WINDOWS}:comctl32>
	$<${IS_WINDOWS}:wintab32>

	bitmap
	choreoobjects
	dmxloader
	fgdlib
	mathlib
	matsys_controls
	particles
	raytrace
	tier2
	tier3
	vgui_controls
)
