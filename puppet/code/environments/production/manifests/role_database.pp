if $hostrole == 'database' {

  class { '::mysql::server':
    root_password           => 'password',
    remove_default_accounts => true,
    service_provider        => 'debian', # ubuntu base image does not include upstart or systemd
    override_options        => {
      'mysqld' => {
        'bind-address'       => '0.0.0.0',
        'port'               => '3306',
        'datadir'            => '/var/lib/mysql',
        'basedir'            => '/usr',
        'max_allowed_packet' => '16M',
        'max_connections'    => '151',
        'query_cache_limit'  => '1M',
        'query_cache_size'   => '16M',
        'user'               => 'mysql',
        'pid-file'           => '/var/run/mysqld/mysqld.pid'
      }
    }
  }

  include git

  file { '/datacharmer':
    ensure  => directory,
    require => Class['git']
  }

  vcsrepo { '/datacharmer':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/datacharmer/test_db.git',
    branch   => 'master',
    require  => Class['git']
  }

  /*
  # Temporary fix to GitHub access problem
  exec { 'untar source file':
    command => "tar xzf /root/test_db-master.tar.gz --transform 's/test_db-master\///g' -C /datacharmer",
    path    => '/bin'
  }
*/
  exec { 'insert path into resource lines':
    command   => "sed -ir 's/source \(.*\) ;/source \/datacharmer\/\1 ;/g' /datacharmer/employees.sql",
    path      => '/bin',
#    require   => Vcsrepo['/datacharmer']
    require   => Vcsrepo['/datacharmer']
  }

  mysql::db { 'employees':
    user           => 'appuser',
    password       => 'apppass',
    host           => '%',
    grant          => 'ALL',
    sql            => '/datacharmer/employees.sql',
    import_timeout => 600,
#    require        => Vcsrepo['/datacharmer']
    require        => Exec['insert path into resource lines']
  }

}