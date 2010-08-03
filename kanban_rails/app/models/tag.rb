class Tag < ActiveRecord::Base
  has_and_belongs_to_many :cards, :uniq => true
  has_and_belongs_to_many :user
end
