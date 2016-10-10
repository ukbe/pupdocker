node 'puppet.local' {

  class { 'docker':
    docker_users => ['ubuntu'],
    version => 'latest'
  }

  class { 'docker::compose':
    ensure => present,
    version => '1.8.1'
  }

  /*
  package { 'python-pip':
    ensure => present
  }

  package { 'docker-compose':
    ensure    => present,
    provider  => 'pip',
    require => Package['python-pip']
  }

  user { 'add ubuntu user to docker group':
    ensure => present,
    groups => ['docker'],
    require => Class['docker']
  }
*/

  docker::image { 'ubuntu':
    ensure  => present,
    image_tag => '16.04',
    require => Class['docker']
  }

  docker::image { 'puppet':
    ensure => present,
    docker_dir => '/vagrant/docker/puppet-image/',
    subscribe => Docker::Image['ubuntu']
  }

/*
  docker::image { 'imgdb':
    docker_dir => '/vagrant/docker/database-image/',
    subscribe => Docker::Image['imgpuppet']
  }

  docker::image { 'imgweb':
    docker_dir => '/vagrant/docker/webserver-image/',
    subscribe => Docker::Image['imgpuppet']
  }

  docker::image { 'imgphp':
    docker_dir => '/vagrant/docker/php-image/',
    subscribe => Docker::Image['imgpuppet']
  }

  docker_compose { '/vagrant/docker/docker-compose.yml':
    ensure  => present,
  }

*/

  docker_compose { '/vagrant/docker/docker-compose.yml':
    ensure => present,
#    up_args => 'HOST_IP=192.168.10.10',
    require => [Docker::Image['puppet'], Class['docker::compose']]
  }

  /*
  exec { 'run docker-compose':
    command => 'docker-compose up -p pupdocker',
    cwd => '/vagrant/docker',
    path => '/usr/bin',
    require => Docker::Image['puppet']
  }
*/
}