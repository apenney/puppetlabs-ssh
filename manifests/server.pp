# See README.md for further information on usage.
class ssh::server(
  $config_ensure             = $ssh::params::server_config_ensure,
  $config_path               = $ssh::params::server_config_path,
  $package_ensure            = $ssh::params::server_package_ensure,
  $package_name              = $ssh::params::server_package_name,
  $service_ensure            = $ssh::params::server_service_ensure,
  $service_name              = $ssh::params::server_service_name,
  # Configuration parameters
  $configuration_data        = $ssh::params::server_configuration_data,
  $os_configuration_data     = $ssh::params::server_os_configuration_data,
) inherits ssh::params {

  # We declare the classes before containing them.
  class { 'ssh::server::install': } ->
  class { 'ssh::server::config': } ~>
  class { 'ssh::server::service': }

  contain ssh::server::install
  contain ssh::server::config
  contain ssh::server::service

}
