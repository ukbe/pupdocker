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

  class { 'phpfpm':
    daemonize => 'no',
    poold_purge => true
  }

  # Pool with dynamic process manager, TCP socket
  phpfpm::pool { 'main':
    listen                 => '0.0.0.0:9000',
    pm                     => 'dynamic',
    pm_max_children        => 10,
    pm_start_servers       => 4,
    pm_min_spare_servers   => 2,
    pm_max_spare_servers   => 6,
    pm_max_requests        => 500,

  }

}
