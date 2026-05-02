# Replace broken snapshot tarball URL (gitweb.gentoo.org returns 502/404 for snapshots)
# with git:// protocol which is still operational
SRC_URI = "git://anongit.gentoo.org/proj/udev-gentoo-scripts.git;branch=master;protocol=git"
SRCREV = "0262986f5d18b53f1b1bb2de8183678e7df0a68c"

# git fetcher unpacks to ${WORKDIR}/git by default
S = "${WORKDIR}/git"

do_configure[noexec] = "1"

do_install() {
    oe_runmake DESTDIR=${D} install
}

RDEPENDS:${PN} = "openrc"
