require 'spec_helper'

describe User do

  it "encrypts the password" do
    user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                    :password => "foobar", :password_confirmation => "foobar")
    user.save
    user.password_hash.length.should eq(60)
    user.password_salt.length.should eq(29)
  end

end
