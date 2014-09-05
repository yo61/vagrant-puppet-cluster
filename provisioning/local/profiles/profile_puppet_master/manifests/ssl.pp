# Create the puppet ssl dir with pre-created certificates
class profile_puppet_master::ssl(
  $puppet_user = 'puppet',
  $puppet_group = 'puppet',
  $certname = undef,
  $ssldir = undef,
) {

  if $ssldir == undef {
    fail('ssldir must be defined')
  }
  if $certname == undef {
    fail('certname must be defined')
  }

  File{
    owner => $puppet_user,
    group => $puppet_group,
  }



  file{
    $ssldir:
      ensure  => 'directory',
      mode    => '0771';
    "${ssldir}/ca":
      ensure  => 'directory',
      mode    => '0755';
    "${ssldir}/ca/ca_crl.pem":
      ensure  => 'file',
      content => hiera('ssl.ca/ca_crl.pem'),
      mode    => '0644';
    "${ssldir}/ca/ca_crt.pem":
      ensure  => 'file',
      content => hiera('ssl.ca/ca_crt.pem'),
      mode    => '0644';
    "${ssldir}/ca/ca_key.pem":
      ensure  => 'file',
      content => hiera('ssl.ca/ca_key.pem'),
      mode    => '0640';
    "${ssldir}/ca/inventory.txt":
      ensure  => 'file',
      content => hiera('ssl.ca/inventory.txt'),
      mode    => '0644';
    "${ssldir}/ca/private":
      ensure  => 'directory',
      mode    => '0750';
    "${ssldir}/ca/private/ca.pass":
      ensure  => 'file',
      content => hiera('ssl.ca/private/ca.pass'),
      mode    => '0640';
    "${ssldir}/ca/requests":
      ensure  => 'directory',
      mode    => '0755';
    "${ssldir}/ca/serial":
      ensure  => 'file',
      content => hiera('ssl.ca/serial'),
      mode    => '0644';
    "${ssldir}/ca/signed":
      ensure  => 'directory',
      mode    => '0755';
    "${ssldir}/ca/signed/${certname}.pem":
      ensure  => 'file',
      content => hiera("ssl.ca/signed/${certname}.pem"),
      mode    => '0644';
    "${ssldir}/certificate_requests":
      ensure  => 'directory',
      mode    => '0755';
    "${ssldir}/certs":
      ensure  => 'directory',
      mode    => '0755';
    "${ssldir}/certs/ca.pem":
      ensure  => 'file',
      content => hiera('ssl.certs/ca.pem'),
      mode    => '0644';
    "${ssldir}/certs/${certname}.pem":
      ensure  => 'file',
      content => hiera("ssl.certs/${certname}.pem"),
      mode    => '0644';
    "${ssldir}/private":
      ensure  => 'directory',
      mode    => '0750';
    "${ssldir}/private_keys":
      ensure  => 'directory',
      mode    => '0750';
    "${ssldir}/private_keys/${certname}.pem":
      ensure  => 'file',
      content => hiera("ssl.private_keys/${certname}.pem"),
      mode    => '0640';
    "${ssldir}/public_keys":
      ensure  => 'directory',
      mode    => '0755';
    "${ssldir}/public_keys/${certname}.pem":
      ensure  => 'file',
      content => hiera("ssl.public_keys/${certname}.pem"),
      mode    => '0644';
  }

}