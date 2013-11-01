require 'etc'

Facter.add(:private_key_users) do
  setcode do
    users = []
    # This generates an object for each entry in /etc/passwd
    Etc.passwd do |user|
      # Look for known private key names.
      ['id_rsa', 'id_dsa'].each do |file|
        if File.exists?("#{user.dir}/.ssh/#{file}")
          users << user.name
          # Once we've found a key we can skip the rest of the tests
          break
        end
      end
    end
    # Facts must be strings, so return a list of users comma seperated.
    users.join(',')
  end
end
