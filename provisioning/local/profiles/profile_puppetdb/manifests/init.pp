# setup puppetdb server that talks to the postgresql server
class profile_puppetdb {

  $database_host      = hiera('postgresql.listen_addresses')
  $listen_address     = hiera('puppetdb.listen_address')
  $listen_port        = hiera('puppetdb.listen_port')
  $ssl_listen_address = hiera('puppetdb.ssl_listen_address')
  $ssl_listen_port    = hiera('puppetdb.ssl_listen_port')
  $ssl_key            = hiera('puppetdb.ssl_key')
  $ssl_cert           = hiera('puppetdb.ssl_cert')
  $ssl_ca_cert        = hiera('puppet.master.ssl.certs/ca.pem')
  $database_name      = hiera('puppetdb.database_name')
  $database_username  = hiera('puppetdb.database_username')
  $database_password  = hiera('puppetdb.database_password')

  class {'puppetdb::server':
    listen_address     => $listen_address,
    listen_port        => $listen_port,
    ssl_listen_address => $ssl_listen_address,
    ssl_listen_port    => $ssl_listen_port,
    ssl_set_cert_paths => true,
    ssl_deploy_certs   => true,
    ssl_key            => $ssl_key,
    ssl_cert           => $ssl_cert,
    ssl_ca_cert        => $ssl_ca_cert,
    database_host      => $database_host,
    database_name      => $database_name,
    database_username  => $database_username,
    database_password  => $database_password,
  }

}