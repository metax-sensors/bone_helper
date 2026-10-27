set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR ARM)

set(SDK_ROOT "/opt/boneos/6.1")
set(SDK_NATIVE_SYSROOT "${SDK_ROOT}/sysroots/x86_64-pokysdk-linux")

set(TOOLCHAIN_PREFIX "${SDK_NATIVE_SYSROOT}/usr/bin/arm-poky-linux-gnueabi/arm-poky-linux-gnueabi-")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++)

set(CMAKE_LINKER ${TOOLCHAIN_PREFIX}ld)

set(CMAKE_AR ${TOOLCHAIN_PREFIX}gcc-ar)
set(CMAKE_C_COMPILER_AR ${CMAKE_AR})
set(CMAKE_CXX_COMPILER_AR ${CMAKE_AR})
set(CMAKE_ASM_COMPILER_AR ${CMAKE_AR})

set(CMAKE_RANLIB ${TOOLCHAIN_PREFIX}gcc-ranlib)
set(CMAKE_C_COMPILER_RANLIB ${CMAKE_RANLIB})
set(CMAKE_CXX_COMPILER_RANLIB ${CMAKE_RANLIB})
set(CMAKE_ASM_COMPILER_RANLIB ${CMAKE_RANLIB})

set(CMAKE_NM ${TOOLCHAIN_PREFIX}gcc-nm)

set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy)
set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size)

set(CMAKE_STRIP ${TOOLCHAIN_PREFIX}strip)

set(CMAKE_SYSROOT "${SDK_ROOT}/sysroots/cortexa9t2hf-neon-poky-linux-gnueabi")

set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(ENV{SDKTARGETSYSROOT} ${CMAKE_SYSROOT})
set(ENV{PKG_CONFIG_SYSROOT_DIR} ${CMAKE_SYSROOT})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig")
set(ENV{PKG_CONFIG_LIBDIR} "${CMAKE_SYSROOT}/usr/lib/pkgconfig:${CMAKE_SYSROOT}/usr/share/pkgconfig")

# the sysroot is built with 64 bit time_t/off_t, mismatching flags break the ABI of e.g. boost and openssl
add_compile_options("-mthumb;-mcpu=cortex-a9;-mfloat-abi=hard;-mfpu=neon;-pthread")
add_compile_definitions(_TIME_BITS=64 _FILE_OFFSET_BITS=64)
add_link_options("-mthumb;-mcpu=cortex-a9;-mfloat-abi=hard;-mfpu=neon;-pthread")
# only depend on libraries that are actually used (e.g. libatomic is not installed on the target)
add_link_options("-Wl,--as-needed")

# the 6.1 sdk only ships a shared OpenSSL 4 in /usr, there is no static build in /opt/openssl-3 anymore
set(SSL_DIR ${CMAKE_SYSROOT}/usr)
set(OPENSSL_ROOT_DIR ${SSL_DIR})

# boost is also only available as shared library
set(Boost_USE_STATIC_LIBS OFF)
