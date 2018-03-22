class profile::base {

  #the base profile should include component modules that will be on all nodes
  include ntp

  package { 'aws-sdk':
    ensure => present,
    provider => puppet_gem,
  }

  file { '/etc/motd':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => 'Hello from Puppet\n',
  }


}
