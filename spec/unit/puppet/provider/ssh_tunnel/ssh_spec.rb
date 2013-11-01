require 'spec_helper'

describe Puppet::Type.type(:ssh_tunnel).provider(:ssh) do
  let(:socks_resource) { 
    Puppet::Type.type(:ssh_tunnel).new(
      :name          => '8080-socks@remote',
      :socks         => :true,
      :remote_server => 'socks@remote',
      :local_port    => '8080',
      :provider      => :ssh
    )
  }
  let(:tunnel_resource) {
    Puppet::Type.type(:ssh_tunnel).new(
      :name           => '8080:localhost:80-tunnel@remote',
      :socks          => :false,
      :forward_server => 'localhost',
      :forward_port   => '80',
      :remote_server  => 'tunnel@remote',
      :local_port     => '8080',
      :provider       => :ssh
    )
  }
  let(:socks_provider) { socks_resource.provider }
  let(:tunnel_provider) { tunnel_resource.provider }

  describe 'self.instances' do
    before :each do
      subject.class.expects(:ssh_processes).with('-fN -D').returns({'8080 socks@remote' => '10'})
      subject.class.expects(:ssh_processes).with('-fN -L').returns({'8080:localhost:80 tunnel@remote' => '11'})
    end

    it do
      instances = subject.class.instances.map { |p| {:name => p.get(:name), :ensure => p.get(:ensure)} }
      instances[0].should == {:name => '8080:localhost:80-tunnel@remote', :ensure => :present}
      instances[1].should == {:name => '8080-socks@remote', :ensure => :present}
    end
  end

  describe 'self.prefetch' do
    it 'exists' do
      socks_provider.class.instances
      socks_provider.class.prefetch({})
    end
  end

  describe 'create' do
    it 'makes a socks proxy' do
      socks_provider.expects(:ssh).with('-fN', '-D', '8080', 'socks@remote').returns(true)
      socks_provider.expects(:exists?).returns(true)
      socks_provider.create.should be_true
    end
    it 'makes a tunnel' do
      tunnel_provider.expects(:ssh).with('-fN', '-L', '8080:localhost:80', 'tunnel@remote').returns(true)
      tunnel_provider.expects(:exists?).returns(true)
      tunnel_provider.create.should be_true
    end
  end

  describe 'destroy' do
    it 'destroys socks' do
      socks_provider.pid = 10
      Process.stubs(:kill).with('SIGTERM', 10).returns(true)
      socks_provider.destroy.should be_true
    end
    it 'destroys tunnel' do
      tunnel_provider.pid = 11
      Process.stubs(:kill).with('SIGTERM', 11).returns(true)
      tunnel_provider.destroy.should be_true
    end
  end

  describe 'exists?' do
    it 'checks if socks proxy exists' do
      socks_provider.ensure= :present
      socks_provider.exists?.should be_true
    end
    it 'checks if tunnel proxy exists' do
      tunnel_provider.ensure= :present
      tunnel_provider.exists?.should be_true
    end
  end

  describe 'ssh_opts' do
    it { subject.ssh_opts.should eq '-fN' }
  end

end
