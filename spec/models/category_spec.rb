require 'spec_helper'

describe Category do
  # Seriously, don't get attached to this style...
  # just a good starting point...[Sean]
  it { should be }
  it { should have_many(:items).through(:items_categories) }
end
