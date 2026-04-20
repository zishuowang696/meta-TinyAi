# meta-embedlab: Disable Bluetooth in device tree for Raspberry Pi 3B
# This frees up the mini UART (ttyS0) for other uses

do_configure:prepend() {
    # Append bluetooth disable snippet to the device tree files
    BT_DISABLE='
/* Disable Bluetooth - meta-embedlab */
&bt {
	status = "disabled";
};
&uart0 {
	status = "disabled";
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
                echo "$BT_DISABLE" >> "$dts"
                bbnote "Added Bluetooth disable to $dts"
            fi
        fi
    done
}