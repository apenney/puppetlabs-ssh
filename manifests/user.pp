define ssh::user(
  $ensure             = present,
  $owner              = $name,
  $group              = $name,
  $configuration_data = [ { '*'  => {} } ]
) {

  file { "${name}_ssh":
    ensure => directory,
    path   => "/home/${name}/.ssh/",
    owner  => $owner,
    group  => $group,
    mode   => '0700',
  } ->

  file { "${name}_ssh_config":
    ensure  => $ensure,
    path    => "/home/${name}/.ssh/ssh_config",
    owner   => $owner,
    group   => $group,
    mode    => '0600',
    content => template('ssh/ssh_config.erb'),
  }

}
