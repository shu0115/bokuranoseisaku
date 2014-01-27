class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :tweets, through: :taggings
  has_many :taggings
end
