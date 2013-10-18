# See README.md for further information on usage.
class ssh::server::service {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'sshd':
    ensure => $ssh::server::service_ensure,
    name   => $ssh::server::service_name,
  }

}
