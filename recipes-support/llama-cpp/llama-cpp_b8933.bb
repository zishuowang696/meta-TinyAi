SUMMARY = "llama.cpp - LLM inference in C/C++"
DESCRIPTION = "A C/C++ implementation of LLaMA-based large language models \
with ARM NEON optimizations for efficient inference on edge devices."
HOMEPAGE = "https://github.com/ggerganov/llama.cpp"
SECTION = "devel/ai"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=223b26b3c1143120c87e2b13111d3e99"

SRC_URI = "git://github.com/ggerganov/llama.cpp;protocol=https;branch=master"

SRCREV = "dcad77cc3b0865153f486327064fb0320a57a476"
PV = "b8933"

inherit cmake pkgconfig

# RPi 3B (Cortex-A53): Release + aarch64 NEON optimizations
# LLAMA_BUILD_EXAMPLES defaults to ON; we build only what we need below
EXTRA_OECMAKE = "\
    -DCMAKE_BUILD_TYPE=Release \
    -DLLAMA_CPU_AARCH64=ON \
    -DLLAMA_BUILD_TESTS=OFF \
    -DLLAMA_OPENSSL=OFF \
    -DBUILD_SHARED_LIBS=OFF \
"

# Build only llama-cli + llama-server — skip all other examples
do_compile() {
    cmake --build ${B} --target llama-cli --target llama-server -- ${EXTRA_OEMAKE}
}

# Install only the targets we built; cmake --install would try to install
# unbuilt example targets (e.g. llama-batched), causing do_install to fail.
do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/bin/llama-cli ${D}${bindir}/
    install -m 0755 ${B}/bin/llama-server ${D}${bindir}/
}

FILES:${PN} += "\
    ${bindir}/llama-cli \
    ${bindir}/llama-server \
"

RDEPENDS:${PN} += "libstdc++"
