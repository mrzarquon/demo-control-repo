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


#
agent userdata
#!/bin/bash
PE_SERVER=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/pe_server" -H "Metadata-Flavor: Google")
PP_ROLE=$(curl "http://metadata.google.internal/computeMetadata/v1/instance/attributes/pp_role" -H "Metadata-Flavor: Google")

certname="$(hostname).internal.company.lan"

curl -k https://$PE_SERVER:8140/packages/current/install.bash | sudo bash -s agent:certname=$certname extension_requests:pp_role=$PP_ROLE
