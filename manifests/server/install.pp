# See README.md for further information on usage.
class ssh::server::install {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'sshd':
    ensure => $ssh::server::package_ensure,
    name   => $ssh::server::package_name,
  }

}
