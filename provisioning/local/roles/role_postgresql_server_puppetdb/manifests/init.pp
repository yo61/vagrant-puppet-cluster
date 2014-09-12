# Install a postgresql server with a database for puppetdb
class role_postgresql_server_puppetdb{

  class{'::profile_common':}->
  class{'::profile_postgresql_server_puppetdb':}

  contain 'profile_common'
  contain 'profile_postgresql_server_puppetdb'

}