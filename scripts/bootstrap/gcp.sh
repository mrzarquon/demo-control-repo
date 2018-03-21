#!/bin/bash

mkdir -p {'/opt/peinstall','/etc/puppetlabs/enterprise/conf.d/'}

curl -L -o /opt/peinstall/pe-installer.tar.gz "https://pm.puppetlabs.com/cgi-bin/download.cgi?ver=latest&dist=el&arch=x86_64&rel=7"

curl -o /etc/puppetlabs/enterprise/conf.d/pe.conf https://raw.githubusercontent.com/mrzarquon/demo-control-repo/production/scripts/bootstrap/pe.conf

tar --extract --file=/opt/peinstall/pe-installer.tar.gz --strip-components=1 --directory=/opt/peinstall/installer

/opt/peinstall/installer/puppet-enterprise-installer -y

/opt/puppetlabs/bin/puppet agent -t
sleep 10
/opt/puppetlabs/bin/puppet agent -t
sleep 10
/opt/puppetlabs/bin/puppet agent -t
sleep 10
/opt/puppetlabs/bin/puppet agent -t
