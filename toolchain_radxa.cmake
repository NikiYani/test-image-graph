set(CMAKE_NO_SYSTEM_FROM_IMPORTED 1)

set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  arm)

set(CMAKE_SYSROOT           /opt/poky/3.1.19/sysroots/aarch64-poky-linux)
set(CMAKE_TOOLCHAIN_INCLUDE /opt/poky/3.1.19/sysroots/aarch64-poky-linux/usr/include/)

set(CMAKE_PREFIX_PATH       /opt/poky/3.1.19/sysroots/x86_64-pokysdk-linux/usr/bin)
set(CMAKE_C_COMPILER        /opt/poky/3.1.19/sysroots/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-gcc)
set(CMAKE_CXX_COMPILER      /opt/poky/3.1.19/sysroots/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-g++)
set(CMAKE_OBJDUMP           /opt/poky/3.1.19/sysroots/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-objdump)

set(CMAKE_C_FLAGS           "${CMAKE_C_FLAGS} -mcpu=cortex-a53 -fstack-protector-strong -fdata-sections -ffunction-sections -Wl,--gc-sections")
set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} ${CMAKE_C_FLAGS}")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(OE_QMAKE_PATH_EXTERNAL_HOST_BINS /opt/poky/3.1.19/sysroots/x86_64-pokysdk-linux/usr/bin/)