# See README.md for further information on usage.
class ssh::client (
  $config_ensure  = $ssh::params::client_config_ensure,
  $config_path    = $ssh::params::client_config_path,
  $package_ensure = $ssh::params::client_package_ensure,
  $package_name   = $ssh::params::client_package_name,
) inherits ssh::params {

anchor { 'ssh::client::begin': } ->
  class { 'ssh::client::install': } ->
  class { 'ssh::client::config': } ->
anchor { 'ssh::client::end': }

}
