# install a puppet master
class profile_puppet_master{

  require ::puppet::master

  $storeconfigs_dbserver = hiera('puppetdb.certname')
  $puppet_certname = hiera('puppet.master.certname')
  $modulepath = $::puppet::master::module_path

  class{'puppet::master':
    environments               => 'directory',
    storeconfigs               => true,
    storeconfigs_dbserver      => $storeconfigs_dbserver,
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
    modulepath => $modulepath,
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