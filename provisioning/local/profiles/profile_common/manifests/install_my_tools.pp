class profile_common::install_my_tools{

  $my_tool_list = [ 'ack', 'lsof', 'vim-enhanced' ]
  package{$my_tool_list:
    ensure => installed
  }

}