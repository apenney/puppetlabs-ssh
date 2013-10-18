# See README.md for further information on usage.
class ssh::server(
  $config_ensure  = $ssh::params::server_config_ensure,
  $config_path    = $ssh::params::server_config_path,
  $package_ensure = $ssh::params::server_package_ensure,
  $package_name   = $ssh::params::server_package_name,
  $service_ensure = $ssh::params::server_service_ensure,
  $service_name   = $ssh::params::server_service_name,
) inherits ssh::params {

anchor { 'ssh::server::begin': } ->
  class { 'ssh::server::install': } ->
  class { 'ssh::server::config': } ~>
  class { 'ssh::server::service': } ->
anchor { 'ssh::server::end': }

}
