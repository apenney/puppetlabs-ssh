# See README.md for further information on usage.
class ssh::server::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { 'sshd_config':
    ensure => $ssh::server::config_ensure,
    path   => $ssh::server::config_path,
    owner  => 'root',
    group  => 'root',
    mode   => '0544',
  }

}
