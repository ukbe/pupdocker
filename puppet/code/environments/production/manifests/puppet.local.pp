node puppet.local {

  class { 'docker':
    version => 'latest'
  }

  class { 'docker::compose':
    ensure  => present,
    version => '1.8.1'
  }

  docker::image { 'ubuntu':
    image_tag => '16.04'
  }

docker::image { 'imgpuppet':
  docker_dir => '/vagrant/docker/puppet-image/',
  subscribe => Docker::Image['ubuntu']
}

docker::image { 'imgdb':
  docker_dir => '/vagrant/docker/database-image/',
  subscribe => Docker::Image['imgpuppet']
}

docker::image { 'imgweb':
    docker_file => '/vagrant/docker/webserver-image/',
    subscribe => Docker::Image['imgpuppet']
  }

}