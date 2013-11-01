require 'spec_helper'
require 'etc'

describe 'private_key_users', :type => :fact do
  let(:singleuser) { Struct::Passwd.new('test', nil, nil, 1, 1, '/home/test') }
  let(:multiuser) {[
    Struct::Passwd.new('test', nil, nil, 1, 1, '/home/test'),
    Struct::Passwd.new('test2', nil, nil, 2, 2, '/var/tmp/test')
  ]}

  describe 'single user' do
    before :each do
      Etc.stubs(:passwd).yields(singleuser)
      File.stubs(:exists?).with('/home/test/.ssh/id_rsa').returns(true)
    end

    it { Facter.fact(:private_key_users).value.should eq 'test' }
  end

  describe 'multiple users' do
    before :each do
      Etc.stubs(:passwd).yields(multiuser)
    end

    it { Facter.fact(:private_key_users).value.should eq 'test' }
  end

end
