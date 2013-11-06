class User < ActiveRecord::Base
  attr_accessor :password
  has_many :orders

  before_save   :encrypt_password

  validates_confirmation_of :password, unless: :guest?
  validates_presence_of     :password, :on => :create, unless: :guest?
  validates                 :display_name, length: { in: 2..32 }, :allow_blank => true, unless: :guest?
  validates_presence_of     :email, unless: :guest?
  validates_presence_of     :full_name, unless: :guest?
  validates                 :password, length: { minimum: 6 }, unless: :guest?
  validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, unless: :guest?
  validates                 :email, uniqueness: true, unless: :guest?

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

end
