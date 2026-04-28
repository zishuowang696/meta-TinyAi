SUMMARY = "TinyAI core console image with llama-cpp, SSH & ADB"

LICENSE = "MIT"

IMAGE_FEATURES += "splash"

inherit core-image

IMAGE_INSTALL:append = "\
    llama-cpp \
    tinyai-model-qwen \
    dropbear \
    android-tools-adbd \
"
