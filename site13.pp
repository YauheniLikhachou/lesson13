#Manifest which should install nginx, create new mysql 
#“prod_mdb” database, new user called “prod_user” and 
#grant “prod_user” access to “prod_mdb”

node clientpuppet.minsk.epam.com {
  package { 'nginx':
    ensure=>'installed'
    }
    notify { 'Nginx is installed.':
    }

  service { 'nginx':
    ensure=>'running'
    }
    notify { 'Nginx is running.':
    }
#Class for mysql
  class { '::mysql::server':
    root_password  => '123456',
    }
    mysql_database { 'prod_mdb':
      ensure  => present,
      charset => 'utf8',
    }
    mysql_user { 'prod_user@localhost':
      ensure => present,
    }
    mysql_grant { 'prod_user@localhost/prod_mdb.*':
      ensure  => present,
      options  => ['GRANT'],
      privileges  => ['ALL'],
      table  => 'prod_mdb.*',
      user  => 'prod_user@localhost',
  }
}
