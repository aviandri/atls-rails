class Profile < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  attr_accessible :bio, :name, :avatar
end
