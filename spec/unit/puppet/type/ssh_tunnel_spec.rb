require 'spec_helper'
require 'puppet'

describe Puppet::Type.type(:ssh_tunnel) do

  let(:socks) { Puppet::Type.type(:ssh_tunnel).new(
    :name          => 'test',
    :local_port    => '8080',
    :socks         => :true,
    :remote_server => 'testserver'
  )}
  let(:tunnel) { Puppet::Type.type(:ssh_tunnel).new(
    :name           => 'test2',
    :forward_server => 'localhost',
    :forward_port   => '80',
    :local_port     => '8080',
    :socks          => :false,
    :remote_server  => 'testserver'
  )}

  context 'socks' do
    it 'should accept a name' do
      socks[:name].should eq 'test'
    end
    it 'should accept a local_port' do
      socks[:local_port].should eq '8080'
    end
    it 'should accept a socks boolean' do
      socks[:socks].should eq :true
    end
    it 'should accept a remote_server' do
      socks[:remote_server].should eq 'testserver'
    end
  end



  context 'tunnel' do
    it 'should accept a name' do
      tunnel[:name].should eq 'test2'
    end
    it 'should accept a local_port' do
      tunnel[:local_port].should eq '8080'
    end
    it 'should accept a socks boolean' do
      tunnel[:socks].should eq :false
    end
    it 'should accept a remote_server' do
      tunnel[:remote_server].should eq 'testserver'
    end
    it 'should accept a forward_server' do
      tunnel[:forward_server].should eq 'localhost'
    end
    it 'should accept a forward_port' do
      tunnel[:forward_port].should eq '80'
    end
  end

  context 'validation' do
    it 'should raise an error without forward_server' do
      expect { Puppet::Type.type(:ssh_tunnel).new(
        :name           => 'test2',
        :forward_port   => '80',
        :local_port     => '8080',
        :socks          => :false,
        :remote_server  => 'testserver')
      }.to raise_error(Puppet::ResourceError, 'Validation of Ssh_tunnel[test2] failed: forward_server is not set')
    end
    it 'should raise an error without forward_port' do
      expect { Puppet::Type.type(:ssh_tunnel).new(
        :name           => 'test2',
        :forward_server => 'localhost',
        :local_port     => '8080',
        :socks          => :false,
        :remote_server  => 'testserver')
      }.to raise_error(Puppet::ResourceError, 'Validation of Ssh_tunnel[test2] failed: forward_port is not set')
    end
    it 'should fail with a non-boolean socks' do
      expect { Puppet::Type.type(:ssh_tunnel).new(
        :name           => 'test2',
        :local_port     => '8080',
        :socks          => :no,
        :remote_server  => 'testserver')
      }.to raise_error(Puppet::ResourceError, 'Parameter socks failed on Ssh_tunnel[test2]: Invalid value :no. Valid values are true, false. ')
    end
    it 'should fail with a local_port out of range' do
      expect { Puppet::Type.type(:ssh_tunnel).new(
        :name           => 'test2',
        :local_port     => '99999',
        :socks          => :false,
        :remote_server  => 'testserver')
      }.to raise_error(Puppet::ResourceError, 'Parameter local_port failed on Ssh_tunnel[test2]: Port is not in the range 1-65535')
    end
  end

end
