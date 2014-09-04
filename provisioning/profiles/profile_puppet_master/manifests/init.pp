class profile_puppet_master{

  $puppetdb_ip = hiera('puppetdb_ip')
  $puppetdb_port = hiera('puppetdb_port')

  class{'puppet::master':
    environments          => 'directory',
    storeconfigs          => true,
    storeconfigs_dbserver => $puppetdb_ip,
    storeconfigs_dbport   => $puppetdb_port,
  }


}