require 'spec_helper_acceptance'

describe 'ssh class:' do
  it 'should run successfully' do
    pp = <<-EOS
    class { 'ssh::client': }
    class { 'ssh::server': }
    EOS

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

  describe service('sshd') do
    it { should be_enabled.with_level(3) }
    it { should be_running }
  end

  describe 'service' do
    it 'should be running' do
      shell('service sshd status', :acceptable_exit_codes => [0]) do |r|
        expect(r.stdout).to match(/openssh-daemon.*is running/)
      end
    end
  end

end
