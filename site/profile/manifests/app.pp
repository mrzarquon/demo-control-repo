class profile::app {

  # This is the apache php configuration generic for all systems
  file { '/opt/myapp':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  apache::vhost { 'myapp':
    vhost_name => '*',
    port    => '80',
    docroot => '/opt/myapp',
    aliases => [
      {
        scriptalias => '/status',
        path        => '/opt/myapp/status.php',
      },
    ],
    require => Class['apache']
  }

  file { '/opt/myapp/status.php':
    ensure  => file,
    content => '<?php echo "OK " . time(); ?>',
  }

    file { '/opt/myapp/index.php':
    ensure  => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/profile/app/index.php',
  }

  file { '/opt/myapp/google-cloud-platform-logo.png':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/profile/google-cloud-platform-logo.png',
  }

  file { '/opt/myapp/puppet-logo.png':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/profile/puppet-logo.png',
  }



}
