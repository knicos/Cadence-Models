AC_INIT(cadence_module_config, version-0.1)

# make it easier to get going in DCS
# unfortunately I can't find the headers in empublic
# CPPFLAGS="${CPPFLAGS} -I/dcs/emp/empublic/include"
LDFLAGS="${LDFLAGS} -L/dcs/emp/empublic/lib"

#
# check for C++
#
AC_MSG_NOTICE([Testing for C++])
AC_PROG_CXX
AC_LANG(C++)
AC_CHECK_HEADER(iostream)

#
# check for cadence libs and headers
#
AC_MSG_NOTICE([Testing for cadence])
AC_CHECK_HEADER(cadence/cadence.h)

if test "$ac_cv_header_cadence_cadence_h" == no
then
    AC_MSG_ERROR([could not find cadence development headers, try either:
    1 setting the CPPFLAGS environment variable to something like "-I /home/youruser/cadence/include"
    2 installing the libcadence headers to somewhere like /usr/local/include])
fi
AC_CHECK_LIB(cadence, cadence_check)

if test "$ac_cv_lib_cadence_cadence_check" == no
then
    AC_MSG_ERROR([could not link against libcadence, try either:
    1 setting the LDFLAGS environment variable to something like "-L /home/youruser/cadence/lib"
    2 installing libcadence to somewhere like /usr/local/lib])
fi

#
# check for math
#
AC_MSG_NOTICE([Testing for math])
AC_CHECK_LIB(m, pow)

#
# check arch, setup various flags
#
CXXFLAGS="$CXXFLAGS -Wall -Wextra -DLINUX -O2"

if test "$target_cpu" == "x86_64"; then
	CXXFLAGS="$CXXFLAGS -DX86_64"
else
	CXXFLAGS="$CXXFLAGS -march=pentium3 -mfpmath=sse"
fi

#
# generate makefiles
#
AC_OUTPUT(Makefile)
echo
echo "Everything configured: you may now build the module using the command 'make'"
