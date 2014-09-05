# set up a postgres server for use by puppetdb
class profile_postgresql_server_puppetdb {

  $postgresql_ip = hiera('postgresql_ip')
  $puppetdb_name = hiera('puppetdb_name')
  $puppetdb_user = hiera('puppetdb_user')
  $puppetdb_pass = hiera('puppetdb_pass')

  class { 'puppetdb::database::postgresql':
    listen_addresses  => $postgresql_ip,
    database_name     => $puppetdb_name,
    database_username => $puppetdb_user,
    database_password => $puppetdb_pass,
  }

}