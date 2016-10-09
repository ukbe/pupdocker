if $hostrole == 'php-fpm' {

  user { 'create www-data user':
    name => 'www-data',
    groups => 'www-data',
    ensure => present
  }

  file { '/site':
    ensure  => directory,
    owner => 'www-data',
    group => 'www-data'
  }

  file { '/site/index.php':
    ensure => present,
    content => '<?php echo "PHP-FPM is running in container." ?>',
    owner => 'www-data',
    group => 'www-data'
  }
/*
  include git

  vcsrepo { '/site':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/ukbe/',
    branch   => 'master',
    owner    => 'www-data',
    group    => 'www-data',
    require  => Class['git']
  }
*/

  archive { 'extract source archive':
    path          => "/tmp/empquery.tar.gz",
    extract       => true,
    extract_path  => '/site',
    creates       => "/site/public",
    cleanup       => true,
    user          => 'www-data',
    group         => 'www-data',
    require       => File['/site'],
  }

  file { '/site/.env':
    ensure => present,
    source => '/root/.env',
    owner => 'www-data',
    group => 'www-data'
  }

  class { 'phpfpm':
    daemonize => 'no',
    poold_purge => true
  }

  package { 'php-cli':
    ensure => installed
  }

  # Pool with dynamic process manager, TCP socket
  phpfpm::pool { 'main':
    listen                 => '0.0.0.0:9000',
    pm                     => 'dynamic',
    pm_max_children        => 10,
    pm_start_servers       => 4,
    pm_min_spare_servers   => 2,
    pm_max_spare_servers   => 6,
    pm_max_requests        => 500
  }

  package { 'php-mbstring':
    ensure => installed,
  }

  package { 'php-dom':
    ensure => installed,
  }

  package { 'php-pdo-mysql':
    ensure => installed,
  }

  exec { 'download and install composer':
    command => '/usr/bin/curl -sS https://getcomposer.org/installer | /usr/bin/php',
    cwd  => '/site/',
    environment => 'HOME=/root',
    creates => '/site/composer.phar',
    require => Package['php-cli']
  }

  exec { 'run composer install':
    command  => '/usr/bin/php composer.phar install',
    cwd  => '/site/',
    environment => 'HOME=/root',
    creates => '/site/vendor/autoload.php',
    require => Exec['download and install composer']
  }


}
