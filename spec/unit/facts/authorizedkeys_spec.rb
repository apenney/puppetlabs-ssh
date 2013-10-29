require 'spec_helper'
require 'facter'

describe 'authorizedkeys' do
  before(:each) {
    Ssh_authorizedkeys.stubs(:users).returns({:test => '/home/test'})
    File.stubs(:exists?).with('/home/test/.ssh/authorized_keys').returns(true)
    File.stubs(:read).with('/home/test/.ssh/authorized_keys').returns('key')
    Facter.collection.internal_loader.load(:authorizedkeys)
  }

  it { Facter.fact(:test_authorizedkeys).value.should eq 1 }
  it { Facter.fact(:test_authorizedkey_1).value.should eq 'key' }
end
