gauth_credential { 'credentials':
  path     => '/root/cloudkey.json',
  provider => serviceaccount,
  scopes   => [
    'https://www.googleapis.com/auth/ndev.clouddns.readwrite',
  ],
}

gcompute_zone { 'us-west1-b':
  project    => 'google.com:graphite-playground',
  credential => 'credentials',
}

gcompute_disk { 'centos-os-1':
  ensure       => present,
  size_gb      => 50,
  source_image =>
    'projects/centos-cloud/global/images/centos-7-v20180314',
  zone         => 'us-central1-a',
  project      => 'google.com:gcp-migration-198519',
  credential   => 'credentials',
}

gcompute_network { 'default':
  ensure     => present,
  project    => 'google.com:gcp-migration-198519',
  credential => 'credentials',
}

gcompute_region { 'us-west1':
  project    => 'google.com:gcp-migration-198519',
  credential => 'credentials',
}

gcompute_machine_type { 'n1-standard-1':
  zone       => 'us-west1-b',
  project    => 'google.com:gcp-migration-198519',
  credential => 'credentials',
}

gcompute_instance { 'webapp-cloud-leeloo':
  ensure             => present,
  machine_type       => 'n1-standard-1',
  disks              => [
    {
      auto_delete => true,
      boot        => true,
      source      => 'centos-os-1'
    }
  ],
  metadata           => {
    'pe_server' => 'puppet.c.gcp-migration-198519.internal',
    'pp_role'        => 'webapp',
    'startup-script' => '#!/bin/bash\nPE_SERVER=$(curl \"http://metadata.google.internal/computeMetadata/v1/instance/attributes/pe_server\" -H \"Metadata-Flavor: Google\")\nPP_ROLE=$(curl \"http://metadata.google.internal/computeMetadata/v1/instance/attributes/pp_role\" -H \"Metadata-Flavor: Google\")\n\ncurl -k https://$PE_SERVER:8140/packages/current/install.bash | sudo bash -s  extension_requests:pp_role=$PP_ROLE',
  },
  network_interfaces => [
    {
      network        => 'default',
      access_configs => [
        {
          name   => 'External NAT',
          type   => 'ONE_TO_ONE_NAT',
        },
      ],
    }
  ],
  zone               => 'us-west1-b',
  project            => 'google.com:gcp-migration-198519',
  credential         => 'credentials',
}
