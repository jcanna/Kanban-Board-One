class Board < ActiveRecord::Base
  has_many :columns, :order => "position"
  has_many :types
  has_and_belongs_to_many :user
end
