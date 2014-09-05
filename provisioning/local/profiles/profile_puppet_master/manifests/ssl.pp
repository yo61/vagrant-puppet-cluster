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
      ensure => 'directory',
      mode   => '0771';
    "${ssldir}/ca":
      ensure => 'directory',
      mode   => '0755';
    "${ssldir}/ca/ca_crl.pem":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/ca/ca_crt.pem":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/ca/ca_key.pem":
      ensure => 'file',
      mode   => '0640';
    "${ssldir}/ca/ca_pub.pem":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/ca/inventory.txt":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/ca/private":
      ensure => 'directory',
      mode   => '0750';
    "${ssldir}/ca/private/ca.pass":
      ensure => 'file',
      mode   => '0640';
    "${ssldir}/ca/requests":
      ensure => 'directory',
      mode   => '0755';
    "${ssldir}/ca/serial":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/ca/signed":
      ensure => 'directory',
      mode   => '0755';
    "${ssldir}/ca/signed/${certname}.pem":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/certificate_requests":
      ensure => 'directory',
      mode   => '0755';
    "${ssldir}/certificate_requests/${certname}.pem":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/certs":
      ensure => 'directory',
      mode   => '0755';
    "${ssldir}/certs/ca.pem":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/certs/${certname}.pem":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/crl.pem":
      ensure => 'file',
      mode   => '0644';
    "${ssldir}/private":
      ensure => 'directory',
      mode   => '0750';
    "${ssldir}/private_keys":
      ensure => 'directory',
      mode   => '0750';
    "${ssldir}/private_keys/${certname}.pem":
      ensure => 'file',
      mode   => '0640';
    "${ssldir}/public_keys":
      ensure => 'directory',
      mode   => '0755';
    "${ssldir}/public_keys/${certname}.pem":
      ensure => 'file',
      mode   => '0644';
  }

}