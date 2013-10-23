Puppet::Type.type(:ssh_tunnel).provide(:ssh) do
  desc 'Create ssh tunnels'

  commands :ssh => 'ssh'

  def self.instances
    instances = []
    tunnel_connections = ssh_processes("#{ssh_opts} -L")
    socks_connections  = ssh_processes("#{ssh_opts} -D")

    tunnel_connections.each do |name, pid|
      rest, remote_host = name.split(' ')
      local_port, forward_server, forward_port = rest.split(':')
      instances << new(
        :ensure         => :present,
        :name           => "#{rest}-#{remote_host}",
        :local_port     => local_port,
        :forward_server => forward_server,
        :forward_port   => forward_port,
        :remote_host    => remote_host,
        :socks          => :false,
        :pid            => pid
      )
    end

    socks_connections.each do |name, pid|
      local_port, remote_host = name.split(' ')

      instances << new(
        :ensure      => :present,
        :name        => "#{local_port}-#{remote_host}",
        :local_port  => local_port,
        :remote_host => remote_host,
        :socks       => :true,
        :pid         => pid
      )
    end

    return instances
  end

  def self.prefetch(resources)
    # Obtain a hash of all the instances we can discover
    tunnels = instances
    resources.keys.each do |name|
      # If we find the resource in the catalog in the discovered list
      # then set the provider for the resource to this one.
      if provider = tunnels.find { |tunnel| tunnel.name == name }
        resources[name].provider = provider
      end
    end
  end

  def create
    if @resource[:socks] == :true
      # Create a SOCKS proxy
      ssh(ssh_opts, '-D', @resource[:local_port], @resource[:remote_server])
      @property_hash[:ensure]        = :present
      @property_hash[:local_port]    = @resource[:local_port]
      @property_hash[:remote_server] = @resource[:remote_server]
    else
      # Create an SSH tunnel
      ssh(ssh_opts, '-L', "#{@resource[:local_port]}:#{@resource[:forward_server]}:#{@resource[:forward_port]}", @resource[:remote_server])
      @property_hash[:ensure]         = :present
      @property_hash[:local_port]     = @resource[:local_port]
      @property_hash[:forward_server] = @resource[:forward_server]
      @property_hash[:forward_port]   = @resource[:forward_port]
      @property_hash[:remote_server]  = @resource[:remote_server]
    end

    exists? ? (return true) : (return false)
  end
  
  def destroy
    Process.kill('SIGTERM', @property_hash[:pid].to_i)
    @property_hash.clear
  end

  def exists?
    @property_hash[:ensure] == :present || false
  end

  mk_resource_methods

  # -f tells ssh to go into the background just before command execution
  # -N tells ssh not to execute remote commands
  def self.ssh_opts
    '-fN'
  end
  # This allows ssh_opts to be used within the instance.
  def ssh_opts
    self.class.ssh_opts
  end

  private

  # Find and return the ssh tunnel/proxy names and their associated pid.
  def self.ssh_processes(pattern)
    ssh_processes = {}
    ps = Facter["ps"].value
    IO.popen(ps) do |table|
      table.each_line do |line|
        # Attempts to match 'user (pid).*ssh {sshopts} (port:host:port host)'
        if match = line.match(/^\w+\s+(\d+)\s.*ssh\s#{pattern}\s(\d+:?\w*:?\d*\s\w.+)/)
          pid, name = match.captures
          ssh_processes[name] = pid
        end
      end
    end
    return ssh_processes
  end

end
