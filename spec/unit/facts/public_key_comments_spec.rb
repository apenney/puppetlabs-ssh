require 'spec_helper'
require 'etc'

describe 'public_key_comments', :type => :fact do
  let(:singleuser) { Struct::Passwd.new('test', nil, nil, 1, 1, '/home/test') }
  let(:multiuser) {[
    Struct::Passwd.new('test', nil, nil, 1, 1, '/home/test'),
    Struct::Passwd.new('test2', nil, nil, 2, 2, '/var/tmp/test')
  ]}
  let(:keys) { 
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVwwxl6dz6Y7karwyS8S+za4qcu99Ra8H8N3cVHanEB+vuigtbhLOSb+bk6NjxFtC/jF+Usf5FM5fGIYd51L7RE9BbzbKiWb9giFnNqhKWclO5CY4sQTyUyYiJTQKLuVtkmiFeArV+jIuthxm6JrdOeFx8lJpcgGlZjlcBGxp27EbZNGWIlAdvW0ZXy0JqS9M/vj71NBBDfkrpyzAPC0aBa9+FmywOH6HXbyeFooHLOw+mfzP87jwDDQ2yXIehDoC1BsLYXD+j+kdnR0CNltJh1PYOFNpbKQpfnPhfdw4Oc0hZ34n+kfBPavKlbwxoVAoisBWWo4c9ZnUoe2OBRHAX test@local
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQjmi7VZln/ehWW5nDgpHKWRSAOEUd//Qft00vqBq1khyGF6o0hUmLhjU1fxXv3w7GNshgoqTTsgMRNSOP06UaNJwU8g1Gyji9ard+mVtJ7ohgv/OSR2cujL/853Q/LOVo5LIgEKRxCyA1KAPE68n44WC3RIvUO78tk5flagAHYN/i+B8k4W040aqtEvTMjKGag7377eQIzp4GNJ8Hzm1VdFeZQQewAi/hrUOyU3gWoXTpN+xaWr41b4Vugrgb5V9/esDBXb+y2zj8Wc/hX2xc33crfWLkFh7YhmsgmhMEAKE8G2mZEG3Sx3/9BHNsleBTh0oJl5CZm+cBh+BCCGq/ test@127.0.0.1"
  }

  describe 'single user' do
    before :each do
      Etc.stubs(:passwd).yields(singleuser)
      Dir.stubs(:[]).with("/home/test/.ssh/*.pub").returns(["id_rsa.pub"])
      File.stubs(:read).with('/home/test/.ssh/id_rsa.pub').returns(keys)
    end

    it { Facter.fact(:public_key_comments).value.should eq 'test@local,test@127.0.0.1' }
  end

  describe 'multiple user' do
    before :each do
      Etc.stubs(:passwd).yields(multiuser)
      Dir.stubs(:[]).with("/home/test/.ssh/*.pub").returns(["id_rsa.pub"])
      Dir.stubs(:[]).with("/var/tmp/test/.ssh/*.pub").returns(["id_rsa.pub"])
      File.stubs(:read).with('/home/test/.ssh/id_rsa.pub').returns(keys)
      File.stubs(:read).with('/var/tmp/test/.ssh/id_rsa.pub').returns(keys)
    end

    it { Facter.fact(:public_key_comments).value.should eq 'test@local,test@127.0.0.1' }
  end

end
