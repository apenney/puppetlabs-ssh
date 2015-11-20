require 'etc'

Facter.add(:public_key_comments) do
  setcode do
    comments = []
    # This generates an object for each entry in /etc/passwd
    Etc.passwd do |user|
      # Generate a list of *.pub files in ~/.ssh/
      keyfiles = Dir["#{user.dir}/.ssh/*.pub"]
      # Check each .pub file in ~/.ssh/ in turn
      keyfiles.each do |file|
        contents = File.read("#{file}")
        contents.each_line do |line|
          comments << line.split(' ').last
        end
      end
    end
    # Facts must be strings, so return a comma seperated list.
    comments.uniq.join(',')
  end
end
