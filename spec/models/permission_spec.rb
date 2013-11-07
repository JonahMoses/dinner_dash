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
  end

end
