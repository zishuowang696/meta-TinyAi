# meta-embedlab: Disable Bluetooth in device tree for Raspberry Pi 3B

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Apply patch to disable Bluetooth in DTS
SRC_URI:append = " \
    file://disable-bluetooth.patch \
"