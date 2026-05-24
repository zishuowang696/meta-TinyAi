SUMMARY = "TinyAI core console image with llama-cpp, SSH & ADB"

LICENSE = "MIT"

IMAGE_FEATURES += "splash package-management"

inherit core-image
inherit qemu-launch

IMAGE_INSTALL:append = "\
    llama-cpp \
    dropbear \
    android-tools-adbd \
"
