//========= Copyright Valve Corporation, All rights reserved. ============//
//
// Purpose: 
//
// $NoKeywords: $
//
//=============================================================================//

#ifndef _GAMEPALETTE_H
#define _GAMEPALETTE_H

//
// Snippet from the deprecated 'd3drmdef.h'
//
typedef enum _D3DRMPALETTEFLAGS
{
	D3DRMPALETTE_FREE,                  /* renderer may use this entry freely */
	D3DRMPALETTE_READONLY,              /* fixed but may be used by renderer */
	D3DRMPALETTE_RESERVED               /* may not be used by renderer */
} D3DRMPALETTEFLAGS, *LPD3DRMPALETTEFLAGS;

class CGamePalette
{
public:
	CGamePalette();
	~CGamePalette();

	BOOL Create(LPCTSTR pszFile);

	void SetBrightness(float fValue);
	float GetBrightness();

	operator LOGPALETTE*()
	{ return pPalette; }
	operator CPalette*()
	{ return &GDIPalette; }

private:
	float fBrightness;

	// CPalette:
	CPalette GDIPalette;

	// palette working with:
	LOGPALETTE *pPalette;
	// to convert & store in pPalette:
	LOGPALETTE *pOriginalPalette;

	// file stored in:
	CString strFile;

	// sizeof each palette:
	size_t uPaletteBytes;
};

#endif