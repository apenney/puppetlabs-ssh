require 'spec_helper'

describe 'ssh::client' do

  shared_examples 'client' do |osfamily, package_name, package_path|
    let(:facts) {{ :osfamily => osfamily }}

    it 'contains the package' do
      should contain_package('ssh').with(
        :ensure => 'present',
        :name   => package_name
      )
    end

    it 'contains the ssh_config file' do
      should contain_file('ssh_config').with(
        :ensure => 'present',
        :path   => package_path
      )
    end
  end

  context 'RedHat' do
    it_behaves_like 'client', 'RedHat', 'openssh-clients', '/etc/ssh/ssh_config'
  end

  context 'Debian' do
    it_behaves_like 'client', 'Debian', 'openssh-client', '/etc/ssh/ssh_config'
  end

  context 'Unsupported' do
    let(:facts) {{ :osfamily => 'Unsupported' }}
    it { expect { should contain_class('ssh::client') }.to raise_error(Puppet::Error, /is unsupported on Unsupported/) }
  end

end
