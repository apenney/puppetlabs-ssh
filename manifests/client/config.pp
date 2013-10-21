# See README.md for further information on usage.
class ssh::client::config inherits ssh::client {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { 'ssh_config':
    ensure => $config_ensure,
    path   => $config_path,
  }

}
