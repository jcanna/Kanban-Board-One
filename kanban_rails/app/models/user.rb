class User < ActiveRecord::Base
  before_destroy :delete_links
  has_and_belongs_to_many :boards
  has_and_belongs_to_many :tags
  has_many :cards
  
  def delete_links
    boards.clear
    tags.clear
  end  
  
end
