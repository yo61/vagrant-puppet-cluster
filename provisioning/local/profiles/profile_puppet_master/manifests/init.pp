# install a puppet master
class profile_puppet_master{

  $puppetdb_ip = hiera('puppetdb.ssl_listen_address')
  $puppet_certname = hiera('puppet.master.certname')
  $ssldir = '/var/lib/puppet/ssl'

  class{'puppet::master':
    environments               => 'directory',
    storeconfigs               => true,
    storeconfigs_dbserver      => $puppetdb_ip,
    generate_ssl_certs         => false,
    certname                   => $puppet_certname,
    puppetdb_strict_validation => false,
  }

  class{'::profile_puppet_master::ssl':
    certname     => $puppet_certname,
    ssldir       => $::puppet::master::puppet_ssldir,
  }~>
  Service['httpd']

  puppet::masterenv{'production':
    modulepath => '/etc/puppet/modules',
    manifest   => 'production',
  }
  # create production env. directory
  # T
  #file{"${::puppet::params::environmentpath}/production":
  #  ensure => directory,
  #  owner  => 'root',
  # group  => 'root',
  #  mode   => '0755',
  #}

}