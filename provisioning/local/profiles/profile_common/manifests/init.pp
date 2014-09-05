class profile_common {

  include ::profile_common::disable_firewall
  include ::profile_common::install_epel
  include ::profile_common::install_my_tools
  include ::profile_ntp
  include ::profile_puppet_agent

}