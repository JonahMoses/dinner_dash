require 'spec_helper'

RSpec::Matchers.define :allow_access do |*args|
  match do |permission|
    permission.allow?(*args).should be_true
  end
end

describe Permission do

  describe "as guest" do
    subject { Permission.new(nil) }
    it { should allow_access("items", "index") }
    it { should allow_access("items", "show") }
    it { should_not allow_access("items", "new") }
    it { should_not allow_access("items", "create") }
    it { should_not allow_access("items", "edit") }
    it { should_not allow_access("items", "update") }
    it { should_not allow_access("items", "destroy") }
  end

  describe "as guest" do
    subject { Permission.new(User.new(:admin => true)) }
    it { should allow_access("items", "index") }
    it { should allow_access("items", "show") }
    it { should allow_access("items", "new") }
    it { should allow_access("items", "create") }
    it { should allow_access("items", "edit") }
    it { should allow_access("items", "update") }
    it { should allow_access("items", "destroy") }
  end

end
