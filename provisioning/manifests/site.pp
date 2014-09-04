# silence a deprecation warning
if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

node 'node01.ubnt.int.yo61.net' {
  include ::role_postgresql_server_puppetdb
}

node 'node02.ubnt.int.yo61.net' {
  include ::role_puppetdb_server
}

node 'node03.ubnt.int.yo61.net' {
  include ::role_puppet_master
}
