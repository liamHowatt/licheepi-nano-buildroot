import subprocess

def system(cmd, check=True):
    subprocess.run(cmd, shell=True, check=check)

if input("delete rootfs 'usbip*' files? [y/n] ").lower() != "y":
    exit()
system("rm licheepi-nano/board/licheepi_nano/rootfs-overlay/root/usbip*", check=False)

system("git clone https://github.com/liamHowatt/libudev-zero.git", check=False)

builds = (
    ("crashes", "ee32ac5f6494047b9ece26e7a5920650cdf46655"),
    ("bandaid_fix", "185a0879a83736314c541bfd98a1f1f4b6c0d09a"),
    ("refactor_fix", "c803d022ef6e619546079afe20f468f82e3b27c7"),
)
exes = ("usbip", "usbipd")
symlink_hash = "c803d022ef6e619546079afe20f468f82e3b27c7"

for name, hash_ in builds:
    system(f"git -C libudev-zero checkout {hash_}")
    system("cp libudev-zero/udev.h libudev-zero/libudev.h")
    target_exe, filter_exe = exes
    for _ in range(2):
        bin_name = f"{target_exe}_{name}_{hash_}"
        system(
            "buildroot/output/host/bin/arm-linux-gcc "
            '-DLOCALEDIR=\\"\\/usr/share/locale\\" '
            "-D_LARGEFILE_SOURCE "
            "-D_LARGEFILE64_SOURCE "
            "-D_FILE_OFFSET_BITS=64 "
            "-D_LARGEFILE_SOURCE "
            "-D_LARGEFILE64_SOURCE "
            "-D_FILE_OFFSET_BITS=64 "
            "-Os "
            "-ggdb "
            "-fdata-sections -ffunction-sections "
            "-D_FORTIFY_SOURCE=1 "
            "-Wall "
            # "-std=c99 -fPIC -pthread -D_XOPEN_SOURCE=700 -Wall -Wextra -Wpedantic -Wmissing-prototypes -Wstrict-prototypes -Wno-unused-parameter "
            f"$(find buildroot/output/build/linux-custom/tools/usb/usbip/*src -type f -name '*.c' ! -name '{filter_exe}.c') "
            "-Ibuildroot/output/build/linux-custom/tools/usb/usbip/libsrc/ "
            "-Ibuildroot/output/build/linux-custom/tools/usb/usbip/src/ "
            "libudev-zero/*.c "
            "-Ilibudev-zero/ "
            "-DUSBIP_VERSION=0x00000111 "
            "-DPACKAGE_STRING='\"usbip for MCP\"' "
            f"-o licheepi-nano/board/licheepi_nano/rootfs-overlay/root/{bin_name} "
            "-Wl,--gc-sections "
        )
        if hash_ == symlink_hash:
            system(f"cd licheepi-nano/board/licheepi_nano/rootfs-overlay/root/ && ln -s {bin_name} {target_exe}")
        filter_exe, target_exe = target_exe, filter_exe
