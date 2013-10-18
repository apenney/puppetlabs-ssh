# See README.md for further information on usage.
class ssh::client::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  file { 'ssh_config':
    ensure => $ssh::client::config_ensure,
    path   => $ssh::client::config_path,
  }

}
