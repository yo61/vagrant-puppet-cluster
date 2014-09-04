#	new file:   .librarian/puppet/config postgres server
node 'node01.ubnt.int.yo61.net' {

  include ::role_postgresql_server_puppetdb

  # kill the firewall
  service{'firewalld':
    ensure => 'stopped',
    enable => false,
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
