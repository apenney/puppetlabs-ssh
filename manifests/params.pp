# See README.md for further information on usage.
class ssh::params {

  $server_config_ensure  = 'present'
  $server_package_ensure = 'present'
  $server_service_ensure = 'running'

  case $::osfamily {
    'Redhat': {
      $server_config_path  = '/etc/ssh/sshd_config'
      $server_package_name = 'openssh-server'
      $server_service_name = 'sshd'
    }
    'Debian': {
      $server_config_path  = '/etc/ssh/sshd_config'
      $server_package_name = 'openssh-server'
      $server_service_name = 'ssh'
    }
  }
  default {
    fail("${::module} is unsupported on ${::osfamily}")
  }

}
