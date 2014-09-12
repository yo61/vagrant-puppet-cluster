# Install a puppet master server
class role_puppet_master{

  class{'::profile_common':}->
  class{'::profile_puppet_master':}

  contain 'profile_common'
  contain 'profile_puppet_master'

}