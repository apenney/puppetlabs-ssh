# See README.md for further information on usage.
class ssh::server::config inherits ssh::server {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { 'sshd_config':
    ensure  => $config_ensure,
    path    => $config_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0544',
    content => template('ssh/sshd_config.erb'),
  }

}
