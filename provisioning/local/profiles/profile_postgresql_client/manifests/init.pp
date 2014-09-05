class profile_postgresql_client{

  $postgresql_version = hiera('postgresql_version')

  class { '::postgresql::globals':
    manage_package_repo => true,
    version             => $postgresql_version,
    encoding            => 'UTF8',
  }->
  class{'::postgresql::client':}

}