class User < ActiveRecord::Base
  attr_accessor :password
  has_many :orders

  before_save   :encrypt_password
  with_options :unless => :guest? do |user|
    user.validates_confirmation_of :password
    user.validates_presence_of     :password, :on => :create
    user.validates                 :display_name, length: { in: 2..32 }, :allow_blank => true
    user.validates_presence_of     :email
    user.validates_presence_of     :full_name
    user.validates                 :password, length: { minimum: 6, on: :create }
    user.validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    user.validates                 :email, uniqueness: true
  end

  def self.new_guest
    new { |u| u.guest = true }
  end

  def name
    guest ? "Guest" : email
  end

  def move_to(user)
    orders.update_all(user_id: user.id)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.new_guest_user_id
    @user = User.new_guest
    return @user.id if @user.save
  end

end
