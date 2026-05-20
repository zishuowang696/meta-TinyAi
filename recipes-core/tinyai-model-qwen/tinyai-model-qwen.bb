SUMMARY = "Qwen2.5-0.5B GGUF model for TinyAI"
DESCRIPTION = "Pre-quantized Qwen2.5-0.5B-Instruct model in GGUF format (Q2_K), \
pre-installed by the TinyAI distro for zero-config LLM inference."
HOMEPAGE = "https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF"
SECTION = "devel/ai"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

# Q2_K — maximum compression for Qwen2.5-0.5B (~395 MB), lowest RAM usage
SRC_URI = "https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q2_k.gguf"

SRC_URI[sha256sum] = "9ee36184e616dfc76df4f5dd66f908dbde6979524ae36e6cefb67f532f798cb8"

do_install() {
    install -d ${D}/data/models
    install -m 0644 ${UNPACKDIR}/qwen2.5-0.5b-instruct-q2_k.gguf ${D}/data/models/
}

FILES:${PN} += "/data/models/qwen2.5-0.5b-instruct-q2_k.gguf"
