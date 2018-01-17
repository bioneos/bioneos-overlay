# bioneos-overlay

The custom Bio::Neos overlay to store any modifications to ebuilds that we need
for the office, or any custom ebuilds that we create.

## Usage

More recent versions of Portage allows you to add additional repositories by
adding a config file in `/etc/portage/repos.conf`. Here's an example:

```/etc/portage/repos.conf/bioneos.conf
[bioneos-overlay]
location = /var/db/repos/bioneos
sync-type = git
sync-uri = git://github.com/bioneos/bioneos-overlay.git
auto-sync = yes
```

After creating this file run `emerge --sync bioneos-overlay`
