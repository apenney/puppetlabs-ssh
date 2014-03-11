# See README.md for further information on usage.
class ssh::params {

  # Server parameters
  $server_config_ensure           = 'present'
  $server_package_ensure          = 'present'
  $server_service_ensure          = 'running'
  $server_configuration_data      = {
    'Port' => '22',
    'Protocol' => '2',
    'UsePrivilegeSeparation' => 'yes',
    'KeyRegenerationInterval' => '3600',
    'ServerKeyBits' => '768',
    'SyslogFacility' => 'AUTH',
    'LogLevel' => 'INFO',
    'LoginGraceTime' => '120',
    'PermitRootLogin' => 'yes',
    'StrictModes' => 'yes',
    'RSAAuthentication' => 'yes',
    'PubkeyAuthentication' => 'yes',
    'IgnoreRhosts' => 'yes',
    'RhostsRSAAuthentication' => 'no',
    'HostbasedAuthentication' => 'no',
    'PermitEmptyPasswords' => 'no',
    'ChallengeResponseAuthentication' => 'no',
    'PasswordAuthentication' => 'yes',
    'X11Forwarding' => 'yes',
    'X11DisplayOffset' => '10',
    'PrintMotd' => 'no',
    'PrintLastLog' => 'yes',
    'TCPKeepAlive' => 'yes',
    'AcceptEnv' => 'LANG LC_*',
    'UsePAM' => 'yes',
  }
  # Client parameters
  $client_config_ensure           = 'present'
  $client_package_ensure          = 'present'
  $client_configuration_data      = [ { '*' => {} } ]

  case $::osfamily {
    'Redhat': {
      $client_config_path           = '/etc/ssh/ssh_config'
      $client_package_name          = 'openssh-clients'

      $server_config_path           = '/etc/ssh/sshd_config'
      $server_package_name          = 'openssh-server'
      $server_service_name          = 'sshd'
      $server_os_configuration_data = {
        'HostKey'   => [],
        'Subsystem' => 'sftp /usr/libexec/openssh/sftp-server /usr/lib/openssh/sftp-server',
      }
    }
    'Debian': {
      $client_config_path           = '/etc/ssh/ssh_config'
      $client_package_name          = 'openssh-client'

      $server_config_path           = '/etc/ssh/sshd_config'
      $server_package_name          = 'openssh-server'
      $server_service_name          = 'ssh'
      $server_os_configuration_data = {
        'HostKey'   => [ '/etc/ssh/ssh_host_rsa_key', '/etc/ssh/ssh_host_dsa_key', '/etc/ssh/ssh_host_ecdsa_key' ],
        'Subsystem' => 'sftp /usr/lib/openssh/sftp-server /usr/lib/openssh/sftp-server',
      }
    }
    default: {
      fail("${::module} is unsupported on ${::osfamily}")
    }
  }

}
