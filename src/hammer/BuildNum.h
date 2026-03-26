//========= Copyright Valve Corporation, All rights reserved. ============//
//
// Purpose: 
//
// $NoKeywords: $
//=============================================================================//

#ifndef BUILDNUM_H
#define BUILDNUM_H
#pragma once

int build_number( void );

#if defined( SLE )
const char *GetRevisionInfo();
#endif // SLE

#endif // BUILDNUM_H
