require 'spec_helper'

describe 'ssh::server' do

  shared_examples 'server' do |osfamily, package_name, package_path, service_name|
    let(:facts) {{ :osfamily => osfamily }}

    it 'contains the package' do
      should contain_package('sshd').with(
        :ensure => 'present',
        :name   => package_name
      )
    end

    it 'contains the ssh_config file' do
      should contain_file('sshd_config').with(
        :ensure => 'present',
        :path   => package_path
      )
    end

    it 'contains the sshd service' do
      should contain_service('sshd').with(
        :ensure => 'running',
        :name   => service_name
      )
    end
  end

  context 'RedHat' do
    it_behaves_like 'server', 'RedHat', 'openssh-server', '/etc/ssh/sshd_config', 'sshd'
  end

  context 'Debian' do
    it_behaves_like 'server', 'Debian', 'openssh-server', '/etc/ssh/sshd_config', 'ssh'
  end

  context 'Unsupported' do
    let(:facts) {{ :osfamily => 'Unsupported' }}
    it { expect { should contain_class('ssh::server') }.to raise_error(Puppet::Error, /is unsupported on Unsupported/) }
  end

  context 'default template contents' do
    let(:facts) {{ :osfamily => 'Debian' }}

    it { should contain_file('sshd_config').with(
      :content => /Port 22/
    )}
    it { should contain_file('sshd_config').with(
      :content => /Protocol 2/
    )}
    it { should contain_file('sshd_config').with(
      :content => /PermitRootLogin yes/
    )}
    it { should contain_file('sshd_config').with(
      :content => /PasswordAuthentication yes/
    )}
    it { should contain_file('sshd_config').with(
      :content => /Subsystem sftp \/usr\/lib\/openssh\/sftp-server \/usr\/lib\/openssh\/sftp-server/
    )}
    it { should contain_file('sshd_config').with(
      :content => /HostKey \/etc\/ssh\/ssh_host_rsa_key/
    )}
  end

end
