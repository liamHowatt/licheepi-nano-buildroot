git clone https://github.com/illiliti/libudev-zero.git
cp libudev-zero/udev.h libudev-zero/libudev.h
buildroot/output/host/bin/arm-linux-gcc \
    -DLOCALEDIR=\"\/usr/share/locale\" \
    -D_LARGEFILE_SOURCE \
    -D_LARGEFILE64_SOURCE \
    -D_FILE_OFFSET_BITS=64 \
    -D_LARGEFILE_SOURCE \
    -D_LARGEFILE64_SOURCE \
    -D_FILE_OFFSET_BITS=64 \
    -Os \
    -ggdb \
    -fdata-sections -ffunction-sections \
    -D_FORTIFY_SOURCE=1 \
    -Wall \
    $(find buildroot/output/build/linux-custom/tools/usb/usbip/*src -type f -name '*.c' ! -name 'usbipd.c') \
    -Ibuildroot/output/build/linux-custom/tools/usb/usbip/libsrc/ \
    -Ibuildroot/output/build/linux-custom/tools/usb/usbip/src/ \
    libudev-zero/*.c \
    -Ilibudev-zero/ \
    -DUSBIP_VERSION=0x00000111 \
    -DPACKAGE_STRING='"usbip idk"' \
    -o licheepi-nano/board/licheepi_nano/rootfs-overlay/root/usbip \
    -Wl,--gc-sections
buildroot/output/host/bin/arm-linux-gcc \
    -DLOCALEDIR=\"\/usr/share/locale\" \
    -D_LARGEFILE_SOURCE \
    -D_LARGEFILE64_SOURCE \
    -D_FILE_OFFSET_BITS=64 \
    -D_LARGEFILE_SOURCE \
    -D_LARGEFILE64_SOURCE \
    -D_FILE_OFFSET_BITS=64 \
    -Os \
    -ggdb \
    -fdata-sections -ffunction-sections \
    -D_FORTIFY_SOURCE=1 \
    -Wall \
    $(find buildroot/output/build/linux-custom/tools/usb/usbip/*src -type f -name '*.c' ! -name 'usbip.c') \
    -Ibuildroot/output/build/linux-custom/tools/usb/usbip/libsrc/ \
    -Ibuildroot/output/build/linux-custom/tools/usb/usbip/src/ \
    libudev-zero/*.c \
    -Ilibudev-zero/ \
    -DUSBIP_VERSION=0x00000111 \
    -DPACKAGE_STRING='"usbip idk"' \
    -o licheepi-nano/board/licheepi_nano/rootfs-overlay/root/usbipd \
    -Wl,--gc-sections
