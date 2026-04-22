# meta-embedlab: Disable Bluetooth and configure UART aliases for Raspberry Pi 3B
# This frees up PL011 UART (ttyAMA0) for serial console usage

# 添加内核默认启动参数配置
FILESEXTRAPATHS:prepend := "${THISDIR}:"
SRC_URI:append = " file://cmdline.cfg"

do_configure:prepend() {
    # Append bluetooth disable and uart alias snippet to the device tree files
    UART_CONFIG='
/* Disable Bluetooth to free PL011 UART - meta-embedlab */
&bt {
	status = "disabled";
};

/* Ensure PL011 UART0 is aliased as serial0/ttyAMA0 - meta-embedlab */
/ {
	aliases {
		serial0 = &uart0;
		serial1 = &uart1;
	};
};
'

    for dts in \
        ${S}/arch/arm/boot/dts/broadcom/bcm2710-rpi-3-b.dts \
        ${S}/arch/arm/boot/dts/broadcom/bcm2837-rpi-3-b.dts \
        ${S}/arch/arm64/boot/dts/broadcom/bcm2710-rpi-3-b.dts \
        ${S}/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts; do
        if [ -f "$dts" ]; then
            # Append to file if not already present
            if ! grep -q "Disable Bluetooth - meta-embedlab" "$dts"; then
                echo "$UART_CONFIG" >> "$dts"
                bbnote "Added Bluetooth disable and UART aliases to $dts"
            fi
        fi
    done
}