class role_puppet_master{

  class{'::profile_common':}->
  class{'::profile_puppet_master':}

}