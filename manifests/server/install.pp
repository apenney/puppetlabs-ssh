# See README.md for further information on usage.
class ssh::server::install inherits ssh::server {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'sshd':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
