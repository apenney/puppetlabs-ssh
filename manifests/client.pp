# See README.md for further information on usage.
class ssh::client (
  $config_ensure           = $ssh::params::client_config_ensure,
  $config_path             = $ssh::params::client_config_path,
  $package_ensure          = $ssh::params::client_package_ensure,
  $package_name            = $ssh::params::client_package_name,
  # Configuration
  $configuration_data      = $ssh::params::client_configuration_data,
) inherits ssh::params {

  # We declare the classes before containing them.
  class { 'ssh::client::install': } ->
  class { 'ssh::client::config': }

  contain ssh::client::install
  contain ssh::client::config
}
