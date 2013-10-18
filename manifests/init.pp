# See README.md for further information on usage.
class ssh {

anchor { 'ssh::client::begin': } ->
  class { 'ssh::client::install': } ->
  class { 'ssh::client::config': } ->
anchor { 'ssh::client::end': }

anchor { 'ssh::server::begin': } ->
  class { 'ssh::server::install': } ->
  class { 'ssh::server::config': } ~>
  class { 'ssh::server::service': } ->
anchor { 'ssh::server::end': }

}
