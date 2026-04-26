SUMMARY = "TinyAI demo — one-click LLM inference on RPi 3B"
DESCRIPTION = "Demo script with interactive chat, HTTP server, model download, \
and benchmark modes for llama.cpp on Raspberry Pi 3B."
SECTION = "devel/ai"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
PR = "r0"

SRC_URI = "file://tinyai-demo.sh"

RDEPENDS:${PN} += "llama-cpp wget bash"

do_install() {
    install -d ${D}${bindir}
    install -d ${D}/data/models
    install -m 0755 ${UNPACKDIR}/tinyai-demo.sh ${D}${bindir}/tinyai-demo
}

FILES:${PN} += "/data/models"
