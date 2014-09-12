# build a puppetdb server
class role_puppetdb_server {

  class{'::profile_common':}->
  class{'::profile_postgresql_client':}->
  class{'::profile_puppetdb':}

  contain 'profile_common'
  contain 'profile_postgresql_client'
  contain 'profile_puppetdb'

}