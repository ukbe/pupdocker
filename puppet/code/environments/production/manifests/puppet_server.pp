node 'puppet.local' {

  class { 'docker':
    version => 'latest'
  }

  package { 'docker-compose':
    ensure    => present,
    provider  => 'pip'
  }

  user { 'add ubuntu user to docker group':
    ensure => present,
    groups => ['docker']
  }

  docker::image { 'ubuntu':
    image_tag => '16.04'
  }

  docker::image { 'puppet':
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

  exec { 'run docker-compose':
    command => 'docker-compose up -p pupdocker',
    cwd => '/vagrant/docker'
  }

}