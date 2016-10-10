
node default {

  file { 'download puppet repository package':
    path => '/tmp/puppetlabs-release-pc1-xenial.deb',
    ensure => present,
    source => 'https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb -P /tmp/'
  }

  package { 'install puppet repository package':
    name => 'puppetlabs-release-pc1',
    ensure => present,
    provider => 'dpkg',
    source => '/tmp/puppetlabs-release-pc1-xenial.deb',
  }

  package { 'install puppet server':
    name => 'puppetserver',
    ensure => present,
    require => Exec['apt-get update']
  }

  package { 'install librarian-puppet':
    name => 'librarian-puppet',
    ensure => present
  }

  service { 'enable and start puppet server':
    name => 'puppetserver',
    enable => true,
    ensure => running
  }

  file { 'copy puppet code dir to puppet server':
    path => '/etc/puppetlabs/puppet/code',
    source => '/vagrant/puppet/code',
    ensure => directory
  }

  file { 'copy autosign.conf to puppet conf dir':
    path => '/etc/puppetlabs/puppet/autosign.conf',
    source => '/vagrant/puppet/autosign.conf',
    ensure => present
  }

  file { 'copy auth.conf to puppet conf dir':
    path => '/etc/puppetlabs/puppet/puppetserver/conf.d/auth.conf',
    source => '/vagrant/puppet/auth.conf',
    ensure => present,
    notify => Service['enable and start puppet server']
  }

  file { 'create link to puppet executable':
    path => '/usr/bin/puppet',
    target => '/opt/puppetlabs/bin/puppet',
    ensure => link
  }

  exec { 'install required puppet modules':
    command => 'librarian-puppet install --verbose',
    cwd => '/etc/puppetlabs/code',
    creates => '/etc/uppetlabs/code/modules/vcsrepo'
  }

}
