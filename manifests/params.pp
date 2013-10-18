# See README.md for further information on usage.
class ssh::params {

  # Server parameters
  $server_config_ensure  = 'present'
  $server_package_ensure = 'present'
  $server_service_ensure = 'running'
  # Client parameters
  $client_config_ensure  = 'present'
  $client_package_ensure = 'present'

  case $::osfamily {
    'Redhat': {
      $client_config_path  = '/etc/ssh/ssh_config'
      $client_package_name = 'openssh-clients'

      $server_config_path  = '/etc/ssh/sshd_config'
      $server_package_name = 'openssh-server'
      $server_service_name = 'sshd'
    }
    'Debian': {
      $client_config_path  = '/etc/ssh/ssh_config'
      $client_package_name = 'openssh-client'

      $server_config_path  = '/etc/ssh/sshd_config'
      $server_package_name = 'openssh-server'
      $server_service_name = 'ssh'
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }

}
