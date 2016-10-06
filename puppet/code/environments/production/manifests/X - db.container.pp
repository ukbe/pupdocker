node db.container {

  class { '::mysql::server':
    root_password           => 'password',
    remove_default_accounts => true
  }

  mysql::db { 'appdb':
    user           => 'appuser',
    password       => 'apppass',
    host           => 'localhost',
    grant          => ['SELECT', 'UPDATE'],
  #  mysql::db::sql => '/path/to/sqlfile'
  }

}