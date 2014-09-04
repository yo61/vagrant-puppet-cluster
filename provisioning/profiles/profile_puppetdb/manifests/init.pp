# setup puppetdb server that talks to the postgresql server
class profile_puppetdb {

  $postgresql_ip = hiera('postgresql_ip')
  $puppetdb_ip = hiera('puppetdb_ip')
  $puppetdb_name = hiera('puppetdb_name')
  $puppetdb_user = hiera('puppetdb_user')
  $puppetdb_pass = hiera('puppetdb_pass')

  class {'puppetdb::server':
    listen_address    => $puppetdb_ip,
    database_host     => $postgresql_ip,
    database_name     => $puppetdb_name,
    database_username => $puppetdb_user,
    database_password => $puppetdb_pass,
  }

}