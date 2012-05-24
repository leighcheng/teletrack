class Staff < ActiveRecord::Base
  has_many :tickets
  attr_accessible :name, :email, :password, :password_confirmation
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :email
  
  def self.authenticate(name, password)
    staff = find_by_name(name)
    if staff && staff.password_hash == BCrypt::Engine.hash_secret(password, staff.password_salt)
      staff
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
