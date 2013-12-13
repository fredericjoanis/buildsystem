/**
 * \file   os_setenv.c
 * \brief  Create a subdirectory.
 * \author Copyright (c) 2002-2008 Jason Perkins and the Premake project
 */

#include "premake.h"
#include <stdlib.h>

int os_setenv(lua_State* L)
{
#if PLATFORM_WINDOWS
	char buff[1024];
	sprintf(buff, "%s=%s", luaL_checkstring(L, 1), luaL_checkstring(L, 2));
	lua_pushnumber(L, _putenv(buff));  /* if NULL push nil */
#else
	lua_pushnumber(L, setenv(luaL_checkstring(L, 1), luaL_checkstring(L, 2), 1));  /* if NULL push nil */
#endif
	return 1;
}
