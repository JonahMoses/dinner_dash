require 'spec_helper'

describe User do

  it "encrypts the password" do
    user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                    :password => "foobar", :password_confirmation => "foobar")
    user.save
    user.password_hash.length.should eq(60)
    user.password_salt.length.should eq(29)
  end

  it "limits short length of display_name" do
    short_user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                    :display_name => "1",
                    :password => "foobar", :password_confirmation => "foobar")
    short_user.valid?.should be_false
  end

  it "limits long length of display_name" do
    long_user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                    :display_name => "3"*33,
                    :password => "foobar", :password_confirmation => "foobar")
    long_user.valid?.should be_false
  end

  it "it accepts good length display_name" do
    user = User.new(:email => "dragons@example.com", :full_name => "yes sir",
                    :display_name => "3"*30,
                    :password => "foobar", :password_confirmation => "foobar")
    user.valid?.should be_true
  end

  it "rejects blank full_name" do
    user = User.new(:email => "dragons@example.com", :full_name => "  ",
                    :display_name => "3"*30,
                    :password => "foobar", :password_confirmation => "foobar")
    user.valid?.should be_false
  end

  it "rejects invalid email addresses" do
    no_at = User.new(:email => "dragonxample.com", :full_name => "yeas",
                    :password => "foobar", :password_confirmation => "foobar")
    no_tld = User.new(:email => "dragonx@llample", :full_name => "yeas",
                    :password => "foobar", :password_confirmation => "foobar")
    no_name = User.new(:email => "@dragonxample.com", :full_name => "yeas",
                    :password => "foobar", :password_confirmation => "foobar")
    valid_user = User.new(:email => "dragon@example.com", :full_name => "yeas",
                    :password => "foobar", :password_confirmation => "foobar")
    no_at.valid?.should be_false
    no_tld.valid?.should be_false
    no_name.valid?.should be_false
    valid_user.valid?.should be_true
  end

end
