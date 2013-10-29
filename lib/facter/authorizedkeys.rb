require 'puppet'

class Ssh_authorizedkeys
  # Obtain a list of all the users on the system by querying
  # puppet.  This uses the existing users type to search all
  # users and then creates a hash of users->homedirs.
  def self.users
    users = {}
    Puppet::Type.type("user").instances.find_all do |user|
      @values = user.retrieve
      users[user.name] = @values[user.property(:home)]
    end
    users
  end
end
puts Ssh_authorizedkeys.users
# Now we iterate over each user, check for an authorized_keys
# file and then iterate through that file if found to create
# the appropriate facts.
Ssh_authorizedkeys.users.each do |user, home|
  keyfile = File.join(home, '.ssh/authorized_keys')
  if File.exists?(keyfile)
    keys = File.read(keyfile)
    # This is our first fact, the one containing the count of
    # keys discovered.
    Facter.add("#{user}_authorizedkeys") do
      setcode do
        # Just return the count of lines
        keys.lines.count
      end
    end

    # Our next set of facts are per key.
    count = 1
    keys.each_line do |key|
      Facter.add("#{user}_authorizedkey_#{count}") do
        setcode do
          # Here we just return the key itself.
          key
        end
      end
      count += 1
    end

  end
end
