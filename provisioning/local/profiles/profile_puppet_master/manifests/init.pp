# install a puppet master
class profile_puppet_master{

  $puppetdb_ip = hiera('puppetdb_ip')
  $puppetdb_port = hiera('puppetdb_port')
  $puppet_certname = hiera('puppet.certname')
  $ssldir = '/var/lib/puppet/ssl'

  class{'puppet::master':
    environments          => 'directory',
    storeconfigs          => true,
    storeconfigs_dbserver => $puppetdb_ip,
    storeconfigs_dbport   => $puppetdb_port,
    generate_ssl_certs    => false,
    certname              => $puppet_certname,
  }

  class{'::profile_puppet_master::ssl':
    certname     => $puppet_certname,
    ssldir       => $ssldir,
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