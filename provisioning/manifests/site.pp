node 'node01.ubnt.int.yo61.net' {

  include ::role_postgresql_server_puppetdb

  # kill the firewall
  service{'firewalld':
    ensure => 'stopped',
    enable => false,
  }

}

node 'node02.ubnt.int.yo61.net' {

  include ::role_puppetdb_server

}

node 'node03.ubnt.int.yo61.net' {

}
