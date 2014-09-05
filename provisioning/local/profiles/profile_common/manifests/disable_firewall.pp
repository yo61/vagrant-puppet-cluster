class profile_common::disable_firewall{

  # FIXME make this work for OS other than CentOS 7
  # kill firewalld - will only work on hosts running firewalld, eg. CentOS7
  service{'firewalld':
    ensure => 'stopped',
    enable => false,
  }

}