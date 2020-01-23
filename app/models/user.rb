class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attribute :remove_image

  validates :name, :email, presence: true, uniqueness: true

  before_validation :assign_avatar

  mount_uploader :avatar, AvatarUploader

  protected

  def assign_avatar
    assign_attributes(avatar: '') if remove_image.to_boolean
  end
end
