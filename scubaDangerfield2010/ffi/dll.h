#ifdef WIN32

# if BUILD_FFI_DLL
#  define FFIIMPORT __declspec (dllexport)
# else /* Not BUILDING_DLL */
#  define FFIIMPORT __declspec (dllimport)
# endif /* BUILDING_DLL */

#else
# define FFIIMPORT
#endif /* WIN32 */
