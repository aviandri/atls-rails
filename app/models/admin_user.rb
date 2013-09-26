class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles
  # attr_accessible :title, :body

  LOCATION_ROLES = TrainingLocation.all.map{|l|"#{l.name.downcase}_admin"}

  ROLES = ["superadmin"].concat LOCATION_ROLES

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def authorized_for?(training_location)
    if self.is?(ROLES[0])
      return true
    end
    if training_location.nil?
      return false
    end
    self.is?(AdminUser.location_name_to_role_name(training_location.name))
  end

  def authorized_locations
    training_location = []
    TrainingLocation.all.each do |location|
      training_location << location if self.is?(AdminUser.location_name_to_role_name(location.name))
    end
    training_location
  end

  private 
  def self.location_name_to_role_name(location_name)
    return nil if location_name.nil?
    "#{location_name.downcase}_admin"
  end
end
