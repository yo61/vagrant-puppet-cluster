class profile_puppet_agent{

  $puppet_server = hiera('puppet.master.certname')
  class{'::puppet::agent':
    puppet_server    => $puppet_server,
    puppet_run_style => 'external',
  }

}