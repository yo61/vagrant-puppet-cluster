class profile_ntp{

  $ntp_servers = hiera('ntp.servers')
  validate_array($ntp_servers)

  class{'ntp':
    servers => $ntp_servers,
  }

}