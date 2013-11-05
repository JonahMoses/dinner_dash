class User < ActiveRecord::Base
  attr_accessor :password
  before_save   :encrypt_password
  has_many :orders

  validates_confirmation_of :password
  validates_presence_of     :password, :on => :create
  validates                 :display_name, length: { in: 2..32 }, :allow_blank => true
  validates_presence_of     :email
  validates_presence_of     :full_name
  validates                 :password, length: { minimum: 6 }
  validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates                 :email, uniqueness: true

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

end
