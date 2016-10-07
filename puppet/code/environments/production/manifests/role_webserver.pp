if $hostrole == 'webserver' {

  class{"::nginx":
    manage_repo => true,
    package_source => 'nginx-mainline',
    service_ensure => 'stopped'

  }

  file { '/site':
    ensure  => directory
  }

  file { '/site/index.html':
    ensure => present,
    content => 'hello world.'
  }

  ::nginx::resource::vhost { 'pupdocker.lab':
    ensure      => present,
    www_root => '/site/',
  }

  file_line { 'disable daemon':
    path => '/etc/nginx/nginx.conf',
    line => 'daemon off;',
    require => Class[::nginx]
  }
/*
  ::nginx::resource::location { 'php web root':
    ensure          => present,
    ssl             => false,
    ssl_only        => false,
    vhost           => 'pupdocker.lab',
    www_root        => '/site/',
    location        => '~ \.php$',
    index_files     => ['index.php', 'index.html', 'index.htm'],
    proxy           => undef,
    fastcgi         => 'php-fpm:9000',
    fastcgi_script  => undef,
    location_cfg_append => {
      fastcgi_connect_timeout => '3m',
      fastcgi_read_timeout    => '3m',
      fastcgi_send_timeout    => '3m'
    }
  }
*/
}
