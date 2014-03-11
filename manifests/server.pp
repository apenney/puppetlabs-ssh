# See README.md for further information on usage.
class ssh::server(
  $config_ensure             = $ssh::params::server_config_ensure,
  $config_path               = $ssh::params::server_config_path,
  $package_ensure            = $ssh::params::server_package_ensure,
  $package_name              = $ssh::params::server_package_name,
  $service_ensure            = $ssh::params::server_service_ensure,
  $service_name              = $ssh::params::server_service_name,
  # Configuration parameters
  $port                      = $ssh::params::server_port,
  $protocol                  = $ssh::params::server_protocol,
  $permit_root_login         = $ssh::params::server_permit_root_login,
  $password_authentication   = $ssh::params::server_password_authentication,
  $sftp_path                 = $ssh::params::server_sftp_path,
  $hostkeys                  = $ssh::params::server_hostkeys
) inherits ssh::params {

  contain ssh::server::install
  contain ssh::server::config
  contain ssh::server::service

  class { 'ssh::server::install': } ->
  class { 'ssh::server::config': } ~>
  class { 'ssh::server::service': }

}
