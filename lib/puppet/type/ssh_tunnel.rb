Puppet::Type.newtype(:ssh_tunnel) do
  @doc = 'Manage SSH tunnels'

  validate do
    # If we're not in SOCKS mode, we need a server and port to forward to.
    if self[:socks] == :false
      fail('forward_server is not set') if self[:forward_server].nil?
      fail('forward_port is not set') if self[:forward_port].nil?
    end
  end

  # This automatically creates the ensure parameter.
  ensurable

  newparam(:name, :namevar => true) do
    desc "The SSH tunnel name, must be unique."
  end

  newproperty(:socks) do
    desc 'Should this be a SOCKS proxy'
    newvalues(:true, :false)
    defaultto :false
  end

  newproperty(:local_port) do
    desc 'The local port to forward traffic from'
    validate do |port|
      fail("Port is not in the range 1-65535") unless port.to_i >= 1 and port.to_i <= 65535
    end
  end

  newproperty(:forward_port) do
    desc 'Port to forward traffic to'
    validate do |port|
      fail("Port is not in the range 1-65535") unless port.to_i >= 1 and port.to_i <= 65535
    end
  end

  newproperty(:remote_server) do
    desc 'Remote server to connect to'
    newvalue(/\w+/)
  end

  newproperty(:forward_server) do
    desc 'Server to forward traffic to'
    newvalue(/\w+/)
  end

  newproperty(:pid) do
    desc 'pid of process.'
    newvalue(/\d+/)
  end
 
end
