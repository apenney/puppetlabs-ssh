# See README.md for further information on usage.
class ssh::client (
  $config_ensure           = $ssh::params::client_config_ensure,
  $config_path             = $ssh::params::client_config_path,
  $package_ensure          = $ssh::params::client_package_ensure,
  $package_name            = $ssh::params::client_package_name,
  # Configuration
  $forward_agent           = $ssh::params::client_forward_agent,
  $forward_x11             = $ssh::params::client_forward_x11,
  $password_authentication = $ssh::params::client_password_authentication,
  $port                    = $ssh::params::client_port,
  $protocol                = $ssh::params::client_protocol,
) inherits ssh::params {

  contain ssh::client::install
  contain ssh::client::config

  class { 'ssh::client::install': } ->
  class { 'ssh::client::config': }

}
