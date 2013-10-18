# See README.md for further information on usage.
class ssh::client::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'ssh':
    ensure => $ssh::client::package_ensure,
    name   => $ssh::client::package_name,
  }

}
