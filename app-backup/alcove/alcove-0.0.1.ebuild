EAPI=6

DESCRIPTION="Alpha release for the Alcove Backup system"

# Will be replaced with a proper homepage once ready for general public
HOMEPAGE="https://github.com/bioneos/backup-system"

# Temporary build, until we can rename the Github project:
SRC_URI="https://files.bioneos.com/pub/alcove-0.0.1.tgz"
#SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz"
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
DEPEND=">=net-libs/nodejs-8.0.0[npm]"
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
	insinto /etc/backup
	doins etc/backup/backup.ini.example
	insinto /etc/backup/machines
	doins etc/backup/machines/machine.ini.example
	# TODO: SysV init script
	#doinitd resources/init.d/alcove
}
