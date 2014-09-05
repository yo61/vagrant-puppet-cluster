# set up a postgres server for use by puppetdb
class profile_postgresql_server_puppetdb {

  $listen_addresses  = hiera('postgresql.listen_addresses')
  $database_name     = hiera('puppetdb.database_name')
  $database_username = hiera('puppetdb.database_username')
  $database_password = hiera('puppetdb.database_password')

  class { 'puppetdb::database::postgresql':
    listen_addresses  => $listen_addresses,
    database_name     => $database_name,
    database_username => $database_username,
    database_password => $database_password,
  }

}