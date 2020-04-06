EAPI=6

DESCRIPTION="Alpha pre-release 3 for the Alcove Backup system"

# Publicly hosted on GitHub
HOMEPAGE="https://github.com/bioneos/alcove"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz"
LICENSE="ISC"

SLOT="0"
# I am quite certain this system will be stable on most any platforms
# that have a stable NodeJS install, but as I have no capacity to test
# this, we will limit the list to those systems I have installed on.
KEYWORDS="~amd64 ~x86"

# Nothing yet. Might be worthwhile to create a build without the web
# server in the future.
IUSE=""

# In addition to node we really need the 'forever' npm package as well, but
# cannot easily test for this as a dependency (AFAIK).
DEPEND=">=net-libs/nodejs-10.0.0[npm]"
RDEPEND="${DEPEND}"

##
# Use the npm script to build the dist version (with test code stripped)
src_prepare() {
	npm run build
	cd dist
	npm install

	# Instruct emerge that we modified the source
	eapply_user
}

##
# Main package into /usr/share/alcove
src_install() {
	insinto /usr/share/${PN}
	doins -r dist/* || die "doins failed"
	# Needs change to PN
	insinto /etc/${PN}
	doins config/${PN}.ini.example
	insinto /etc/${PN}/machines
	doins config/machines/machine.ini.example
	# OpenRC init script
	doinitd resources/openrc/${PN}
}
