# See README.md for further information on usage.
class ssh::client::install inherits ssh::client {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'ssh':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
