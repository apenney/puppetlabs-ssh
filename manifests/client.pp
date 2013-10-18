# See README.md for further information on usage.
class ssh::client {

anchor { 'ssh::client::begin': } ->
  class { 'ssh::client::install': } ->
  class { 'ssh::client::config': } ->
anchor { 'ssh::client::end': }

}
