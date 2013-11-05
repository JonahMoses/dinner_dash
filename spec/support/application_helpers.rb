module UserHelpers

  def register_user
    visit '/log_in'
    fill_in 'email', :with => "user@example.com"
    fill_in 'password', :with => "foobarbaz"
    click_link_or_button 'Save changes'
  end

end

RSpec.configure do |c|
  c.include UserHelpers
end
