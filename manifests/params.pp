# See README.md for further information on usage.
class ssh::params {

  # Server parameters
  $server_config_ensure           = 'present'
  $server_package_ensure          = 'present'
  $server_service_ensure          = 'running'
  $server_port                    = '22'
  $server_protocol                = '2'
  $server_permit_root_password    = 'yes'
  $server_password_authentication = 'yes'
  # Client parameters
  $client_config_ensure           = 'present'
  $client_package_ensure          = 'present'

  case $::osfamily {
    'Redhat': {
      $client_config_path  = '/etc/ssh/ssh_config'
      $client_package_name = 'openssh-clients'

      $server_config_path  = '/etc/ssh/sshd_config'
      $server_package_name = 'openssh-server'
      $server_service_name = 'sshd'
      $server_sftp_path    = '/usr/libexec/openssh/sftp-server'
      $server_hostkeys     = []
    }
    'Debian': {
      $client_config_path  = '/etc/ssh/ssh_config'
      $client_package_name = 'openssh-client'

      $server_config_path  = '/etc/ssh/sshd_config'
      $server_package_name = 'openssh-server'
      $server_service_name = 'ssh'
      $server_sftp_path    = '/usr/lib/openssh/sftp-server'
      $server_hostkeys     = [ '/etc/ssh/ssh_host_rsa_key', '/etc/ssh/ssh_host_dsa_key', '/etc/ssh/ssh_host_ecdsa_key' ]
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }

}
