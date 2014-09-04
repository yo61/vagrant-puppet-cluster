# build a puppetdb server
class role_puppetdb_server {

  include ::profile_common
  include ::profile_postgresql_client
  include ::profile_puppetdb

}