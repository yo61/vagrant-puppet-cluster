# postgres server
node 'node01.ubnt.int.yo61.net' {

  $postgresql_ip = hiera('postgresql_ip')
  $postgresql_version = hiera('postgresql_version')
  $puppetdb_ip = hiera('puppetdb_ip')
  $puppetdb_name = hiera('puppetdb_name')
  $puppetdb_user = hiera('puppetdb_user')
  $puppetdb_pass = hiera('puppetdb_pass')

  # kill the firewall
  service{'firewalld':
    ensure => 'stopped',
    enable => false,
  }

  class { '::postgresql::globals':
    manage_package_repo => true,
    version             => $postgresql_version,
    encoding            => 'UTF8',
  }->
  class{'::postgresql::server':
    ip_mask_allow_all_users => "${puppetdb_ip}/32",
    listen_addresses        => $postgresql_ip,
    ipv4acls                => ["host all puppetdb ${puppetdb_ip}/32 md5"],
  }->
  postgresql::server::db { $puppetdb_name:
    user     => $puppetdb_user,
    password => postgresql_password($puppetdb_user, $puppetdb_pass),
  }

}

node 'node02.ubnt.int.yo61.net' {

  class { '::postgresql::globals':
    manage_package_repo => true,
    version             => $postgresql_version,
    encoding            => 'UTF8',
  }->
  class{'::postgresql::client':}

}

node 'node03.ubnt.int.yo61.net' {

}
