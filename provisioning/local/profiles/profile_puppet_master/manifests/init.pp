# install a puppet master
class profile_puppet_master{

  $puppetdb_ip = hiera('puppetdb_ip')
  $puppetdb_port = hiera('puppetdb_port')
  $certname = $::fqdn
  $ssldir = '/var/lib/puppet/ssl'

  class{'puppet::master': }

  class{'::profile_puppet_master::ssl':
    certname     => $certname,
    ssldir       => $ssldir,
  }

}