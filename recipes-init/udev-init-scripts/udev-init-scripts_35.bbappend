# Fix for Yocto 6.0 UNPACKDIR change
# S must be relative to UNPACKDIR instead of WORKDIR
S = "${UNPACKDIR}/udev-gentoo-scripts-${PV}"
