# See README.md for further information on usage.
class ssh::server::service inherits ssh::server {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'sshd':
    ensure => $service_ensure,
    name   => $service_name,
  }

}
