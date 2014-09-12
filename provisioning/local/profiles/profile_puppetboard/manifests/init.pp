class profile_puppetboard{

  require ::puppet::params

  $puppetboard_certname = hiera('puppetboard.certname')
  $ssl_key = hiera('puppetboard.ssl_key')
  $ssl_cert = hiera('puppetboard.ssl_cert')
  $port = hiera('puppetboard.http_port', 80)
  $puppetdb_host = hiera('puppetdb.certname')
  $puppetdb_port = hiera('puppetdb.ssl_list_port', 8081)
  $puppet_group = $::puppet::params::puppet_group

  $ssl_dir = $::puppet::params::puppet_ssldir
  $ssl_key_path = "${ssl_dir}/private_keys/${puppetboard_certname}.pem"
  $ssl_ca_cert_path = "${ssl_dir}/certs/ca.pem"
  $ssl_cert_path = "${ssl_dir}/certs/${puppetboard_certname}.pem"

  file{
    $ssl_key_path:
      ensure  => file,
      content => $ssl_key,
      owner   => 'puppetboard',
      group   => $puppet_group,
      mode    => '0640';
    $ssl_cert_path:
      ensure  => file,
      content => $ssl_cert,
      owner   => 'puppetboard',
      group   => $puppet_group,
      mode    => '0644';
  }
  class{'::apache':}
  $wsgi_socket_prefix = $::osfamily ? {
    'RedHat' => '/var/run/wsgi',
    default  => undef,
  }
  class{'::apache::mod::wsgi':
    wsgi_socket_prefix => $wsgi_socket_prefix,
  }
  class{'::puppetboard':
    manage_git          => true,
    manage_virtualenv   => true,
    groups              => $puppet_group,
    puppetdb_host       => $puppetdb_host,
    puppetdb_port       => $puppetdb_port,
    puppetdb_key        => $ssl_key_path,
    puppetdb_ssl_verify => $ssl_ca_cert_path,
    puppetdb_cert       => $ssl_cert_path,
  }
  class{'::puppetboard::apache::vhost':
    vhost_name => $puppetboard_certname,
    port       => $port,
  }

}