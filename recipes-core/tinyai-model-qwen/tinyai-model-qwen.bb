SUMMARY = "Qwen2.5-0.5B GGUF model for TinyAI"
DESCRIPTION = "Pre-quantized Qwen2.5-0.5B-Instruct model in GGUF format (Q4_K_M), \
pre-installed by the TinyAI distro for zero-config LLM inference."
HOMEPAGE = "https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF"
SECTION = "devel/ai"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

# Q4_K_M — balanced size/quality for Qwen2.5-0.5B (~491 MB)
SRC_URI = "https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf"

SRC_URI[sha256sum] = "74a4da8c9fdbcd15bd1f6d01d621410d31c6fc00986f5eb687824e7b93d7a9db"

do_install() {
    install -d ${D}/data/models
    install -m 0644 ${UNPACKDIR}/qwen2.5-0.5b-instruct-q4_k_m.gguf ${D}/data/models/
}

FILES:${PN} += "/data/models/qwen2.5-0.5b-instruct-q4_k_m.gguf"
