# build a puppetboard server
class role_puppetboard {

  class{'::profile_common':}->
  class{'::profile_puppetboard':}

  contain 'profile_common'
  contain 'profile_puppetboard'

}