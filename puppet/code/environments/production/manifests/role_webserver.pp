if $hostrole == 'webserver' {

  class{"::nginx":
    manage_repo => true,
    package_source => 'nginx-mainline',
    service_ensure => 'stopped'
  }

  file_line { 'disable daemon':
    path => '/etc/nginx/nginx.conf',
    line => 'daemon off;',
    require => Class[::nginx]
  }

  file { '/site':
    ensure  => directory
  }

  file { '/site/index.html':
    ensure => present,
    content => 'hello world.'
  }

  nginx::resource::vhost { 'pupdocker.lab':
    ensure      => present,
    www_root    => '/site/public',
    index_files => ['index', 'index.php', 'index.html', 'index.htm'],
    try_files   => ['$uri', '$uri/', '/index.php?$query_string']
  }

  nginx::resource::location { 'pupdocker.lab':
    ensure          => present,
    vhost           => 'pupdocker.lab',
    www_root        => "/site/public/",
    location        => '~ \.php$',
    index_files     => ['index.php', 'index.html', 'index.htm'],
    try_files   => ['$uri', '/index.php', '=404'],
    proxy           => undef,
    fastcgi         => "con_php:9000",
    fastcgi_script  => undef,
    fastcgi_param  => {
      'SCRIPT_FILENAME'  => '$document_root$fastcgi_script_name'
    },
    include         => ['fastcgi_params'],
    location_cfg_append => {
      fastcgi_split_path_info => '^(.+\.php)(/.+)$',
      fastcgi_index => 'index.php',
      fastcgi_read_timeout    => '3m',
      fastcgi_send_timeout    => '3m'
    }
  }

}
