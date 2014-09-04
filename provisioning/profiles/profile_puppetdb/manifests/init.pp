# setup puppetdb server that talks to the postgresql server
class profile_puppetdb {

  $postgresql_ip = hiera('postgresql_ip')

  class {'puppetdb::server':
    database_host => $postgresql_ip
  }

}